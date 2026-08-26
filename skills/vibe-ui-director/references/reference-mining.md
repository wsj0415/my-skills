# Reference Mining Protocol

目标：把“找灵感”变成可审计的设计证据采集过程。参考的作用是降低模型凭空设计的概率，而不是复制某个网站。

## 何时使用

优先在以下场景启用：

- `create`：用户只给业务需求，没有明确视觉方向。
- `redesign`：现有界面明显模板化，需要建立新的视觉语言。
- `study`：用户明确提供 URL、截图或参考产品，希望提炼设计 DNA。
- 高价值页面：Landing Page、核心 Dashboard、主流程、品牌首页。

通常跳过：

- 已存在明确 `DESIGN.md` / Design System 且用户要求保持一致。
- 只修一个明显的组件 bug。
- `polish` 仅处理 spacing、状态、一致性等局部问题。
- 用户明确要求不要外部参考。

## Source Priority

按以下优先级寻找证据：

1. **用户自己的产品**：现有页面、品牌资产、设计规范、历史版本。
2. **同类真实产品**：解决相同任务、拥有相似内容密度和使用频率的产品。
3. **邻近行业产品**：任务模型相似，即使行业不同。
4. **优秀模式库 / 设计系统**：只用于验证具体模式，不作为整页模板。
5. **视觉灵感站**：只能作为最后补充，不能成为唯一依据。

不要因为某个页面“好看”就选它。参考必须与当前任务存在可解释的关系。

## Relevance Filter

每个候选参考按 0–2 评分：

| Dimension | 0 | 1 | 2 |
|---|---|---|---|
| Task similarity | 任务不同 | 部分相似 | 核心任务一致 |
| Density similarity | 密度完全不同 | 部分相近 | 使用密度接近 |
| Audience similarity | 用户不同 | 部分重叠 | 主要用户接近 |
| Platform similarity | 平台不同 | 可迁移 | 同平台/同输入方式 |
| Design evidence | 只凭印象 | 有局部证据 | 可明确指出结构/排版/交互证据 |

总分低于 6/10 的参考通常不要进入 Evidence Packet。

## Evidence Packet

默认只保留 **3–5 个高相关参考**。太多参考会把设计重新平均成“互联网默认风格”。

每个参考必须记录：

```markdown
### Reference: <name / URL / screenshot-id>

Why relevant:
- 与当前产品相似的任务/内容/用户是什么？

Observed evidence:
- Layout: ...
- Hierarchy: ...
- Typography: ...
- Density / spacing: ...
- Interaction / state behavior: ...
- Content strategy: ...

Transferable principle:
- 用一句具体、可执行的规则描述。

Do NOT copy:
- 哪些品牌特征、独特插画、专有布局、文案或视觉资产不能照搬。
```

### 好的 Transferable Principle

- “高频监控页面把异常列表放在 KPI 之前，并允许按严重度直接过滤。”
- “正文密度高时，标题尺寸克制，主要依靠字重、列宽和分组产生层级。”
- “关键状态同时使用图标、标签和颜色，不只依赖红/绿。”
- “详情页把不可逆操作移出主操作区，避免与日常动作竞争。”

### 差的 Transferable Principle

- “做得高级一点。”
- “像 Linear。”
- “使用 Stripe 风格。”
- “更有设计感。”
- “极简、精致、现代。”

这些描述没有约束力，会让模型重新回到刻板印象。

## Visual DNA Extraction

当用户提供截图或 URL 时，不要从“风格标签”开始。按以下维度提取：

1. **Macrostructure**：页面分区、主次区域、信息顺序。
2. **Hierarchy**：第一、第二、第三注意力分别是什么。
3. **Grid**：列数、对齐方式、留白策略、内容宽度。
4. **Density**：信息量、section 间距、局部拥挤程度。
5. **Typography**：角色、比例、字重、行高、字符宽度、段落宽度。
6. **Color roles**：背景/表面/文本/边框/主色/语义色的角色，而不是只记 hex。
7. **Surface model**：边框、阴影、层级、radius 如何表达结构。
8. **Component archetypes**：表格、列表、tabs、filters、forms、cards 等如何被组织。
9. **Interaction**：hover、focus、loading、selection、transition 是否表达状态。
10. **Content voice**：标签、按钮、错误、空状态如何写。

如果环境只能读取 HTML/CSS 而不能视觉查看，明确区分：

- **可以确认**：字体、颜色、DOM 结构、部分 spacing。
- **不能可靠确认**：视觉节奏、注意力路径、真实响应式效果。

不要把代码事实伪装成视觉判断。

## Triangulation Rule

不要用单一参考决定整个页面。

推荐做法：

- 参考 A：学习宏观信息结构。
- 参考 B：学习高密度排版/数据表现。
- 参考 C：学习某个交互模式。

然后回到当前产品重新组合。

最终设计必须能解释：

> 哪些原则来自证据，哪些决定来自当前产品自身。

## Anti-Copy Boundary

允许学习：

- 通用布局原则
- 信息层级
- spacing rhythm
- type scale 关系
- 交互模式
- 状态反馈
- 通用组件组织方式

不要复制：

- Logo、插画、图标资产、摄影作品
- 受品牌识别保护的独特视觉组合
- 独特文案、营销语言
- 像素级页面复刻
- 一个参考页面的完整 section 顺序 + 视觉样式 +内容结构

如果用户要求“做得和 X 一模一样”，优先提取高层设计 DNA，再用用户自己的内容、结构和品牌重建。

## Reference-to-Rule Compression

完成 Evidence Packet 后，将观察压缩成 **5–10 条 Design Inputs**：

```markdown
## Reference-derived Design Inputs

1. 核心异常必须在首屏可扫描，而不是藏在统计卡之后。
2. 主体使用高密度二维布局，避免大面积营销式留白。
3. 状态同时使用文本标签 + 图形标识 + 颜色。
4. 详情信息采用稳定的 label/value alignment。
5. Motion 只用于状态变化，不做全页 entrance animation。
```

Art Direction 只能使用这些具体规则作为参考输入；不要把参考名称直接变成风格指令。

## Quality Check

Reference Mining 完成前确认：

- [ ] 参考与当前任务有明确相关性。
- [ ] 没有只因为“好看”选参考。
- [ ] 至少提取了具体可执行原则。
- [ ] 没有把品牌名当成设计规范。
- [ ] 没有直接复制独特资产或完整页面结构。
- [ ] 参考数量足够少，仍能保持当前产品自己的身份。
