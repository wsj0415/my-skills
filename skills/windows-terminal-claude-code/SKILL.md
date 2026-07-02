---
name: windows-terminal-claude-code
description: Use when the user wants to run Claude Code in a visible Windows Terminal window, send custom prompts interactively, and capture the full terminal result on Windows.
---

# Windows Terminal Claude Code

Use this skill when the user wants Claude Code to run inside a visible Windows Terminal window instead of the current background agent session.

## Purpose

This skill establishes or reuses a visible Windows Terminal session for Claude Code, sends user prompts into that session, captures the full terminal output, and reports the result back with basic formatting and error handling.

## Primary Entry Point

Prefer the bundled script over re-implementing the workflow ad hoc:

```powershell
& "$PSScriptRoot\scripts\Invoke-ClaudeTerminal.ps1" -Workspace <path> -Prompt "<text>"
```

Useful variants:

```powershell
& "$PSScriptRoot\scripts\Invoke-ClaudeTerminal.ps1" -Workspace <path> -Mode Reuse
& "$PSScriptRoot\scripts\Invoke-ClaudeTerminal.ps1" -Workspace <path> -Mode New -Prompt "<text>"
& "$PSScriptRoot\scripts\Invoke-ClaudeTerminal.ps1" -Workspace <path> -CheckOnly
& "$PSScriptRoot\scripts\Invoke-ClaudeTerminal.ps1" -Workspace <path> -Prompt "<text>" -ReturnJson
```

Behavior summary:

- `-Mode Auto`: reuse when the target is unambiguous, otherwise launch a new visible session or fail on ambiguity
- `-Mode Reuse`: reuse a matching visible session when found; if the window was closed, reopen a new visible session for the same workspace
- `-Mode New`: launch a new visible Windows Terminal Claude Code session
- `-CheckOnly`: validate commands, workspace, and window resolution without sending a prompt
- `-ReturnJson`: return machine-readable status and output metadata

## Rules

- Always use a visible Windows Terminal window. Do not launch Claude Code in the background.
- Prefer reusing the correct existing Windows Terminal Claude session if one is already attached to the requested workspace.
- If the requested workspace has no visible Claude session because the window was closed, reopen a new visible terminal automatically instead of failing.
- Never send text to a generic `Windows PowerShell` window based only on a loose title match.
- Resolve the target terminal window by process tree or window handle before pasting user input.
- Verify both `wt` and `claude` are available before attempting to launch.
- Reject empty prompts or whitespace-only prompts.
- Preserve both raw output and a cleaned text version.
- Keep a local history log of prompts, target workspace, timestamps, status, and capture file paths.
- Stay compatible with common Windows Terminal setups; do not depend on custom profiles or custom JSON settings unless the user explicitly asks for them.

## Inputs

Ask for these when missing:

- the prompt to send to Claude Code
- the workspace path
- whether to reuse an existing Claude Code window or launch a new one

Optional inputs:

- preferred shell: `powershell` or `pwsh`
- timeout for waiting on Claude output
- whether to return raw output, cleaned output, or both

## Preflight

Run these checks first:

```powershell
Get-Command wt -ErrorAction SilentlyContinue
Get-Command claude -ErrorAction SilentlyContinue
```

If either command is missing:

- stop immediately
- report exactly which executable is unavailable
- suggest checking PATH or the install location
- prefer `scripts\Invoke-ClaudeTerminal.ps1 -CheckOnly` when you only need validation

## Launch Or Reuse

If you are not using the bundled script, a new visible session can be launched like this:

```powershell
Start-Process wt -ArgumentList @(
  '-w','new',
  '-d', '<workspace>',
  'powershell',
  '-NoExit',
  '-Command',
  'claude'
) -WindowStyle Normal
```

Guidelines:

- replace `<workspace>` with the requested working directory
- keep the window visible
- prefer `powershell` for broad compatibility unless the user explicitly wants `pwsh`
- wait briefly, then verify a matching `claude.exe` process exists for that workspace

If the user wants to reuse an existing session:

- inspect running `WindowsTerminal.exe`, `OpenConsole.exe`, `powershell.exe`, and `claude.exe` processes
- prefer visible Claude windows whose terminal content or footer shows the requested workspace name
- if multiple candidates match, ask the user which one to target
- if no visible matching window exists, reopen a new visible terminal for that workspace
- otherwise, use the bundled script in `-Mode Reuse`

## Window Resolution

After launch or reuse, resolve the actual `Claude Code` window.

Preferred method:

- find a visible window whose class is `CASCADIA_HOSTING_WINDOW_CLASS`
- prefer a title containing `Claude Code`, but allow dynamic session titles such as active prompt summaries
- if there are multiple matches, correlate by child process or workspace

Do not rely on a generic title like `Windows PowerShell`.

If title activation is unreliable:

- activate the window by native handle with `user32.dll`
- bring it to front before sending input

If a help dialog or other modal steals focus:

- dismiss it first
- reacquire the target Claude Code window
- only then continue

## Interactive Prompt Entry

Send the user prompt into the resolved Claude Code terminal.

Preferred pattern:

- copy the prompt to clipboard
- activate the target Claude Code window
- paste with `Ctrl+V`
- send `Enter`

Before sending:

- reject empty input
- normalize line endings
- preserve the original prompt text in history
- if the prompt was not provided as an argument, let the script ask interactively with `Read-Host`

Store a history record for each prompt in:

```text
%USERPROFILE%\.claude-terminal-history\history.jsonl
```

Each record should include:

- timestamp
- workspace
- prompt text
- launch or reuse mode
- resolved window title
- resolved window handle if available
- status
- raw capture path
- cleaned capture path

## Capture Full Claude Output

After sending the prompt, read the visible terminal buffer instead of guessing the answer.

Preferred method:

- use UI Automation to locate the `TermControl`
- read the terminal buffer through `TextPattern`
- wait until output stabilizes or the Claude prompt returns

Capture behavior:

- save the raw terminal text exactly as observed
- write the raw capture to:

```text
%USERPROFILE%\.claude-terminal-history\captures\<timestamp>-raw.txt
```

- create a cleaned text version with:
- normalized CRLF/LF
- trailing whitespace removed
- repeated separator lines collapsed only in the cleaned copy
- no loss of substantive Claude output

Write the cleaned copy to:

```text
%USERPROFILE%\.claude-terminal-history\captures\<timestamp>-clean.txt
```

## Return Format

When reporting back to the user, include:

- whether a new window was launched or an existing one was reused
- which workspace was targeted
- the full Claude result
- a cleaned text version if formatting cleanup helped readability
- any capture file paths if relevant

If the user asks "what did the Claude Code window return", answer only after reading the terminal buffer.

## Error Handling

Handle these cases explicitly:

- `WT_NOT_FOUND`
- `CLAUDE_NOT_FOUND`
- `CLAUDE_WINDOW_NOT_FOUND`
- `TERM_NOT_FOUND`
- `EMPTY_PROMPT`
- `MULTIPLE_CLAUDE_WINDOWS`
- `FOCUS_STOLEN_BY_MODAL`
- `CLAUDE_LAUNCH_FAILED`
- `OUTPUT_CAPTURE_FAILED`
- `EXECUTION_TIMEOUT`

Behavior by case:

- missing `wt` or `claude`: stop and report the missing dependency
- empty prompt: ask the user for a non-empty prompt
- multiple Claude windows: ask the user to choose instead of guessing
- wrong window targeted: stop, resolve again by handle or process tree, and retry safely
- launch failure: report the command used and the failing step
- capture failure: tell the user that Claude may have run, but output could not be read reliably
- timeout: return partial output if available and state that execution may still be in progress

## Validation

Consider the workflow successful only if all of these are true:

- a visible Windows Terminal window is open
- the correct Claude Code session was targeted
- the prompt was sent into that session
- output was captured from the terminal buffer
- the result was returned to the user without fabricating missing content
- a history record was written

## Compatibility Notes

- support standard Windows Terminal installs exposed as `wt`
- support standard `powershell` terminals without requiring profile customization
- avoid assumptions about tab order, color scheme, or custom key bindings
- prefer handle-based activation when title-based activation is ambiguous
- if the user already has multiple terminal tabs open, isolate the correct Claude Code tab before typing
