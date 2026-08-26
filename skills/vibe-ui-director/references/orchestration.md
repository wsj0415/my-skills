# Orchestration Protocol

目标：让 Vibe UI Director 在单 Agent 环境和支持子 Agent / 多工具的环境中都能稳定执行，不把所有设计规则一次塞进上下文。

## Capability Detection

开始任务时先识别环境能力：

- 是否能读取现有代码？
- 是否能搜索/读取 URL？
- 是否能使用浏览器或截图？
- 是否能执行代码、启动 dev server？
- 是否支持并行子 Agent？

根据可用能力降级，不因缺少某个工具阻塞设计。

## Logical Roles

以下是**逻辑角色**，不是必须真的创建多个 Agent：

### 1. Product Interpreter
负责：
- 用户、任务、业务对象
- primary action
- 内容密度
- 现有约束

输出：`Product Brief`

### 2. Reference Researcher
仅在需要时启用。
负责：
- 3–5 个相关参考
- Evidence Packet
- 可迁移 Design Inputs

读取：`reference-mining.md`

### 3. Art Director
负责：
- Design Thesis
- Visual Vocabulary
- Signature
- Aesthetic Risk
- Design System tokens

必须以 Product Brief 和 reference-derived rules 为输入，不得只凭通用“现代/高级”标签。

### 4. Interaction Designer
负责：
- flow
- state completeness
- feedback timing
- loading/error/empty/recovery

读取：`interaction.md`

### 5. Frontend Builder
负责：
- 在既有框架和组件边界内实现
- 复用 token/components
- semantic HTML
- responsive implementation

读取：`frontend-quality.md`

### 6. Visual Judge
环境支持渲染时启用。
负责：
- screenshot-first review
- desktop/mobile comparison
- top findings
- regression check

读取：`visual-judge.md`

### 7. Anti-Slop Reviewer
负责：
- structural sameness
- generic AI signatures
- fabricated proof
- gratuitous decoration

读取：`anti-ai-slop.md`

## Single-Agent Execution

如果没有子 Agent，严格按阶段顺序在同一 Agent 内切换角色：

```text
Product Interpreter
  → optional Reference Researcher
  → Art Director
  → Interaction Designer
  → Frontend Builder
  → Visual Judge
  → Anti-Slop Reviewer
  → Fix
```

不要同时加载所有 reference。

## Multi-Agent Execution

如果环境支持子 Agent，可并行执行互不依赖的分析：

```text
                     ┌─ Reference Researcher ─┐
Product Interpreter ─┤                        ├→ Art Director
                     └─ Existing UI Auditor ──┘
                                               ↓
                          ┌─ Interaction Designer
Art Direction / Tokens ───┤
                          └─ Frontend Builder
                                               ↓
                            Rendered Artifact
                                               ↓
                 ┌─────────────┴─────────────┐
             Visual Judge             Anti-Slop Reviewer
                 └─────────────┬─────────────┘
                               ↓
                           Fix Pass
```

并行角色只输出 findings / constraints，不同时修改同一文件，避免冲突。

## Existing Project Preflight

任何 `redesign` / `polish` / existing-code `create` 在写代码前先读取：

1. `DESIGN.md` / `design.md`（若存在）
2. package/framework config
3. global CSS / Tailwind config / tokens
4. layout / route boundary
5. shared components
6. fonts and icon system
7. current responsive conventions

### Rule

现有明确 Design System > Vibe UI Director 默认设计倾向。

除非用户明确要求重建品牌系统，否则不要“为了更好看”覆盖已经一致的系统。

## Scope Routing

先判断 scope：

### Component Scope
适用于：button/input/modal/card/table-row/filter/date-picker 等单组件任务。

保留：
- tokens
- interaction states
- accessibility
- visual consistency
- anti-slop

跳过：
- page macrostructure
- hero
- nav/footer
- Reference Mining（通常）

### Section Scope
适用于：pricing section、settings panel、dashboard region。

只处理该 section 的 hierarchy、states、responsive 和与全局系统一致性。

### Page Scope
执行完整流程。

### Multi-page / Product Scope
先建立共享 `Design Contract`，再逐页面工作。不要让不同页面为了“独特性”变成不同产品。

## Design Contract

大型任务内部建立：

```markdown
## Design Contract
Product thesis: ...
Primary audience: ...
Brand traits: ...
Color roles: ...
Typography roles: ...
Spacing/radius/elevation: ...
Interaction stance: ...
Motion stance: ...
Signature pattern: ...
Forbidden defaults: ...
```

后续页面必须继承 Contract。

## Change Safety Rail

设计任务不等于重构许可。

默认：
- in-place edit
- additive components
- token consolidation
- small refactor required by UI correctness

禁止未经用户明确要求：
- 删除整个 route tree
- 重写状态管理
- 更换框架
- 重做后端 API
- 大量删除现有业务组件
- 以 redesign 为理由改变业务语义

如果视觉目标必须依赖大规模架构调整，明确列出原因和最小改动范围。

## Iteration Budget

默认：

- Art Direction critique：1 次
- Build 后 visual iteration：最多 3 次
- 每轮 findings：最多 5 个

超过预算的条件：
- 仍有 Critical 问题
- 用户明确要求深入打磨
- 修复出现 regression

## Stop Rule

不要因为还能调整细节就继续。

满足以下条件停止：

- Product task 清楚
- Design system coherent
- Critical = 0
- High ≤ 1
- Desktop/mobile healthy
- key states complete
- no obvious AI-slop signature
- 连续一轮没有显著结构级改进

## Conflict Resolution

规则冲突时优先级：

1. 用户明确要求
2. 现有产品 Design System / brand constraints
3. usability / accessibility / correctness
4. business/task hierarchy
5. Vibe UI Director design principles
6. external references
7. aesthetic novelty

绝不为了“去 AI 味”牺牲可用性或品牌一致性。
