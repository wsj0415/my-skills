---
name: consulting-slides
description: 构建结论先行、证据驱动、单页单任务的咨询级演示文稿。适用于 PowerPoint/PPTX、pitch deck、战略汇报、方案汇报、研究报告转幻灯片、管理层汇报和需要“McKinsey-style / consulting-style”表达的场景。强调 storyline、action title、argument tree、正确图表关系、来源可追溯、三轮审校与可编辑 PPTX 工程质量；不模仿任何咨询公司的专有品牌视觉。
argument-hint: "[主题 / 原始材料 / 旧PPT / 受众 / 要支持的决策]"
---

# Consulting Slides

把“做 PPT”视为一个**决策沟通系统**，而不是页面装饰任务。

目标是让受众在很短时间内回答四个问题：

1. 结论是什么？
2. 什么证据支持它？
3. 为什么重要？
4. 接下来应该做什么？

“McKinsey-style”在本 Skill 中只表示一种结构化沟通方法：**conclusion-led、evidence-backed、one-message-per-slide、fast to comprehend**。不要复制任何公司的专有模板、商标、字体、配色或版式资产。

## 何时使用

当用户要求以下任一任务时使用：

- 创建或改写 PowerPoint / PPTX / deck / slides / pitch deck
- 制作战略汇报、管理层汇报、咨询式报告、商业分析、项目方案
- 把研究报告、PDF、数据、会议材料转换成演示文稿
- 用户要求“咨询风”“McKinsey-style”“BCG-style”“结论先行”“高管汇报”
- 用户反馈已有 PPT “太乱、太满、没有重点、像 AI 做的、缺少逻辑”
- 需要检查一份 deck 的 storyline、标题、图表、证据或版式质量

如果只是需要读取 PPTX 文本、做格式转换或机械批量编辑，而不涉及表达质量，可以使用更底层的 PPTX 工具，不必强制执行完整咨询工作流。

## 核心原则

### 1. Storyline before slides

在设计任何页面之前，先明确：

- Audience：谁看？
- Decision：这份 deck 要支持什么决策？
- Desired outcome：希望受众看完做什么？
- One-sentence answer：整份 deck 的答案能否用一句话说清？

然后建立 argument tree：

```text
Main recommendation / conclusion
├─ Supporting argument A
│  ├─ Evidence A1
│  └─ Evidence A2
├─ Supporting argument B
│  ├─ Evidence B1
│  └─ Evidence B2
└─ Implication / action
```

**只读所有 slide title，故事也必须成立。**

详细方法见 `references/storyline.md`。

### 2. Every title is a conclusion

默认使用 **Action Title**，不是 Topic Title。

弱：

> 市场增长

强：

> 高端需求将贡献未来三年大部分品类增量

Action Title 必须：

- 是一个可被证据验证或限定的 claim
- 足够具体，最好包含对象、方向、时间或量级
- 与本页证据一一对应
- 避免把相关性写成因果关系
- 避免把单一市场证据无依据外推到更大范围

### 3. One slide, one primary job

创建页面前先完成：

> The audience should leave this page understanding that ______.

如果答案包含多个相互独立的从句，就拆页。

一页可以有多个对象，但这些对象必须共同证明**同一个结论**。

当用户反馈“太复杂”时：

- 不要先缩字号
- 不要先压缩间距
- 不要堆更多卡片
- 先删除次要信息、拆页、移到脚注或 appendix

### 4. Match visual form to information relationship

先判断信息关系，再选表现形式。

例如：

- 比较 → bar / dot plot / comparison table
- 趋势 → line / slope
- 构成 → stacked bar / waterfall（若逻辑适合）
- 分布 → histogram / box plot
- 相关 → scatter
- 流程 → process / timeline
- 层级 → hierarchy / tree
- 周期 → cycle
- 两维决策 → 2×2 matrix
- 机制 → diagram / flow

不要因为“看起来高级”而使用错误几何关系。

详见 `references/visual-system.md`。

### 5. Charts are evidence, not decoration

每个图表都必须能回答：

> 这张图比一句文字或一个小表格更高效地证明了什么？

默认规则：

- 只保留与 claim 有关的 series、labels、gridlines
- 用一个强调色突出关键证据，其余信息退到中性色
- 优先直接标注，减少读者在 legend 与图表间来回跳转
- 重要数字必须有来源
- 不伪造精度，不用视觉比例夸大微小差异
- 不为了填满页面而加入无意义图表

### 6. Hierarchy through spacing before decoration

优先通过以下手段建立视觉层级：

1. 位置
2. 尺寸
3. 留白
4. 对齐
5. 字重
6. 颜色

边框、阴影、渐变、图标只在有功能时使用。

默认采用：

- 稳定 title zone
- 固定内容网格
- 一致边距
- 图表与文本边缘对齐
- evidence 与 implication 明确分区
- 低干扰 footer / source zone

### 7. Reuse functional page types

不要让每一页都重新发明版式。使用一小组功能型模板：

- Cover / section
- Executive summary
- Argument + evidence
- Comparison
- Data chart
- Process / timeline
- Recommendation / next steps
- Appendix

一致性来自共享设计系统，而不是每页长得一模一样。

### 8. Review in three passes

不要把故事修改、数据校验和像素调整混在一起。

必须按顺序执行：

**Pass 1 — Story**
- 只读标题，是否形成完整 argument？
- 是否最终落到 recommendation / decision？
- 是否每页只有一个 primary job？

**Pass 2 — Evidence**
- 每个关键 claim 是否有证据？
- 数字、单位、日期、计算是否正确？
- 来源是否可追溯？
- 结论有没有超出证据边界？

**Pass 3 — Design & export**
- 对齐、间距、层级、字号、色彩是否一致？
- 3 秒内能否看出页面结论？
- 3 米外能否看到主要信息？
- 是否存在 overflow、overlap、字体替换或导出问题？

详见 `references/quality-gates.md`。

## 强制工作流

### Step 0 — Intake

如果用户已经提供足够信息，直接开始，不重复提问。

否则只补齐真正阻塞工作的输入：

| 输入 | 需要知道什么 |
|---|---|
| Audience | 高管 / 客户 / 技术团队 / 投资人 / 培训受众 |
| Decision | 要批准、选择、理解或行动什么 |
| Outcome | 看完后希望发生什么 |
| Time | 演讲时长或期望页数 |
| Sources | 文档、数据、旧 PPT、链接、截图 |
| Constraints | 品牌、保密、必须出现/禁止出现内容 |

不要为了“流程完整”而机械询问所有问题。

### Step 1 — Build the storyline

先产出 storyline table，再碰版式：

| # | Action title | Page job | Evidence | Visual | Source | So what |
|---|---|---|---|---|---|---|
| 1 | ... | ... | ... | ... | ... | ... |

故事线必须通过 **title-only test**。

如果材料复杂，使用 `templates/storyline-template.md`。

### Step 2 — Contract each slide

每一页建立 slide contract：

```text
Action title:
Audience takeaway:
Primary evidence:
Visual relationship:
Implication / so what:
Source / caveat:
```

没有明确 takeaway 的页面不进入制作。

### Step 3 — Choose the visual system

读取 `references/visual-system.md`，根据内容关系决定图表/diagram/layout。

不要默认使用：

- 三列圆角卡片
- 大面积渐变背景
- 漂浮玻璃拟态
- 无功能的彩色 icon
- 每页重复相同的“AI SaaS”构图
- 为了对称而添加没有信息价值的模块

咨询级 deck 的“高级感”主要来自结构、证据、留白、排版和一致性。

### Step 4 — Build the deck

根据当前环境选择可用引擎。

如果输出 `.pptx`，优先遵循 `references/pptx-engineering.md`：

- 16:9 为默认比例，除非已有模板要求其他比例
- 尽可能保持文本、图表和简单 diagram 可编辑
- 明确设置主题字体
- 用稳定网格而不是凭感觉摆放
- 对真实数据优先使用可编辑 native chart
- 对复杂 diagram 可使用 SVG，但不要把整页栅格化

如果环境没有 PPTX 写入能力，可以先交付完整 storyline + slide spec；不要假装生成了用户要求的可编辑 PowerPoint。

### Step 5 — Maintain source traceability

对于数据密集或正式汇报，维护 slide-to-source register：

| Slide | Claim | Source | Date | Page / table | Notes |
|---|---|---|---|---|---|

来源区默认放在页脚，存在但不抢注意力。

### Step 6 — Run quality gates

执行 `references/quality-gates.md`。

有以下任一情况时，不应把 deck 标记为完成：

- title 只是主题标签，没有 claim
- 一页承载两个以上独立结论
- 关键数字无来源
- 图表不能支持标题结论
- 证据被过度外推
- 为解决拥挤而使用不可读小字
- 明显对齐/溢出/重叠错误
- 页面只有装饰，没有信息功能
- 多页之间字体、色彩、标签约定不一致

## Executive summary 规则

Executive Summary 不是目录。

默认结构：

1. 结论 / recommendation
2. 2–4 个最重要的 supporting reasons
3. 关键 implication / risk
4. Next action

读者只看这一页也应该知道整份 deck 的核心答案。

## Appendix 规则

把以下内容移入 appendix，而不是挤在主线：

- 方法论细节
- 大表格
- 次要切片
- 敏感性分析
- 备选假设
- 原始数据
- 只对少数人有价值的技术细节

主 deck 用于决策；appendix 用于答疑与审计。

## 交付标准

如果运行环境支持完整 PPTX 生成，优先交付：

- `deck.pptx`
- 可重建的源文件（如 `.js` / `.ts`）
- 必要的 assets
- source register（如适用）
- 简短 QA 结果

不要只确认“已生成”，必须实际验证输出。

## References

按需读取，不要一次性加载所有文件：

- `references/storyline.md` — 受众、决策、金字塔、SCQA、argument tree、action title
- `references/visual-system.md` — 信息关系到视觉形式、图表简化、功能型页面模板
- `references/quality-gates.md` — 三轮审校、评分门槛、3 秒/3 米测试、复杂度修复
- `references/pptx-engineering.md` — 可编辑 PPTX、PptxGenJS、渲染、溢出、字体与交付检查
- `templates/storyline-template.md` — 可直接填写的 storyline / source register 模板

## Design provenance

本 Skill 的方法综合了：

- 结论先行、action title、单页单任务、证据图表、留白层级、功能型模板、三轮审校等咨询式演示原则
- “one point per slide / split instead of cram”的 slide-design 原则
- PptxGenJS 可编辑输出、render-first、overflow / overlap / font validation 的工程化实践
- 完整需求澄清、布局系统和演讲型 deck 工作流中的可迁移实践

只吸收方法，不复制第三方 Skill 的受版权保护表达、专有资产或品牌模板。
