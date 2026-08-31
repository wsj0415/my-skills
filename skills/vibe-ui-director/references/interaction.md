# Interaction Design Reference

目标：确保界面不仅“截图好看”，而且用户实际操作时状态完整、反馈及时、错误可恢复。

## Component State Model

关键交互组件按适用范围检查：

| State | 要求 |
|---|---|
| Default | 可辨认、可理解 affordance |
| Hover | 桌面端提供轻量反馈，不产生布局跳动 |
| Focus-visible | 键盘焦点始终可见 |
| Active / Pressed | 点击/按压立即反馈 |
| Loading | 防止重复提交，显示进行中 |
| Disabled | 说明不可用状态；必要时解释原因 |
| Error | 文本 + 视觉提示 + 修复方法 |
| Success | 明确动作已完成 |
| Empty | 解释为何为空，并提供下一步 |
| Skeleton | 与将出现的内容结构尽量一致 |

不是所有组件都需要 10 个状态，但关键流程不能遗漏实际会发生的状态。

## Response Time

- ≤100ms：用户应感到直接操控；至少有 pressed / state change。
- 100ms–1s：轻量 loading 或 optimistic feedback。
- 1s–10s：明确 progress / skeleton / status。
- >10s：如果业务允许，转为后台任务，允许离开当前页面，并在完成后通知。

## Feedback Hierarchy

反馈强度应与动作影响成比例：

- 微小状态变化：inline visual feedback。
- 普通保存：inline status 或 toast。
- 长耗时任务：progress/status area。
- 高风险失败：明确错误区域 + recovery action。

避免所有操作都弹 Toast。

## Error Recovery

每个错误状态应尽量回答：

1. What happened?
2. Why, if useful?
3. What can the user do now?
4. Is their work preserved?

错误文案示例：

差：`Something went wrong.`

好：`API key 无效或已过期。请在 Account Settings 中生成新 Key，然后重新保存。`

## Preserve User Work

- 表单校验失败不得清空输入。
- 长表单应考虑 draft / autosave。
- 页面离开可能丢数据时应阻止意外丢失。
- 异步失败后尽量允许 retry，而不是重新开始整个流程。

## Destructive Actions

优先级：

1. 可逆操作 + Undo
2. 二次确认
3. 输入名称确认（极高风险）

不要给每个删除动作都加阻塞 modal。

## Flow Review

对关键用户流程检查：

```text
Entry → Trigger → Action → Feedback → Outcome
                    ↓
                  Error → Recovery → Resume
```

必须明确：

- 用户从哪里开始？
- primary path 是否最短？
- 分支在哪里？
- 错误发生后如何继续？
- 用户如何退出？
- Back 行为是否符合预期？

## Microcopy

- Button 使用真实动作：`保存 API Key` > `提交`
- 同一动作跨流程保持同一名字。
- 用户语言优先于系统实现语言。
- 空状态给方向，不写情绪化废话。
- 避免解释 UI 自己本应表达清楚的东西。

## Motion

动效优先用于：

- 状态变化
- 空间关系
- 进入/退出层级
- 操作反馈

通常避免：

- 所有元素统一 fade-up
- 所有 card hover lift
- 纯装饰无限循环 motion

必须尊重 `prefers-reduced-motion`。
