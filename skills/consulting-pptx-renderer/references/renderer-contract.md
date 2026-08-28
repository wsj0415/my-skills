# Renderer Contract

`consulting-pptx-renderer` 接受结构化 Deck Spec。目标是让 reasoning layer 与 rendering layer 解耦。

## Top-level schema

```json
{
  "deck": {},
  "theme": {},
  "slides": [],
  "sources": []
}
```

## deck

必填：

```json
{
  "title": "年度增长战略",
  "audience": "Executive Committee",
  "decision": "批准优先投资方向",
  "aspectRatio": "16:9"
}
```

可选：

- `subtitle`
- `author`
- `date`
- `language`
- `confidentiality`

## theme

允许覆盖设计 token，但不要在单页内零散覆盖。

```json
{
  "fontHeading": "Aptos Display",
  "fontBody": "Aptos",
  "accent": "#0F5BD8",
  "background": "#FFFFFF"
}
```

## slides[]

通用字段：

```json
{
  "id": "s03",
  "type": "chart-commentary",
  "actionTitle": "高端需求将贡献未来三年主要增量",
  "takeaway": "资源应优先投入高端产品线",
  "evidence": [],
  "source": ["src-market-2026"],
  "notes": "optional presenter note"
}
```

### Required invariants

- `id` 唯一。
- `type` 必须存在于 layout registry。
- 除 `cover`、`section` 外，默认要求 `actionTitle`。
- `actionTitle` 不应与 deck 中其他页面完全重复。
- `source` 引用的 source id 必须存在。
- 数据字段禁止使用混合单位而无明确 unit。

## evidence

证据可以是：

### metric

```json
{
  "kind": "metric",
  "label": "Premium segment CAGR",
  "value": 18,
  "unit": "%",
  "period": "2026-2029"
}
```

### chart

```json
{
  "kind": "chart",
  "chartType": "bar",
  "categories": ["Base", "Premium", "Ultra-premium"],
  "series": [
    {"name": "CAGR", "values": [4, 18, 22]}
  ],
  "unit": "%"
}
```

### bullets

```json
{
  "kind": "bullets",
  "items": [
    "高端用户客单价更高",
    "复购率增长更快"
  ]
}
```

### table

```json
{
  "kind": "table",
  "columns": ["Option", "Impact", "Effort"],
  "rows": [
    ["A", "High", "Low"],
    ["B", "Medium", "High"]
  ]
}
```

### diagram

```json
{
  "kind": "diagram",
  "diagramType": "process",
  "nodes": [
    {"id": "n1", "label": "Input"},
    {"id": "n2", "label": "Decision"},
    {"id": "n3", "label": "Outcome"}
  ],
  "edges": [
    {"from": "n1", "to": "n2"},
    {"from": "n2", "to": "n3"}
  ]
}
```

## sources[]

```json
{
  "id": "src-market-2026",
  "title": "Market study 2026",
  "publisher": "Internal Strategy Team",
  "date": "2026-07-31",
  "locator": "p. 18",
  "url": null
}
```

最低要求：

- `id`
- `title`

数据型正式汇报建议同时包含：

- `publisher`
- `date`
- `locator`

## Layout-specific fields

### executive-summary

```json
{
  "type": "executive-summary",
  "actionTitle": "我们建议聚焦三项动作以释放增长",
  "recommendation": "...",
  "points": [
    {"headline": "Portfolio", "detail": "..."},
    {"headline": "Channel", "detail": "..."},
    {"headline": "Capability", "detail": "..."}
  ],
  "nextAction": "批准第一阶段投资"
}
```

### comparison

```json
{
  "type": "comparison",
  "left": {"label": "Option A", "items": []},
  "right": {"label": "Option B", "items": []},
  "winner": "left"
}
```

### matrix-2x2

```json
{
  "type": "matrix-2x2",
  "xAxis": {"label": "Feasibility", "min": "Low", "max": "High"},
  "yAxis": {"label": "Impact", "min": "Low", "max": "High"},
  "items": [
    {"label": "A", "x": 0.8, "y": 0.9, "highlight": true}
  ]
}
```

`x` / `y` 范围为 `0..1`。

### timeline

```json
{
  "type": "timeline",
  "events": [
    {"date": "Q4 2026", "label": "Pilot"},
    {"date": "Q1 2027", "label": "Scale"}
  ]
}
```

## Renderer warnings vs errors

### Error — stop rendering

- duplicate slide id
- unknown slide type
- invalid source reference
- chart category/value length mismatch
- matrix coordinate outside 0..1
- no slides
- required title missing

### Warning — render allowed but report

- action title too long
- too many bullets
- too many categories for chosen chart
- source missing date
- table likely too dense
- slide type inconsistent with evidence type

Renderer should never silently repair semantic errors.
