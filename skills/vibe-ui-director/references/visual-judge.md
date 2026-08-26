# Browser Visual Judge

目标：把“看起来不错”变成一个可重复的视觉验收流程。只在环境支持浏览器、截图、Playwright、DevTools 或等价视觉能力时启用。

## Principle

代码是实现证据，不是视觉证据。

如果页面可以运行，必须优先看实际渲染结果。不要仅因为组件结构、Tailwind class 或 CSS token 看起来合理就判断 UI 已完成。

## Capture Matrix

页面级任务至少检查：

- Desktop：约 1440px 宽。
- Mobile：约 375px 宽。

高价值页面或 responsive 风险较高时再加：

- 320px：窄屏压力测试。
- 414px：大手机。
- 768px：平板/窄桌面临界状态。

组件级任务应同时展示关键状态，而不是只截图 default 状态。

## Pass 0 — Runtime Sanity

视觉评价前先确认：

- 页面可加载。
- 无明显 runtime error。
- 无控制台中断性错误。
- 主要内容真实渲染，不是 skeleton 永久停留。
- 字体、图片和图标资源成功加载。

运行失败时先修运行问题，不进行美学评分。

## Pass 1 — First 5 Seconds

暂时忽略代码，只看截图并回答：

1. 这是什么产品/页面？
2. 我现在最重要的任务是什么？
3. 我应该先看哪里？
4. 页面最醒目的东西是否真的是最重要的东西？
5. 有没有明显的模板感或 AI 生成痕迹？

如果 1–3 中任意两项无法快速回答，优先回到 hierarchy / IA，不要继续 polish。

## Pass 2 — Squint Test

缩小或模糊页面观察“大块结构”。

检查：

- 是否存在一个明确主焦点？
- 内容块是否全部同权？
- whitespace 是否形成节奏还是随机空洞？
- CTA 是否与其他按钮竞争？
- Dashboard 是否被 KPI card wall 占据而看不到主要工作区？

Squint Test 失败通常是结构问题，不是色值问题。

## Pass 3 — Alignment & Rhythm

沿页面视觉扫描：

- 左/右边界是否稳定？
- 标题、正文、控件是否共享合理 alignment anchors？
- 相似 section 是否具有可预测但不过度机械的 rhythm？
- spacing 是否体现内容关系：相关更近、不相关更远？
- 是否有孤立的 8px/12px/20px 随机间距破坏系统？
- 行长是否导致阅读困难？

不要为了“统一”把所有 section 间距设成相同。节奏应反映语义关系。

## Pass 4 — Typography

从 screenshot 判断：

- heading 是否压倒真实内容？
- type scale 是否有足够区分但不夸张？
- body 是否能连续阅读？
- label / metadata / utility text 是否仍可辨识？
- 是否过度依赖 bold 来制造层级？
- 数字、表格、代码或时间信息是否需要 tabular/mono 特性？

如果字体选择很“独特”但降低扫描效率，优先可读性。

## Pass 5 — Surface & Color

检查：

- surface 层级是否真的需要 card / border / shadow？
- 相邻区域能否仅靠 spacing 和 typography 区分？
- accent 是否集中在真正重要位置？
- semantic colors 是否一致？
- 是否存在 gradient / glow / blur 仅用于填空？
- 大面积纯色/深色是否影响内容层级？

优先删除效果，而不是继续叠加效果。

## Pass 6 — Interaction Evidence

通过真实交互或状态预览检查：

- hover 不引发布局跳动。
- focus-visible 清晰。
- active/pressed 有即时反馈。
- loading 能防止重复提交。
- disabled 原因在必要时可理解。
- error 紧邻问题位置并给出修复路径。
- success 不阻断下一步操作。
- empty state 提供合理 next action。
- destructive action 有 undo 或合理确认。

不要仅检查按钮是否“有 hover”。判断反馈是否与用户动作匹配。

## Pass 7 — Responsive Recomposition

Mobile 不是 Desktop 按比例缩小。

逐项比较 Desktop / Mobile：

- 信息优先级是否重新排序？
- 多栏是否在正确内容断点重排？
- 次要内容是否折叠/延后？
- 主操作是否仍容易触达？
- 表格是否有适当响应策略，而不是简单 horizontal scroll 作为默认答案？
- 标题是否合理换行？
- 图片是否裁切正确？
- 是否出现横向溢出？
- sticky/fixed 元素是否遮挡内容？

移动端如果只是“能显示”，不代表通过。

## Pass 8 — Anti-Slop Visual Scan

参考 `anti-ai-slop.md`，特别寻找：

- 过度居中
- 3-card symmetry
- gradient headline
- glass / glow
- uniform rounded containers
- icon-in-colored-square repetition
- fake dashboard/device chrome
- repeated eyebrow + heading + paragraph
- meaningless badges
- excessive entrance animations

每项都执行 Delete Test：删除后信息是否变差？如果不会，删除或弱化。

## Finding Format

每轮最多选 5 个问题：

```markdown
### Finding 1 — <short name>
Severity: High
Evidence: <截图中具体观察，不写抽象审美词>
Why it matters: <任务/扫描/可信度/可访问性影响>
Change: <具体修改>
Expected result: <修改后应改善什么>
```

“页面不够高级”“可以更有设计感”不是有效 Evidence。

## Iteration Policy

推荐流程：

```text
Capture
  → Judge
  → Rank top 5
  → Fix high-impact set
  → Capture again
  → Compare
```

最多默认进行 3 轮视觉迭代。

每轮必须能说明：

- 改了哪些高影响问题。
- 哪个评分维度提升。
- 是否引入新的 regression。

## Stop Conditions

满足以下条件即可停止，不追求无限 polish：

- 无 Critical finding。
- High finding ≤ 1，且不阻塞核心任务。
- Ship Readiness ≥ 8/10，或相较首轮提升 ≥ 2 分且剩余项主要是低价值 polish。
- Desktop / Mobile 均无明显 overflow、遮挡、断裂。
- Primary task 和 CTA 清晰。
- 关键交互状态可用。
- 没有突出的 AI-Slop signature。

如果连续两轮评分提升 < 0.5/10，停止微调并重新判断设计方向；不要继续调整 2px spacing 或 shadow。

## Regression Guard

每次修复后检查：

- 是否破坏已有 Design System？
- 是否改变用户未要求改变的信息架构？
- 是否影响已有 route / state / event semantics？
- 是否为解决一个视觉问题增加了新的装饰复杂度？
- 是否改善 desktop 却破坏 mobile，或反之？

视觉优化不能以功能回归为代价。
