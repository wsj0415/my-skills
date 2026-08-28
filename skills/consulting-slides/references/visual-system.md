# Visual System for Consulting Slides

## 1. Choose visuals by relationship

| Information relationship | Preferred visual | Avoid |
|---|---|---|
| Category comparison | Bar / dot plot | Pie for many categories |
| Change over time | Line / slope | Unsorted bars across long time series |
| Composition | Stacked bar / 100% stacked bar | Pie with many slices |
| Contribution to change | Waterfall | Decorative arrows |
| Distribution | Histogram / box plot | Average-only KPI card |
| Correlation | Scatter | Dual-axis chart without strong need |
| Process | Flow / stage diagram | Paragraph explanation |
| Sequence | Timeline / roadmap | Dense table |
| Hierarchy | Tree / layered structure | Unstructured card wall |
| Two-dimensional decision | 2×2 matrix | Arbitrary quadrant decoration |
| Mechanism | Diagram / causal flow | Bullet list |

The chart geometry must encode the relationship. Visual novelty is not a reason to choose a chart.

## 2. Evidence hierarchy

A typical page hierarchy:

```text
Action title
↓
Primary evidence / visual
↓
Interpretation / implication
↓
Source / caveat
```

The eye should reach the main claim and evidence before decorative elements.

## 3. Chart simplification

Default cleanup sequence:

1. Remove redundant chart title if the slide action title already states the point.
2. Remove unnecessary borders and background fills.
3. Reduce gridlines to the minimum needed for reading values.
4. Direct-label the important series or values where practical.
5. De-emphasize context series in neutral tones.
6. Use one accent color for the data that proves the claim.
7. Show units once, consistently.
8. Keep source and caveat visible but quiet.

Do not manipulate axes or area to exaggerate differences.

## 4. Functional page types

### Executive summary

Use 2–4 answer blocks, each representing a real supporting conclusion. The page must summarize the answer, not list sections.

### Argument + evidence

- Left: argument / key facts
- Right: main evidence visual
- Bottom or side: implication

Use when a chart needs a small amount of interpretation.

### Full-width data chart

Use when the visual itself is the evidence. Keep prose minimal.

### Comparison

Use aligned columns/rows with identical comparison dimensions. Do not let each option have a different content structure.

### Process / timeline

Use when sequence and handoffs matter. Highlight the bottleneck or intervention point rather than drawing all steps with equal weight.

### Recommendation / next steps

Prefer:

- action
- owner
- timing
- dependency
- decision needed

over generic bullet lists.

## 5. Anti-AI visual patterns

Avoid defaulting to:

- three identical rounded cards with icons
- giant gradients used only to make an empty page look designed
- excessive glow / glassmorphism
- random illustration that does not provide evidence
- every page using a different visual metaphor
- decorative circles, arrows, blobs, pills, or badges with no information function
- equal visual weight for every item

A consulting deck should look intentional, not generated from a component library prompt.

## 6. Typography

Use a limited scale, for example:

```text
Action title: 24–32 pt
Section title: 28–36 pt
Key number: 28–48 pt
Body: 14–20 pt
Chart labels: 10–16 pt
Footnote/source: 8–11 pt
```

Exact values depend on room size and output format. Never solve content overload primarily by shrinking body text.

## 7. Spacing and grid

Use consistent page margins and a repeatable grid.

Recommended logic:

- reserve a stable title band
- reserve a stable source/footer band
- align major visual blocks to shared x/y anchors
- use generous whitespace between logical groups
- keep internal spacing smaller than spacing between groups

Consistency should be visible when flipping rapidly through the deck.

## 8. Color

Default to:

- one primary text color
- neutral secondary colors
- one accent color
- optional warning / negative color only when semantically necessary

Color should encode importance or category, not decorate empty space.

## 9. Images

Use images when they are evidence, context, or a strong explanatory device.

Good uses:

- product screenshot as proof
- customer journey screenshot
- map showing geographic pattern
- photographed physical process

Weak uses:

- stock image with no analytical function
- generic AI-generated business people
- abstract illustration replacing a diagram that could be explicit
