# V3 Architecture — Taste × Motion × Media × Verification

V3 的目标不是让 `vibe-ui-director` 变成动画教程，而是让它成为一个能正确决定 **是否需要视觉媒体、是否需要动效、需要多强、采用哪个实现层级、如何验证** 的 UI Design Orchestrator。

## Core thesis

```text
UI Quality
=
Product Specificity
× Design Coherence
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
Static Design Foundation
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
4. color
5. layout
6. visual media
7. motion
8. micro-interaction polish

如果关闭所有动画后页面失去层级、可读性或产品解释能力，先修静态设计。

---

# Three Routers

## 1. Visual Media Router

负责回答：

- 页面是否需要真实视觉媒体？
- screenshot / photo / illustration / texture / 2.5D / shader / 3D 哪个层级足够？
- 背景是否只是装饰，还是承担语义？

详见 `visual-media.md`。

## 2. Motion Router

负责回答：

- 这个 surface 是否应该动？
- 它属于 functional / polished / expressive / cinematic 哪一种 motion register？
- signature motion 是什么？
- 哪些高频交互应该保持近乎无动画？

详见 `motion-router.md`。

## 3. Implementation Tier Router

负责回答：

- CSS 是否已经足够？
- React/Motion 是否合适？
- 何时应该 GSAP？
- 何时使用 2.5D parallax？
- shader / particle / Three.js 是否真的值得其复杂度？

详见 `implementation-tier.md`。

---

# Absorb / Delegate / Reject

## Absorb

把上游优秀 Skill 的**决策机制**吸收进 Vibe UI Director：

- motion frequency / purpose / context weighting
- cinematic narrative pacing
- one-surface-one-motion-idea
- visual media ladder
- implementation cost escalation
- deterministic screenshot verification for time-based visuals
- reduced-motion / performance budgets
- reference analysis instead of visual copying

## Delegate

不在本 Skill 重写完整 API 教程：

- GSAP / ScrollTrigger / SplitText / Flip API
- Three.js / R3F API
- GLSL cookbook
- particle physics implementation
- full animation library recipes

如果环境中有对应 Skill，调用或参考它；如果没有，只给实现原则和最小必要模式。

## Reject

明确拒绝这些做法：

- 想“高级”就自动上 Three.js
- 想“有氛围”就默认 purple/blue glow
- 每个 section 都 fade-up + stagger
- 每张卡多个 perpetual animations
- 使用 shader / particle 代替真实产品素材
- 为 Awwwards 感牺牲核心任务、移动端或性能
- 为了动画引入第二套互相竞争的 animation runtime
- 在没有实际浏览器验证时声称 WebGL / motion 已经顺滑

---

# Surface Register

页面/区域先分类，再决定视觉强度。

| Surface | Primary goal | Motion | Media |
|---|---|---|---|
| Productivity / CRUD | task speed | Functional | minimal, semantic |
| Dashboard / Workbench | scan + act | Functional / Polish | data + product surfaces |
| SaaS marketing | explain + convert | Polish / Expressive | product screenshots / demos |
| Product launch | desire + narrative | Cinematic | hero media / renders / filmic imagery |
| Portfolio / studio | authorship | Expressive / Cinematic | work-led media |
| Kids / playful | engagement + comprehension | Polish / Playful | illustration / character / tactile media |

不要把 marketing register 移植到高频后台操作。

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
如果真实 screenshot 能解释产品，不用粒子系统代替。

---

# Signature Budget

一个 Page 默认：

- `1` 个 primary signature visual/motion
- `0–2` 个 supporting motion motifs
- 高频操作区不共享 marketing motion 语言

一个 Card / Surface 默认只承担 **一个主要 motion idea**。

Motion variety 来自语义，不来自不断增加特效数量。

---

# Verification Contract

静态 UI：Desktop + Mobile screenshot。

复杂 Motion：至少验证：

1. initial state
2. mid-motion / mid-scroll state
3. settled / end state
4. reduced-motion state
5. mobile fallback

对于可确定性冻结的动画，优先提供 time/progress hook（如 `?t=N` 或固定 progress）用于可重复截图。

视觉正确性与性能正确性必须分开判断：

- Looks right?
- Moves right?
- Runs acceptably?
- Falls back safely?

任何一项未验证，不要声称完整通过。
