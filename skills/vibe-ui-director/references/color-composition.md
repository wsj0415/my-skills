# Color & Composition Discipline

本 reference 从受约束的编辑设计系统中吸收方法，但目标不是把所有 UI 做成单色海报。核心是：**颜色必须有角色，视觉能量必须有主次，设计决策必须稳定可复现。**

---

# 1. Design Recipe Manifest

在高价值新页面、品牌入口、marketing/launch 页面，或用户明确要求强视觉方向时，在实现前解析一个简短的 `Design Recipe`。

```yaml
surface: <productivity|dashboard|marketing|launch|portfolio|playful>
subject: <页面最重要的真实业务对象>
primary_task: <用户最重要的动作>
visual_thesis: <一句话>
base_surface: <主要背景/基底角色>
color_mode: <neutral-led|mono-accent|duotone|functional-multicolor>
dominant_role: <主要颜色承担什么>
accent_role: <强调色承担什么>
semantic_colors: <success/warning/error/info，如需要>
focal_event: <页面最强视觉事件>
release_zone: <明显更安静的区域>
visual_tension: <relaxed|balanced|assertive>
media_role: <proof|explanation|atmosphere|none>
signature: <一个主要记忆点>
```

不要把 manifest 当作展示给用户的冗长模板。它是设计决策的稳定器。

对于相同产品、相同 Design Contract、相同页面目标，不要在每次重试时随机换配色、radius、构图人格或 signature。只有新证据证明原方向失败时才改变。

---

# 2. Color Roles Before Color Values

先决定角色，再决定具体颜色。

至少区分：

- `base / substrate`：页面主要基底；
- `foreground`：主要信息；
- `muted`：次级信息；
- `dominant brand/product color`：承担主要品牌或结构任务；
- `accent`：承担少量注意力任务；
- `semantic`：success / warning / destructive / info。

## Hard rule

> 第二种、第三种颜色不能只因为“页面太空”就出现。

每个非中性色必须回答：

- 它编码什么？
- 它强调什么？
- 如果去掉，信息是否变差？

如果没有答案，优先删除。

---

# 3. Color Budget

Color budget 是注意力预算，不是强制两色印刷规则。

## Neutral-led

适合：productivity、dashboard、enterprise、docs。

- 大面积 neutral base；
- 1 个主品牌/交互色；
- semantic colors 只在状态需要时出现；
- 不用多个装饰色制造“丰富度”。

## Mono-accent

适合：强品牌入口、文化/编辑型页面、单一产品故事。

- 一个主色承担大部分品牌表达；
- 明度/透明度/密度形成层级；
- 允许少量中性色和 semantic exception。

## Duotone / controlled pair

适合：marketing、launch、editorial、具有明确对照关系的品牌语言。

- dominant color 负责主要视觉面积；
- accent color 只承担明确角色，例如 CTA、annotation、selected object、关键数据；
- 两色不是平均散布。

## Functional multicolor

适合：复杂数据可视化、状态系统、分类系统。

- 颜色必须是编码系统；
- 保证 legend / text / icon 等非颜色冗余；
- 不能为了“遵守少色原则”损害正确性。

---

# 4. Focal Event + Release Zone

一个高质量页面不是每处都“精致”和“有设计感”。它需要能量差。

每个 Page / Hero / 高价值 Section 默认定义：

- **1 个 Focal Event**：最强视觉事件；
- **1 个 Release Zone**：明显更安静、低信息密度的区域。

可能的 focal event：

- oversized product object;
- abnormal scale relationship;
- decisive typography;
- extreme media crop;
- real product demo;
- concentrated data visualization;
- one meaningful motion event.

可能的 release device：

- whitespace;
- calm neutral surface;
- sparse support type;
- lower-detail media region;
- quiet alignment;
- reduced motion.

## Failure signal

如果 Squint Test 后所有区域权重接近，页面通常缺乏导演感。

不要用 decorative microcopy、badge、icon、grain、glow 填掉 release zone。

---

# 5. Visual Tension

## Relaxed

不是“所有东西都小、淡、稀疏”。

正确结构：

```text
one audacious event
+ broad release
+ sparse support
```

## Balanced

```text
one clear event
+ structured support
+ readable release
```

## Assertive

```text
one dominant public gesture
+ compressed but subordinate support
+ still one release zone
```

无论哪种 tension，默认仍只有一个主要 focal event。

---

# 6. Controlled Imperfection

轻微 grain、texture、misregistration、rough edge、handwritten annotation 等，可以为 editorial / cultural / tactile 品牌增加人味，但不是默认 UI 质量手段。

规则：

- Productivity / dashboard 默认不使用人工瑕疵作为 surface noise；
- Contemporary marketing 最多 0–2 类轻微 texture signal；
- tactile / archival / explicit print direction 才允许更明显处理；
- imperfection 必须服从同一个 visual language；
- 不要为了“去 AI 味”随机增加噪点、纸张、胶片、扫描线。

---

# 7. Stable Design Decisions

AI UI 的一种隐性问题是：每次生成都换一个“好看的方向”。

Vibe UI Director 应保持：

- 同一 Product 的 Design Contract 稳定；
- 同一 color role 稳定；
- 同一 focal event 在 polish retry 中稳定；
- 同一 release zone 不被后续装饰填满；
- 只有 evidence / usability / brand conflict 才触发方向重建。

这比每次随机寻找“更高级配色”更接近真实设计系统。

---

# 8. Accessibility Overrides Aesthetic Constraint

少色、单色、双色都不能破坏：

- contrast；
- semantic state distinction；
- focus visibility；
- chart/category comprehension；
- destructive warning clarity。

审美限制永远低于正确性和可访问性。

---

# Quick Audit

- 每个非中性色是否有明确 role？
- accent 是否真的稀缺？
- semantic color 是否被 decorative use 稀释？
- 是否存在一个明确 focal event？
- 是否存在一个真正安静的 release zone？
- Squint Test 是否能识别主次？
- retry 是否无理由改变 Design Contract？
- 是否用 texture/noise 来掩盖平庸构图？
