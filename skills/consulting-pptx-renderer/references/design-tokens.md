# Design Tokens

Renderer 默认使用固定的 16:9 consulting canvas。所有 layout 必须引用共享 token，不要各自定义视觉常量。

## Canvas

```text
WIDTH  = 13.333 in
HEIGHT = 7.5 in
```

## Safe zones

```text
PAGE_X        = 0.60
PAGE_RIGHT    = 12.73
TITLE_Y       = 0.42
TITLE_H       = 0.72
CONTENT_Y     = 1.45
CONTENT_H     = 5.25
FOOTER_Y      = 7.04
FOOTER_H      = 0.24
```

默认左右边距约 0.60 in。任何 layout 若需要突破 safe zone，必须有明确的全幅图或 section 设计理由。

## Spacing scale

```text
XS = 0.08
SM = 0.16
MD = 0.28
LG = 0.42
XL = 0.64
XXL = 0.92
```

优先组合这些增量，避免大量 0.13 / 0.37 / 0.51 一类不可维护坐标。

## Typography

推荐默认：

```text
heading: Aptos Display / Arial fallback
body:    Aptos / Arial fallback
```

中文环境可以替换为稳定安装的无衬线中文字体，但一份 deck 内不要混用多个中文字族。

```text
COVER_TITLE        30–38 pt
SECTION_TITLE      28–34 pt
ACTION_TITLE       24–30 pt
BODY_PRIMARY       17–20 pt
BODY_SECONDARY     14–16 pt
CHART_LABEL        12–15 pt
SOURCE_FOOTNOTE     8–10 pt
```

默认字重：

- Action title: semibold / bold
- Body: regular
- Key metric: bold
- Source: regular

## Palette

默认浅色咨询风：

```text
BG          #FFFFFF
TEXT        #17202A
TEXT_2      #4D5966
MUTED       #7B8794
GRID        #D9DEE5
SURFACE     #F5F7F9
ACCENT      #175CD3
ACCENT_SOFT #E8F1FF
SUCCESS     #16835A
WARNING     #B56A00
DANGER      #B42318
```

规则：

- 一份 deck 只设置一个主 `ACCENT`。
- `SUCCESS/WARNING/DANGER` 只表达语义状态，不作为随意装饰色。
- 图表上下文 series 默认使用 neutral gray。
- 与 action title 对应的证据才使用 accent。

## Lines and shapes

```text
RULE_LINE   0.75–1.0 pt
AXIS_LINE   0.75 pt
DIVIDER     0.5–0.75 pt
```

圆角只用于确有容器语义的模块，默认 radius 保守。不要把所有信息都包成 card。

## Title zone

Action title 永远是页面第一视觉入口。

推荐：

```text
x = PAGE_X
w = 12.13
```

必要时允许两行，但不允许把标题缩成小字来容纳长句。标题超过合理长度时先回到 spec 精炼。

## Source zone

Footer 结构建议：

```text
Source: <publisher / title / date / locator>                 <slide number>
```

规则：

- Source 文本存在但视觉退后。
- 不允许与正文区域重叠。
- 多来源时优先简写并维护完整 source register。

## Chart defaults

- 无外边框。
- gridline 尽量减少。
- axis 使用 muted / grid 色。
- data label 优先放在数据附近。
- 强调 series 使用 `ACCENT`。
- 其他 series 使用 neutral gray 阶梯。
- 若数据单位显而易见，在副标题或 axis 只出现一次，不重复标注。

## Table defaults

- Header 使用浅灰 surface 或单线分隔，不用深色彩条作为默认。
- 数字右对齐。
- 文本左对齐。
- 行高应支持快速扫描。
- 主 deck 中避免超过 6 行 × 5 列的大表；更大的表进入 appendix。

## Accessibility

- 文本与背景保持足够对比度。
- 不仅靠颜色表达状态。
- 关键数据保留 label。
- 不使用极细浅灰文字承载重要信息。
