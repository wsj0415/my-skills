# Anti-AI-Slop Reference

目标：识别并删除“看起来像 AI 自动生成”的高频视觉默认值。不是禁止某种风格，而是禁止**无业务理由的默认选择**。

## 高频 AI Signature

### Layout
- 全页面 section 统一居中、等宽、等间距。
- Hero + 三卡片 + Logo Cloud + Testimonials + Pricing + CTA 的默认营销模板。
- 每段都使用 card 容器，即使内容没有独立边界。
- 所有区域都保持对称，缺乏主次和编辑节奏。
- Dashboard 首屏塞满统计卡，但核心任务不清晰。

### Color & Effects
- 紫蓝渐变作为默认品牌色。
- gradient text 用于任何大标题。
- glow、blur、mesh gradient、glassmorphism 同时出现。
- 深色背景 + 高饱和荧光 accent，只因为“科技感”。
- 阴影用于每张卡，而不是表达 elevation。

### Shape
- `rounded-xl/2xl/3xl` 泛滥。
- pill 用于所有标签、导航、筛选、按钮。
- icon 被统一塞入有背景色的 rounded square。

### Typography
- 所有项目都使用同一套无衬线字体。
- 过大的粗体 Hero + 极短副标题。
- 每个 section 都是 eyebrow + heading + paragraph 的重复结构。
- 文字层级靠字号堆砌，而不是内容结构。

### Content
- “Unlock / Elevate / Transform / Empower / Seamless / Next-generation / Revolutionize”等空洞营销词。
- 看起来像真实指标但其实是装饰的 98%、10x、24/7。
- 假 Logo、假用户头像、假 testimonial 用来填版面。
- 没有真实业务对象，只有抽象图标和 generic mockup。

### Motion
- 所有卡片 hover 都 translateY + shadow。
- 每个元素都 fade-up。
- 页面加载时所有元素 stagger。
- 动效没有解释状态变化或业务关系。

## 删除测试

对每个装饰元素问：

1. 它传达了真实信息吗？
2. 它建立了层级吗？
3. 它帮助理解交互吗？
4. 它强化了这个产品独有的身份吗？

四项都不是，则删除。

## 差异化方法

不要靠“更复杂”去差异化。优先从真实业务提取：

- 产品中的实体：课程、订单、Agent、任务、文档、设备、项目。
- 用户真实动作：比较、筛选、审批、创建、监控、学习、诊断。
- 行业材料与语言：教育卡片、运维控制台、研究档案、编辑排版、金融报表。
- 数据结构：时间线、关系、层级、流程、地图、状态机。

让这些真实结构成为视觉语言。

## Restraint Rule

一个页面通常：

- 1 个主要视觉 signature
- 1 个主 accent
- 1 套 radius system
- 1–2 种主要 elevation
- 少量高价值 motion

如果每个区域都在争夺注意力，就没有真正的焦点。

## Allowlist Principle

以下模式不是绝对禁止：gradient、glass、serif、dark mode、cards、pills、bento、animations。

只有当能回答“**为什么这个产品需要它**”时才保留。
