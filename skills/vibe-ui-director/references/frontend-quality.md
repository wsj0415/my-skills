# Frontend Quality Reference

目标：把视觉设计落成可靠、响应式、可访问的生产 UI。

## Responsive

- Mobile 不是 Desktop 等比例缩小。
- Breakpoint 由内容何时失效决定，而不是只套 `sm/md/lg`。
- 高优先级内容在小屏保留，次要内容折叠或延后。
- 避免固定高度正文区导致文本溢出。
- 避免依赖脆弱绝对定位完成主要布局。
- 表格、图表、代码、长 URL 必须有明确 overflow 策略。
- 使用流式尺寸（如 `clamp()`）时确保上下界合理。

## Touch & Pointer

- 关键触摸目标建议至少约 44×44 CSS px。
- 相邻危险操作保留足够间距。
- Hover 不得承载触屏用户无法获得的关键信息。

## Keyboard

- 所有交互可通过键盘访问。
- `focus-visible` 清晰可见。
- 不无替代地移除 outline。
- Modal / Drawer 打开后管理 focus，关闭后返回触发点。
- Tab 顺序与视觉/任务顺序一致。

## Semantics

- Button 做动作，link 做导航。
- 表单控件有可关联 label。
- Heading 层级反映文档结构，而不是为了字号。
- 图标按钮提供可访问名称。
- 状态更新必要时使用合适 live region，但避免过度播报。

## Color & Contrast

- 正文和关键 UI 保持足够对比。
- 错误/成功/选中不能只依赖颜色。
- Disabled 不应淡到不可读。
- 深浅主题都检查语义色。

## Motion

- 动效服务于状态、空间关系或注意力引导。
- 遵守 `prefers-reduced-motion`。
- 避免大面积、长时间、无目的 motion。
- 动画不阻塞用户输入。

## Forms

- 尽可能在合适时机验证，不等到最后统一报错。
- 错误靠近对应字段。
- 提交后防止重复请求。
- 保留用户输入。
- Required / optional 规则一致。
- Placeholder 不替代 label。

## Performance UX

- 首屏结构尽量稳定，避免明显 layout shift。
- 图片声明尺寸并使用合适格式/加载策略。
- 首次内容加载优先 skeleton 或结构占位。
- 高频交互优先 optimistic UI（适用且可安全回滚时）。
- 不为了微小装饰引入大型依赖。

## Visual Implementation

- Token 从单一来源派生。
- 避免组件局部随意新增近似色/spacing/radius。
- CSS specificity 尽量简单，避免互相覆盖造成不可预测布局。
- 组件 variant 有清晰语义，不用大量 one-off class 修补。

## Final Browser Checks

至少检查：

- Desktop 主断点
- Mobile 主断点
- Keyboard focus path
- Loading
- Empty
- Error
- Long content / long labels
- Reduced motion（存在明显动画时）
