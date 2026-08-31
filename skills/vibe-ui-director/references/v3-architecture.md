# V3.1 Architecture — Taste × Composition × Motion × Media × Verification

V3.1 的目标不是让 `vibe-ui-director` 变成动画、配色或 WebGPU 教程，而是让它成为一个能正确决定 **视觉主张是什么、颜色承担什么、页面能量如何分布、什么内容本身就是视觉素材、是否需要动效、需要多强、采用哪个实现层级、如何验证** 的 UI Design Orchestrator。

## Core thesis

```text
UI Quality
=
Product Specificity
× Design Coherence
× Composition Clarity
× Interaction Completeness
× Media Relevance
× Motion Meaning
× Rendered Verification
− AI Default Bias
− Unnecessary Complexity
```

任何高级视觉效果都必须同时通过 `meaning`、`fit`、`cost`、`verification` 四个门槛。

---

## Architecture layers

```text
Product / Task Context
        ↓
Reference Evidence
        ↓
Art Direction
        ↓
Design Recipe + Static Foundation
        ↓
Color / Composition Discipline
        ↓
Product-as-Visual-Material Check
        ↓
Visual Media Router
        ↓
Motion Router
        ↓
Implementation Tier Router
        ↓
Build
        ↓
Browser / Screenshot / Motion Verification
        ↓
Anti-Slop + Performance Gate
        ↓
Ship Readiness
```

### Why static foundation comes first

动画不能拯救失败的布局。执行顺序保持：

1. information architecture
2. typography
3. spacing
4. color roles
5. composition / focal hierarchy
6. layout
7. product-native proof / visual media
8. motion
9. micro-interaction polish

如果关闭所有动画后页面失去层级、可读性或产品解释能力，先修静态设计。

---

# Five Decision Layers

## 1. Color & Composition Discipline

负责回答：

- 非中性色分别承担什么角色？
- 页面是否有明确的 focal event？
- 是否有一个真正安静的 release zone？
- visual tension 是 relaxed / balanced / assertive？
- retry 是否无理由改变整个设计人格？

详见 `color-composition.md`。

关键原则：

> Color is an information and attention budget, not decoration inventory.

> One focal event + one release zone beats equal emphasis everywhere.

## 2. Product-as-Visual-Material Check

特别适用于 developer tools、AI infrastructure、observability、data tooling、automation、creative coding、GPU/WebGL 等产品。

负责回答：

- 产品能力本身能否成为 Hero / Feature proof？
- 是否可以展示真实 code → output、command → artifact、workflow → result？
- 页面 section 是否可以直接来自产品能力，而不是 generic feature cards？
- 高阶 canvas/GPU 层是否只是 progressive enhancement？

详见 `product-as-visual-material.md`。

关键原则：

> Show the product doing the thing it claims to do.

## 3. Visual Media Router

负责回答：

- 页面是否需要真实视觉媒体？
- screenshot / photo / illustration / texture / 2.5D / shader / 3D 哪个层级足够？
- 背景是否只是装饰，还是承担语义？

详见 `visual-media.md`。

## 4. Motion Router

负责回答：

- 这个 surface 是否应该动？
- 它属于 functional / polished / expressive / cinematic 哪一种 motion register？
- signature motion 是什么？
- 哪些高频交互应该保持近乎无动画？

详见 `motion-router.md`。

## 5. Implementation Tier Router

负责回答：

- CSS 是否已经足够？
- React/Motion 是否合适？
- 何时应该 GSAP？
- 何时使用 2.5D parallax？
- shader / particle / Three.js / WebGPU 是否真的值得其复杂度？

详见 `implementation-tier.md`。

---

# Design Recipe

对于高价值新页面、品牌入口、marketing/launch 页面，或用户明确要求强视觉方向时，先稳定这些决策：

```yaml
surface: <surface register>
subject: <one real product/domain subject>
primary_task: <primary task>
visual_thesis: <one sentence>
color_mode: <neutral-led|mono-accent|duotone|functional-multicolor>
dominant_role: <what dominant color means>
accent_role: <what accent means>
focal_event: <one strongest event>
release_zone: <one quiet region>
visual_tension: <relaxed|balanced|assertive>
media_role: <proof|explanation|atmosphere|none>
signature: <one main memory point>
```

同一 Product / Design Contract / page goal 的 retry 默认保持这些决定稳定。不要每次生成都随机换一个“更好看的方向”。

---

# Absorb / Delegate / Reject

## Absorb

把上游优秀 Skill / 产品实现的**决策机制**吸收进 Vibe UI Director：

- motion frequency / purpose / context weighting
- cinematic narrative pacing
- one-surface-one-motion-idea
- visual media ladder
- implementation cost escalation
- deterministic screenshot verification for time-based visuals
- reduced-motion / performance budgets
- reference analysis instead of visual copying
- machine-readable / explicit design recipe thinking
- color role budget rather than arbitrary palette expansion
- focal event + release zone composition
- stable design decisions across retries
- capability-as-proof for technical products
- product-native section structures
- progressive enhancement for GPU/canvas visuals

## Delegate

不在本 Skill 重写完整 API 教程：

- GSAP / ScrollTrigger / SplitText / Flip API
- Three.js / R3F API
- WebGPU / vGPU API
- GLSL / WGSL cookbook
- particle physics implementation
- full animation library recipes
- mono-color image-generation recipes

如果环境中有对应 Skill，调用或参考它；如果没有，只给实现原则和最小必要模式。

## Reject

明确拒绝这些做法：

- 想“高级”就自动上 Three.js / WebGPU
- 想“有氛围”就默认 purple/blue glow
- 把“单色/双色”误解成所有产品的通用高级审美
- 无语义地增加第二、第三个 accent color
- 所有区域视觉权重相同
- 用 microcopy / badges / icons 填满本应安静的 release zone
- 每个 section 都 fade-up + stagger
- 每张卡多个 perpetual animations
- 使用 shader / particle 代替真实产品素材
- 为 Awwwards 感牺牲核心任务、移动端或性能
- 为了动画引入第二套互相竞争的 animation runtime
- 用 developer-site 的 prism / shader / code aesthetic 套到无关产品
- 在没有实际浏览器验证时声称 WebGL / WebGPU / motion 已经顺滑

---

# Surface Register

页面/区域先分类，再决定视觉强度。

| Surface | Primary goal | Composition | Motion | Media |
|---|---|---|---|---|
| Productivity / CRUD | task speed | hierarchy-first | Functional | minimal, semantic |
| Dashboard / Workbench | scan + act | focal anomaly + quiet support | Functional / Polish | data + product surfaces |
| SaaS marketing | explain + convert | claim + proof | Polish / Expressive | product screenshots / demos |
| Developer product | understand + believe | capability-as-proof | Functional / Polish / Expressive | code + output + live proof |
| Product launch | desire + narrative | directed focal events | Cinematic | hero media / renders / filmic imagery |
| Portfolio / studio | authorship | deliberate tension | Expressive / Cinematic | work-led media |
| Kids / playful | engagement + comprehension | strong focal + clear release | Polish / Playful | illustration / character / tactile media |

不要把 marketing register 移植到高频后台操作，也不要把 developer-site aesthetic 移植到不相关业务。

---

# Complexity Budget

每个高级效果都必须付出成本：

```text
Complexity Cost
= runtime weight
+ CPU/GPU cost
+ implementation risk
+ responsive risk
+ accessibility fallback
+ maintenance cost
```

选择**能实现设计目标的最低复杂度层级**。

如果 CSS 能完成，不上 GSAP。
如果高质量图片 + 2.5D 能完成，不上完整 3D。
如果真实 screenshot / demo 能解释产品，不用粒子系统代替。
如果 server-rendered HTML + progressive GPU enhancement 能成立，不让 canvas 成为唯一内容层。

---

# Signature & Attention Budget

一个 Page 默认：

- `1` 个 primary focal/signature event
- `1` 个 release zone
- `0–2` 个 supporting motion motifs
- 稀缺 accent color
- 高频操作区不共享 marketing motion 语言

一个 Card / Surface 默认只承担 **一个主要 motion idea**。

视觉变化来自语义、内容和比例，不来自不断增加颜色或特效数量。

---

# Progressive Enhancement Contract

Tier 5–6 或 WebGPU/WebGL 类 Hero 必须检查：

- HTML 内容在视觉层失败时仍有意义；
- GPU/canvas visual 可以被 capability / performance policy 关闭；
- canvas 纯装饰时不参与可访问性树；
- visual layer 不阻断主内容 pointer events；
- expensive asset 仅在需要时 preload；
- resize / theme / route unmount 有明确生命周期；
- renderer 显式 cleanup / dispose；
- mobile / reduced-motion 有 fallback。

高阶渲染层是 enhancement，不是可用性单点故障。

---

# Verification Contract

静态 UI：Desktop + Mobile screenshot。

复杂 Motion / GPU visual：至少验证：

1. initial state
2. mid-motion / mid-scroll state
3. settled / end state
4. reduced-motion state
5. mobile fallback
6. enhancement-disabled / failure-safe state（Tier 5–6 适用）

对于可确定性冻结的动画，优先提供 time/progress hook（如 `?t=N` 或固定 progress）用于可重复截图。

视觉正确性与性能正确性必须分开判断：

- Looks right?
- Hierarchy reads right?
- Moves right?
- Runs acceptably?
- Falls back safely?

任何一项未验证，不要声称完整通过。
