---
name: consulting-pptx-renderer
description: 将 consulting-slides 产出的结构化 deck spec 编译为可编辑、可验证的咨询级 PPTX。使用 PptxGenJS 与稳定版式注册表生成 16:9 PowerPoint，支持 action title、图表、流程、对比、2x2、时间线、建议页、来源脚注，并通过 spec 校验、render、overflow/overlap/font 检查与自动修复循环保证交付质量。适用于已经完成 storyline/slide contract，准备进入 PPTX 制作阶段的任务。
argument-hint: "[deck spec JSON / storyline + slide contracts / existing template]"
---

# Consulting PPTX Renderer

这是 `consulting-slides` 的**渲染层**。

它不重新决定商业故事，不自行改写核心结论；它把已经批准的 storyline / slide contracts 编译成稳定、可编辑、可审计的 PowerPoint。

```text
consulting-slides
  ↓
Deck Spec
  ↓
consulting-pptx-renderer
  ↓
Editable PPTX + source + QA report
```

## 设计目标

Renderer 必须同时满足：

1. **Deterministic** — 相同 spec 应得到高度一致的版式结果。
2. **Editable** — 文本、简单图表、基础 diagram 尽量保留 PowerPoint 原生可编辑性。
3. **Evidence-faithful** — 不擅自改变数据、claim、单位、来源和 caveat。
4. **Consulting-readable** — action title 清晰、主证据突出、信息层级稳定。
5. **Verifiable** — 输出后必须 render + inspect + validate，而不是只调用 `pptx.writeFile()`。
6. **Repairable** — QA 失败时按确定优先级自动修复，禁止用缩到不可读字号作为万能补丁。

## 使用边界

### 使用本 Skill

- 已经有 storyline / slide contract / deck spec
- 用户要求生成可编辑 `.pptx`
- 用户希望把结构化咨询内容批量渲染成一致版式
- 需要 PowerPoint 工程 QA：overflow、overlap、字体替换、导出异常
- 需要把现有 consulting deck 重新排版到稳定 design system

### 不应由 Renderer 决定

以下问题属于 `consulting-slides`：

- 这份 deck 的核心结论是什么
- storyline 是否正确
- 是否应该新增/删除某个论点
- action title 的商业判断是否成立
- 证据是否足以支持 claim

如果这些内容尚未稳定，先回到 `consulting-slides`，不要让渲染器“边画边想”。

## 输入契约

优先接受结构化 JSON。完整契约见 `references/renderer-contract.md`。

最小输入：

```json
{
  "deck": {
    "title": "...",
    "audience": "...",
    "decision": "...",
    "aspectRatio": "16:9"
  },
  "slides": [
    {
      "id": "s01",
      "type": "argument-evidence",
      "actionTitle": "高端需求将贡献未来三年主要增量",
      "takeaway": "...",
      "evidence": [],
      "source": []
    }
  ]
}
```

在写 PPTX 前必须运行 spec validation。

如果只有 Markdown storyline，可以先转换成 deck spec；不要直接把自由文本随机映射为页面。

## 输出契约

支持完整制作环境时，至少交付：

```text
output/
├── deck.pptx
├── deck.js                  # 或 deck.ts，可重建源文件
├── deck-spec.json           # 实际使用的最终 spec
├── qa-report.md
├── rendered/                # 每页 PNG，用于人工/视觉检查
└── montage.png              # 可选，全局快速检查
```

如果使用了外部图片/字体/数据文件，还应保留必要 assets 或明确引用路径。

## 强制流水线

### Phase 1 — Normalize

1. 读取 deck spec。
2. 填充允许的默认值：比例、字号、边距、footer 规则。
3. 不得默认填充业务数据。
4. 缺少关键字段时阻止渲染，而不是猜测。
5. 运行 `scripts/validate-spec.mjs` 或等价校验器。

### Phase 2 — Select layout

根据 `slide.type` 显式匹配 layout registry。

读取 `references/layout-library.md`。

默认注册表：

- `cover`
- `section`
- `executive-summary`
- `argument-evidence`
- `chart-focus`
- `chart-commentary`
- `comparison`
- `two-column`
- `process`
- `timeline`
- `matrix-2x2`
- `recommendation`
- `appendix-table`

禁止根据“看起来不够满”随机切换 layout。

### Phase 3 — Apply design tokens

读取 `references/design-tokens.md`。

所有页面共享：

- slide geometry
- page margins
- title zone
- footer/source zone
- type scale
- neutral palette
- single accent-color policy
- chart labeling conventions
- spacing increments

不要把这些数值散落在每个 layout function 中。

### Phase 4 — Render with PptxGenJS

优先使用 PptxGenJS。

如果当前环境提供成熟 helper，应复用，而不是重复造轮子。常见 helper：

- `autoFontSize`
- `calcTextBox`
- `imageSizingCrop`
- `imageSizingContain`
- `svgToDataUri`
- `warnIfSlideHasOverlaps`
- `warnIfSlideElementsOutOfBounds`
- `alignSlideElements`
- `distributeSlideElements`

本 Skill 提供 `templates/renderer-template.js` 作为实现骨架。

### Phase 5 — Render to images

`.pptx` 写出后不是完成。

必须转换为 PNG/PDF 进行视觉检查。

推荐能力：

```bash
python3 render_slides.py deck.pptx --output_dir rendered
python3 create_montage.py --input_dir rendered --output_file montage.png
python3 slides_test.py deck.pptx
python3 detect_font.py deck.pptx --json
```

具体脚本路径取决于运行环境。

### Phase 6 — QA and repair

读取 `references/qa-repair.md`。

修复顺序固定：

1. 内容逻辑错误 → 回退到 spec / consulting-slides
2. 数据或 source 错误 → 修正输入
3. layout 类型错误 → 换 layout
4. 内容过载 → 拆页或降级到 appendix
5. overflow → 调整内容分配 / textbox 几何
6. alignment / spacing → 修正坐标/token
7. font substitution → 替换为可用主题字体
8. 最后才允许小幅调整字号

**严禁**把正文缩到低于可读门槛来通过 overflow test。

### Phase 7 — Final audit

交付前确认：

- 所有 slide 有唯一 `id`
- 所有非封面页有 action title 或明确允许的 section title
- source footer 不遮挡内容
- 关键图表有单位、时间范围与来源
- 没有无意 overlap / out-of-bounds
- 字体没有意外 substitution
- PNG render 无空白页、截断、乱码
- title-only storyline 与最终 spec 一致

## Layout selection rules

Layout 选择遵循**信息关系**，不是审美随机性。

| 信息关系 | 默认 layout |
|---|---|
| 单一结论 + 关键证据 | `argument-evidence` |
| 一张主图表证明结论 | `chart-focus` |
| 图表 + 右侧解释 | `chart-commentary` |
| 两个方案/对象比较 | `comparison` |
| 两组对等内容 | `two-column` |
| 顺序步骤 | `process` |
| 时间演进 | `timeline` |
| 两维度定位 | `matrix-2x2` |
| 多条高管结论 | `executive-summary` |
| 行动建议 | `recommendation` |
| 大表/审计细节 | `appendix-table` |

如果 spec 指定的 layout 与信息关系明显冲突，报告 warning；不要静默重排。

## Chart rules

默认使用 PowerPoint native chart 处理简单：

- bar
- column
- line
- area
- pie（仅少量 category 且确实表达占比）
- scatter

复杂图形可使用 SVG，但需要：

- 保证文字清晰
- 不把整页栅格化
- 保留 source / units
- 不制造视觉误导

图表默认：

- 中性色作为上下文
- 单一 accent 突出与 action title 直接相关的数据
- 减少 gridline
- 尽量直接标注
- legend 仅在确有必要时保留

## Typography constraints

默认最低门槛：

- Action title：24–30 pt
- Section title：28–34 pt
- Body：16–20 pt
- Chart labels：12–16 pt
- Source / footnote：8–10 pt

这些是默认安全区，不是机械规则。

如果内容只能靠大幅低于这些字号才能塞入页面，应首先拆页或删减次要信息。

## Anti-patterns

不得生成：

- 作为主要结构的“六个圆角卡片 + 六个 icon”
- 为每个页面随机使用不同强调色
- 充满 gradient / glow / glassmorphism 的咨询页
- 将真实数据转成不可编辑截图，只为了方便布局
- 大段正文塞进 10–12 pt 文本框
- 把 source 省略掉以获得更多空间
- 用缩放整个页面解决 overflow
- 图表标题与 action title 重复表达同一句话
- 为“视觉平衡”补入无信息价值的装饰

## 与 consulting-slides 的交接协议

Renderer 接收到 deck spec 后：

- 可以改：坐标、字号（在范围内）、图表标注、视觉层级、layout 内部几何
- 可以建议：拆页、换 layout、移动 secondary evidence 到 appendix
- 不可以改：核心 claim、推荐结论、数据值、来源、因果语义

需要改变后一类内容时，必须显式回退到 reasoning layer。

## References

按需读取：

- `references/renderer-contract.md` — Deck Spec 字段和约束
- `references/layout-library.md` — 13 种咨询级 layout 定义
- `references/design-tokens.md` — 16:9 网格、排版、颜色、间距与 footer
- `references/qa-repair.md` — render 检查与自动修复决策树
- `templates/deck-spec.example.json` — 可执行输入示例
- `templates/renderer-template.js` — PptxGenJS 实现骨架
- `scripts/validate-spec.mjs` — spec 静态校验器

## Success definition

一个合格的 Renderer 输出，不应该让人首先注意到“这个 PPT 模板很好看”。

正确结果是：

> 受众先看到结论，再看到证据，并且能够快速理解结论为什么成立。
