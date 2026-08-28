# QA & Repair

PPTX 生成后必须经过 render-based QA。目标不是“无报错”，而是视觉、语义与工程三方面都稳定。

## QA pipeline

```text
validate spec
  ↓
generate pptx
  ↓
run overlap / bounds diagnostics
  ↓
render to PNG/PDF
  ↓
inspect each slide + montage
  ↓
font substitution check
  ↓
repair
  ↓
re-render
```

## Gate A — Spec integrity

阻断条件：

- duplicate slide id
- unknown layout type
- broken source reference
- chart dimensions mismatch
- required field missing

这些问题不能靠版式修复。

## Gate B — Semantic fidelity

检查：

- 最终 action title 是否仍与 spec 一致
- chart data 是否与输入一致
- unit / period 是否保留
- source 是否出现在应出现的页
- renderer 是否擅自加入结论

失败：回退 spec 或 renderer mapping。

## Gate C — Geometry

检查：

- out-of-bounds
- accidental overlap
- clipped text
- chart labels 被截断
- footer 与正文冲突
- image crop 错误

### Repair order

1. 修正 layout geometry
2. 使用共享 spacing token
3. 调整 textbox 宽高
4. 简化/移动 secondary labels
5. 将次要内容移 appendix
6. 拆页
7. 最后才小幅减少字号

禁止：整体 scale slide。

## Gate D — Readability

人工或视觉模型检查：

- 3 秒内能否定位 action title 与主证据
- 主证据是否比 source/footer 更显眼
- 正文字号是否可读
- 页面是否被卡片、边框、icon 噪音淹没
- 一页是否实际有多个竞争焦点

若失败，优先修改 hierarchy，而不是增加装饰。

## Gate E — Chart quality

检查：

- chart 是否证明 action title
- 坐标轴是否必要且正确
- category / series 是否过多
- legend 是否可以直接标注替代
- emphasis 是否与 claim 对应
- 色彩是否造成误读
- bar axis 截断是否夸大差异
- pie 是否 category 过多

## Gate F — Typography & fonts

检查：

- theme font 可用
- 中文字符没有 fallback 到异常字体
- 字重存在
- 字符没有乱码
- source 最小字号仍可读

发现 font substitution：优先替换为运行环境稳定字体，而不是忽略警告。

## Gate G — Export

检查：

- PPTX 能被 PowerPoint/LibreOffice 打开
- 页数正确
- 无空白页
- render 没有丢失图形
- SVG/图片没有黑块/透明异常
- 图表和文本没有位置漂移

## Auto-repair decision tree

```text
QA failure
├─ semantic mismatch? → stop, fix spec/mapping
├─ missing source? → fix source mapping
├─ wrong layout? → switch registered layout
├─ too dense? → split / appendix
├─ overflow? → geometry → content allocation → split
├─ overlap? → alignment / spacing / z-order
├─ font issue? → theme fallback
├─ chart illegible? → simplify labels / categories
└─ minor visual issue? → token-level adjustment
```

## Density heuristics

自动 warning：

- action title > 110 characters（中文可按更低阈值判断）
- > 5 bullets
- > 4 executive summary reasons
- > 6 process nodes
- > 7 timeline events
- > 10 2x2 items
- > 10 chart categories
- appendix 以外表格 > 6 rows × 5 columns

这些阈值是预警，不是绝对规则。

## QA report format

```markdown
# QA Report

## Summary
- Slides: 14
- Errors: 0
- Warnings: 3
- Font substitutions: 0

## Slide findings

### s04
- WARN: 7 chart categories; labels are dense
- FIXED: moved secondary annotation into note

### s09
- WARN: source footer wrapped to two lines
- FIXED: shortened source display, full citation retained in register

## Final status
PASS
```

## Definition of PASS

只有同时满足以下条件才 PASS：

- 0 blocking spec errors
- 0 unintended bounds errors
- 0 unintended overlaps
- 0 unresolved font substitution affecting readability
- no materially clipped content
- source traceability preserved
- storyline titles unchanged except approved copy edits
