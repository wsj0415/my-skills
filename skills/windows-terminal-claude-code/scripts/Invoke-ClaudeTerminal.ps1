[CmdletBinding()]
param(
    [string]$Prompt,
    [string]$Workspace = (Get-Location).Path,
    [ValidateSet('Auto', 'New', 'Reuse')]
    [string]$Mode = 'Auto',
    [ValidateSet('powershell', 'pwsh')]
    [string]$Shell = 'powershell',
    [int]$TimeoutSeconds = 90,
    [int]$PollIntervalMs = 1000,
    [int]$StablePolls = 2,
    [switch]$CheckOnly,
    [switch]$ReturnJson
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName UIAutomationClient, UIAutomationTypes
Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class ClaudeTerminalWinApi {
    [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool BringWindowToTop(IntPtr hWnd);
}
"@

function New-ClaudeTerminalError {
    param(
        [Parameter(Mandatory = $true)][string]$Code,
        [Parameter(Mandatory = $true)][string]$Message
    )

    $ex = New-Object System.Exception($Message)
    $ex.Data['ClaudeTerminalCode'] = $Code
    return $ex
}

function Get-RequiredCommand {
    param([Parameter(Mandatory = $true)][string]$Name)

    $command = Get-Command $Name -ErrorAction SilentlyContinue
    if (-not $command) {
        throw (New-ClaudeTerminalError -Code ($Name.ToUpperInvariant() + '_NOT_FOUND') -Message "Required command '$Name' was not found in PATH.")
    }
    return $command.Source
}

function Get-HistoryPaths {
    $root = Join-Path $env:USERPROFILE '.claude-terminal-history'
    $captures = Join-Path $root 'captures'
    if (-not (Test-Path $captures)) {
        New-Item -ItemType Directory -Force -Path $captures | Out-Null
    }

    return [pscustomobject]@{
        Root = $root
        Captures = $captures
        History = Join-Path $root 'history.jsonl'
    }
}

function Write-HistoryRecord {
    param(
        [Parameter(Mandatory = $true)][pscustomobject]$Record,
        [Parameter(Mandatory = $true)][string]$Path
    )

    ($Record | ConvertTo-Json -Compress -Depth 6) + [Environment]::NewLine | Add-Content -Path $Path -Encoding UTF8
}

function Get-ClaudeProcessCandidates {
    param([Parameter(Mandatory = $true)][string]$WorkspacePath)

    $escaped = [Regex]::Escape($WorkspacePath)
    $candidates = Get-CimInstance Win32_Process |
        Where-Object { $_.Name -ieq 'claude.exe' -and $_.CommandLine -match $escaped } |
        Select-Object ProcessId, ParentProcessId, Name, CommandLine

    return @($candidates)
}

function Get-ProcessSnapshot {
    return @(
        Get-CimInstance Win32_Process |
            Select-Object ProcessId, ParentProcessId, Name, CommandLine
    )
}

function Get-DescendantProcesses {
    param(
        [Parameter(Mandatory = $true)][object[]]$ProcessSnapshot,
        [Parameter(Mandatory = $true)][int]$RootProcessId
    )

    $childrenByParent = @{}
    foreach ($process in $ProcessSnapshot) {
        $parentId = [int]$process.ParentProcessId
        if (-not $childrenByParent.ContainsKey($parentId)) {
            $childrenByParent[$parentId] = New-Object System.Collections.Generic.List[object]
        }
        $childrenByParent[$parentId].Add($process) | Out-Null
    }

    $results = New-Object System.Collections.Generic.List[object]
    $queue = New-Object System.Collections.Generic.Queue[int]
    $queue.Enqueue($RootProcessId)

    while ($queue.Count -gt 0) {
        $current = $queue.Dequeue()
        if (-not $childrenByParent.ContainsKey($current)) {
            continue
        }

        foreach ($child in $childrenByParent[$current]) {
            $results.Add($child) | Out-Null
            $queue.Enqueue([int]$child.ProcessId)
        }
    }

    return @($results)
}

function Get-ClaudeWindows {
    $root = [System.Windows.Automation.AutomationElement]::RootElement
    $all = $root.FindAll(
        [System.Windows.Automation.TreeScope]::Children,
        [System.Windows.Automation.Condition]::TrueCondition
    )

    $windows = @()
    for ($i = 0; $i -lt $all.Count; $i++) {
        $element = $all.Item($i)
        if ($element.Current.ClassName -eq 'CASCADIA_HOSTING_WINDOW_CLASS') {
            $windows += [pscustomobject]@{
                Name = $element.Current.Name
                ClassName = $element.Current.ClassName
                NativeWindowHandle = $element.Current.NativeWindowHandle
                ProcessId = $element.Current.ProcessId
                Element = $element
            }
        }
    }

    return $windows
}

function Get-ClaudeWindowsForWorkspace {
    param([Parameter(Mandatory = $true)][string]$WorkspacePath)

    $windows = @(Get-ClaudeWindows)
    if ($windows.Count -eq 0) {
        return @()
    }

    $workspaceLeaf = Split-Path -Leaf $WorkspacePath
    $markers = @($WorkspacePath, $workspaceLeaf) | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -Unique
    $matches = New-Object System.Collections.Generic.List[object]

    foreach ($window in $windows) {
        try {
            $term = Get-ClaudeTerminalControl -WindowElement $window.Element
            $text = Get-TerminalText -TerminalControl $term
            foreach ($marker in $markers) {
                if ($text -like ('*' + $marker + '*')) {
                    $matches.Add($window) | Out-Null
                    break
                }
            }
        }
        catch {
        }
    }

    return @($matches.ToArray())
}

function Get-ClaudeTerminalControl {
    param([Parameter(Mandatory = $true)]$WindowElement)

    $condition = New-Object System.Windows.Automation.PropertyCondition(
        [System.Windows.Automation.AutomationElement]::ClassNameProperty,
        'TermControl'
    )
    $term = $WindowElement.FindFirst([System.Windows.Automation.TreeScope]::Descendants, $condition)
    if (-not $term) {
        throw (New-ClaudeTerminalError -Code 'TERM_NOT_FOUND' -Message 'Could not locate the TermControl inside the Claude Code window.')
    }
    return $term
}

function Get-TerminalText {
    param([Parameter(Mandatory = $true)]$TerminalControl)

    try {
        $textPattern = $TerminalControl.GetCurrentPattern([System.Windows.Automation.TextPattern]::Pattern)
        return $textPattern.DocumentRange.GetText(-1)
    }
    catch {
        throw (New-ClaudeTerminalError -Code 'OUTPUT_CAPTURE_FAILED' -Message ('Failed to read terminal text via UI Automation: ' + $_.Exception.Message))
    }
}

function Get-ForegroundClaudeWindow {
    $windows = Get-ClaudeWindows
    if ($windows.Count -eq 1) {
        return $windows[0]
    }
    return $null
}

function Select-ClaudeWindowCandidate {
    param([Parameter(Mandatory = $true)][object[]]$Windows)

    if ($Windows.Count -eq 1) {
        return $Windows[0]
    }

    $preferred = @(
        $Windows | Where-Object { $_.Name -like '*Claude Code*' },
        $Windows | Where-Object { $_.Name -and $_.Name -notlike '*cmd.exe*' }
    )

    foreach ($group in $preferred) {
        $items = @($group)
        if ($items.Count -eq 1) {
            return $items[0]
        }
    }

    return $null
}

function Resolve-ClaudeWindow {
    param(
        [Parameter(Mandatory = $true)][string]$WorkspacePath,
        [Parameter(Mandatory = $true)][string]$RequestedMode,
        [int]$WaitSeconds = 12,
        [string]$ShellName = 'powershell',
        [bool]$AllowLaunchFallback = $true
    )

    $originalMode = $RequestedMode

    if ($RequestedMode -eq 'Reuse') {
        $windows = @(Get-ClaudeWindowsForWorkspace -WorkspacePath $WorkspacePath)
        if ($windows.Count -eq 0) {
            if ($AllowLaunchFallback) {
                $RequestedMode = 'New'
            }
            else {
                throw (New-ClaudeTerminalError -Code 'CLAUDE_WINDOW_NOT_FOUND' -Message 'No visible Claude Code window was found to reuse for the requested workspace.')
            }
        }
        else {
            $selected = Select-ClaudeWindowCandidate -Windows $windows
            if ($selected) {
                return [pscustomobject]@{
                    Window = $selected
                    ResolvedMode = 'Reuse'
                }
            }
            if ($windows.Count -gt 1) {
                throw (New-ClaudeTerminalError -Code 'MULTIPLE_CLAUDE_WINDOWS' -Message 'Multiple visible Claude Code windows were found for the requested workspace. Narrow the target or choose one explicitly.')
            }
            return [pscustomobject]@{
                Window = $windows[0]
                ResolvedMode = 'Reuse'
            }
        }
    }

    $existingCount = @(Get-ClaudeWindowsForWorkspace -WorkspacePath $WorkspacePath).Count
    $launchNeeded = $RequestedMode -eq 'New'

    if ($RequestedMode -eq 'Auto') {
        $windows = @(Get-ClaudeWindowsForWorkspace -WorkspacePath $WorkspacePath)
        if ($windows.Count -eq 1) {
            return [pscustomobject]@{
                Window = $windows[0]
                ResolvedMode = 'Auto-Reuse'
            }
        }
        if ($windows.Count -gt 1) {
            throw (New-ClaudeTerminalError -Code 'MULTIPLE_CLAUDE_WINDOWS' -Message 'Auto mode found multiple Claude candidates. Use Reuse or New with a narrower target.')
        }
        $launchNeeded = $true
    }

    if ($launchNeeded) {
        $args = @(
            '-w', 'new',
            '-d', $WorkspacePath,
            $ShellName,
            '-NoExit',
            '-Command',
            'claude'
        )
        try {
            Start-Process wt -ArgumentList $args -WindowStyle Normal | Out-Null
        }
        catch {
            throw (New-ClaudeTerminalError -Code 'CLAUDE_LAUNCH_FAILED' -Message ('Failed to launch Windows Terminal with Claude Code: ' + $_.Exception.Message))
        }

        $deadline = (Get-Date).AddSeconds($WaitSeconds)
        do {
            Start-Sleep -Milliseconds 500
            $windows = @(Get-ClaudeWindowsForWorkspace -WorkspacePath $WorkspacePath)
            $selected = $null
            if ($windows.Count -gt 0) {
                $selected = Select-ClaudeWindowCandidate -Windows $windows
            }
            if ($selected) {
                $resolvedMode = if ($originalMode -eq 'Reuse') { 'Reuse-Reopened' } else { 'New' }
                return [pscustomobject]@{
                    Window = $selected
                    ResolvedMode = $resolvedMode
                }
            }
            if ($windows.Count -gt $existingCount) {
                $resolvedMode = if ($originalMode -eq 'Reuse') { 'Reuse-Reopened' } else { 'New' }
                return [pscustomobject]@{
                    Window = $windows[-1]
                    ResolvedMode = $resolvedMode
                }
            }
        } while ((Get-Date) -lt $deadline)

        $foregroundWindows = @(Get-ClaudeWindowsForWorkspace -WorkspacePath $WorkspacePath)
        $foreground = $null
        if ($foregroundWindows.Count -gt 0) {
            $foreground = Select-ClaudeWindowCandidate -Windows $foregroundWindows
        }
        if ($foreground) {
            $resolvedMode = if ($originalMode -eq 'Reuse') { 'Reuse-Reopened' } else { 'New' }
            return [pscustomobject]@{
                Window = $foreground
                ResolvedMode = $resolvedMode
            }
        }

        throw (New-ClaudeTerminalError -Code 'CLAUDE_WINDOW_NOT_FOUND' -Message 'Claude Code launched, but no visible Claude Code window could be resolved.')
    }

    throw (New-ClaudeTerminalError -Code 'CLAUDE_WINDOW_NOT_FOUND' -Message 'No Claude Code window could be resolved.')
}

function Activate-ClaudeWindow {
    param([Parameter(Mandatory = $true)]$Window)

    $hwnd = [IntPtr]$Window.NativeWindowHandle
    [ClaudeTerminalWinApi]::ShowWindowAsync($hwnd, 9) | Out-Null
    Start-Sleep -Milliseconds 200
    [ClaudeTerminalWinApi]::BringWindowToTop($hwnd) | Out-Null
    Start-Sleep -Milliseconds 200
    [ClaudeTerminalWinApi]::SetForegroundWindow($hwnd) | Out-Null
    Start-Sleep -Milliseconds 300
}

function Send-ClaudePrompt {
    param(
        [Parameter(Mandatory = $true)][string]$PromptText,
        [Parameter(Mandatory = $true)]$Window
    )

    if ([string]::IsNullOrWhiteSpace($PromptText)) {
        throw (New-ClaudeTerminalError -Code 'EMPTY_PROMPT' -Message 'Prompt cannot be empty.')
    }

    Activate-ClaudeWindow -Window $Window
    Set-Clipboard -Value $PromptText
    $wshell = New-Object -ComObject WScript.Shell
    Start-Sleep -Milliseconds 200
    $wshell.SendKeys('^v')
    Start-Sleep -Milliseconds 150
    $wshell.SendKeys('{ENTER}')
}

function Wait-ClaudeOutput {
    param(
        [Parameter(Mandatory = $true)]$TerminalControl,
        [string]$BaselineText,
        [int]$TimeoutInSeconds,
        [int]$IntervalMs,
        [int]$StableRounds
    )

    $deadline = (Get-Date).AddSeconds($TimeoutInSeconds)
    $lastText = $BaselineText
    $hasChanged = $false
    $stableCount = 0

    do {
        Start-Sleep -Milliseconds $IntervalMs
        $currentText = Get-TerminalText -TerminalControl $TerminalControl

        if ($currentText -ne $lastText) {
            $lastText = $currentText
            $hasChanged = $true
            $stableCount = 0
            continue
        }

        if ($hasChanged) {
            $stableCount++
            if ($stableCount -ge $StableRounds) {
                return [pscustomobject]@{
                    Text = $currentText
                    TimedOut = $false
                }
            }
        }
    } while ((Get-Date) -lt $deadline)

    return [pscustomobject]@{
        Text = $lastText
        TimedOut = $true
    }
}

function Format-CleanText {
    param([Parameter(Mandatory = $true)][string]$Text)

    $normalized = $Text -replace "`r`n", "`n"
    $lines = $normalized -split "`n" | ForEach-Object { $_.TrimEnd() }
    $joined = ($lines -join "`n")
    $joined = $joined -replace "([`n]){4,}", "`n`n`n"
    return $joined.Trim()
}

function Get-CommonPrefixLength {
    param(
        [Parameter(Mandatory = $true)][string]$First,
        [Parameter(Mandatory = $true)][string]$Second
    )

    $limit = [Math]::Min($First.Length, $Second.Length)
    for ($i = 0; $i -lt $limit; $i++) {
        if ($First[$i] -ne $Second[$i]) {
            return $i
        }
    }
    return $limit
}

function Get-TerminalDeltaText {
    param(
        [Parameter(Mandatory = $true)][string]$Before,
        [Parameter(Mandatory = $true)][string]$After
    )

    if ($After.Length -le $Before.Length) {
        return $After
    }

    $prefixLength = Get-CommonPrefixLength -First $Before -Second $After
    if ($prefixLength -ge $After.Length) {
        return ''
    }

    return $After.Substring($prefixLength).Trim()
}

function Get-TerminalResponseText {
    param(
        [Parameter(Mandatory = $true)][string]$Before,
        [Parameter(Mandatory = $true)][string]$After,
        [Parameter(Mandatory = $true)][string]$PromptText
    )

    $delta = Get-TerminalDeltaText -Before $Before -After $After
    $normalizedAfter = $After -replace "`r`n", "`n"
    $normalizedPrompt = $PromptText -replace "`r`n", "`n"

    $promptIndex = $normalizedAfter.LastIndexOf($normalizedPrompt, [System.StringComparison]::Ordinal)
    if ($promptIndex -ge 0) {
        $lineStart = $normalizedAfter.LastIndexOf("`n", [Math]::Max(0, $promptIndex - 1))
        if ($lineStart -lt 0) {
            $lineStart = 0
        }
        else {
            $lineStart += 1
        }

        $candidate = $normalizedAfter.Substring($lineStart).Trim()
        if (-not [string]::IsNullOrWhiteSpace($candidate)) {
            return $candidate
        }
    }

    return $delta
}

function Write-CaptureFiles {
    param(
        [Parameter(Mandatory = $true)][string]$RawText,
        [Parameter(Mandatory = $true)][pscustomobject]$Paths
    )

    $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
    $rawPath = Join-Path $Paths.Captures ($stamp + '-raw.txt')
    $cleanPath = Join-Path $Paths.Captures ($stamp + '-clean.txt')
    $cleanText = Format-CleanText -Text $RawText

    [System.IO.File]::WriteAllText($rawPath, $RawText, [System.Text.UTF8Encoding]::new($false))
    [System.IO.File]::WriteAllText($cleanPath, $cleanText, [System.Text.UTF8Encoding]::new($false))

    return [pscustomobject]@{
        RawPath = $rawPath
        CleanPath = $cleanPath
        CleanText = $cleanText
    }
}

$historyPaths = Get-HistoryPaths
$status = 'started'
$windowTitle = $null
$windowHandle = $null
$rawPath = $null
$cleanPath = $null
$resultText = $null
$deltaText = $null
$cleanDeltaText = $null
$timedOut = $false
$requestedMode = $Mode
$effectiveMode = $Mode

try {
    $null = Get-RequiredCommand -Name 'wt'
    $null = Get-RequiredCommand -Name 'claude'

    if (-not (Test-Path $Workspace -PathType Container)) {
        throw (New-ClaudeTerminalError -Code 'INVALID_WORKSPACE' -Message "Workspace path '$Workspace' does not exist or is not a directory.")
    }

    if (-not $PSBoundParameters.ContainsKey('Prompt') -and -not $CheckOnly) {
        $Prompt = Read-Host 'Enter Claude prompt'
    }

    if (-not $CheckOnly -and [string]::IsNullOrWhiteSpace($Prompt)) {
        throw (New-ClaudeTerminalError -Code 'EMPTY_PROMPT' -Message 'Prompt cannot be empty.')
    }

    $resolved = Resolve-ClaudeWindow -WorkspacePath $Workspace -RequestedMode $Mode -ShellName $Shell -AllowLaunchFallback (-not $CheckOnly)
    $window = $resolved.Window
    $effectiveMode = $resolved.ResolvedMode
    $windowTitle = $window.Name
    $windowHandle = $window.NativeWindowHandle
    $terminalControl = Get-ClaudeTerminalControl -WindowElement $window.Element
    $baseline = Get-TerminalText -TerminalControl $terminalControl

    if ($CheckOnly) {
        $status = 'validated'
        $result = [pscustomobject]@{
            status = $status
            workspace = $Workspace
            requestedMode = $requestedMode
            mode = $effectiveMode
            windowTitle = $windowTitle
            windowHandle = $windowHandle
        }
        if ($ReturnJson) {
            $result | ConvertTo-Json -Depth 4
        }
        else {
            "Validation succeeded."
            "Workspace: $Workspace"
            "Window: $windowTitle"
            "Handle: $windowHandle"
        }
        return
    }

    Send-ClaudePrompt -PromptText $Prompt -Window $window
    $capture = Wait-ClaudeOutput -TerminalControl $terminalControl -BaselineText $baseline -TimeoutInSeconds $TimeoutSeconds -IntervalMs $PollIntervalMs -StableRounds $StablePolls
    $resultText = $capture.Text
    $deltaText = Get-TerminalResponseText -Before $baseline -After $resultText -PromptText $Prompt
    $cleanDeltaText = Format-CleanText -Text $deltaText
    $timedOut = $capture.TimedOut
    $files = Write-CaptureFiles -RawText $resultText -Paths $historyPaths
    $rawPath = $files.RawPath
    $cleanPath = $files.CleanPath
    $status = if ($timedOut) { 'timeout' } else { 'completed' }
    if ([string]::IsNullOrWhiteSpace($cleanDeltaText)) {
        $cleanDeltaText = $files.CleanText
    }

    $result = [pscustomobject]@{
        status = $status
        workspace = $Workspace
        requestedMode = $requestedMode
        mode = $effectiveMode
        windowTitle = $windowTitle
        windowHandle = $windowHandle
        timedOut = $timedOut
        rawCapturePath = $rawPath
        cleanCapturePath = $cleanPath
        output = $cleanDeltaText
        fullBufferOutput = $files.CleanText
    }

    if ($ReturnJson) {
        $result | ConvertTo-Json -Depth 6
    }
    else {
        "Status: $status"
        "Workspace: $Workspace"
        "Window: $windowTitle"
        "Raw capture: $rawPath"
        "Clean capture: $cleanPath"
        ''
        'Claude Output:'
        $cleanDeltaText
    }
}
catch {
    $code = $_.Exception.Data['ClaudeTerminalCode']
    if (-not $code) {
        $code = 'UNEXPECTED_ERROR'
    }
    $status = 'failed'
    $result = [pscustomobject]@{
        status = $status
        code = $code
        message = $_.Exception.Message
        workspace = $Workspace
        requestedMode = $requestedMode
        mode = $effectiveMode
        windowTitle = $windowTitle
        windowHandle = $windowHandle
        rawCapturePath = $rawPath
        cleanCapturePath = $cleanPath
    }

    if ($ReturnJson) {
        $result | ConvertTo-Json -Depth 6
    }
    else {
        "Status: failed"
        "Code: $code"
        "Message: $($_.Exception.Message)"
    }

    exit 1
}
finally {
    $record = [pscustomobject]@{
        timestamp = (Get-Date).ToString('o')
        workspace = $Workspace
        prompt = $Prompt
        requestedMode = $requestedMode
        mode = $effectiveMode
        status = $status
        windowTitle = $windowTitle
        windowHandle = $windowHandle
        rawCapturePath = $rawPath
        cleanCapturePath = $cleanPath
        timedOut = $timedOut
    }

    try {
        Write-HistoryRecord -Record $record -Path $historyPaths.History
    }
    catch {
    }
}
