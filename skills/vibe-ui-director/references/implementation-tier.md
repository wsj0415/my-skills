# Implementation Tier Router

Choose the lowest implementation tier that satisfies the design goal, project constraints, browser support, and verification budget.

## Tier 0 — Static / No Motion

Use when:
- motion does not improve comprehension
- task frequency is very high
- performance/accessibility constraints dominate

Tools:
- HTML/CSS
- static images
- layout / typography / color only

## Tier 1 — CSS Native

Use for:
- hover/focus/press
- simple enter/exit
- clip-path reveal
- simple scroll-linked progress/reveal where support is acceptable
- View Transitions where appropriate

Prefer CSS when it provides the same result with less JS and lifecycle complexity.

## Tier 2 — React Motion / Motion Library

Use for:
- component state transitions
- layout continuity
- AnimatePresence-style enter/exit
- gesture / drag
- interruptible spring motion
- product UI demos

Best when motion is tied to React state and component lifecycle.

Do not introduce a motion runtime if the project already has an established alternative unless there is a strong reason.

## Tier 3 — GSAP / Timeline Orchestration

Use for:
- complex multi-element choreography
- ScrollTrigger / pinned scenes
- horizontal scroll narratives
- scrubbed sequences
- SplitText / masking sequences
- FLIP-style layout storytelling
- precise timeline coordination across independent elements

Rules:
- scope and cleanup animations in component frameworks
- one primary timeline owner per scene
- avoid mixing GSAP and React motion on the same element/tree without a clear ownership boundary
- add reduced-motion branch

## Tier 4 — 2.5D Layered Media

Use for:
- layered PNG/WebP/AVIF composition
- screenshot depth
- foreground/midground/background parallax
- spatial hero without real 3D geometry

Implementation may be CSS transforms, Canvas, or Three.js planes depending on need.

Start with CSS if sufficient. WebGL is not automatically required.

## Tier 5 — Shader / Particle / Canvas Generative

Use for:
- semantic animated atmosphere
- image displacement/transition
- topology/flow/particle representation
- generative visual identity

Choose Canvas for moderate 2D counts/effects; GPU/shader for large full-screen or particle workloads.

Requirements:
- deterministic time/progress where feasible
- DPR/resolution budget
- reduced-motion fallback
- no content legibility regression

## Tier 6 — Full Three.js / R3F / WebGL Scene

Use for:
- 3D product object
- real spatial interaction
- camera choreography
- GLTF animation
- immersive hero/showcase

Requirements:
- pixel-ratio cap / adaptive resolution
- frame-rate independent motion
- resource disposal on teardown
- mobile complexity reduction
- reduced-motion behavior
- actual browser verification

---

# Decision Tree

```text
Can static design communicate the goal?
  YES → Tier 0
  NO ↓

Can CSS handle the motion/effect cleanly?
  YES → Tier 1
  NO ↓

Is the motion primarily component/state/layout-driven?
  YES → Tier 2
  NO ↓

Is it timeline/scroll choreography?
  YES → Tier 3
  NO ↓

Can layered 2D assets create the depth?
  YES → Tier 4
  NO ↓

Is the visual mainly generative/full-screen/particle based?
  YES → Tier 5
  NO ↓

Does the experience genuinely require 3D scene/camera/object interaction?
  YES → Tier 6
```

Do not escalate tiers because a higher tier sounds more premium.

---

# Library Ownership Rule

Prefer one owner for each motion domain:

- CSS owns simple state transitions.
- React motion owns component/layout/gesture motion.
- GSAP owns complex scroll/timeline scenes.
- Three.js owns 3D render state.

Avoid two animation engines mutating the same transform simultaneously.

If combining systems, isolate boundaries:

```text
GSAP controls section progress
↓
React component receives normalized progress
↓
component owns internal state animation
```

or

```text
Three.js canvas owns 3D scene
DOM layer owns UI controls
```

---

# Performance Escalation Cost

Every tier adds responsibilities.

| Tier | Extra responsibility |
|---|---|
| 0 | none beyond normal UI |
| 1 | browser support / reduced motion |
| 2 | client bundle / lifecycle |
| 3 | timeline cleanup / scroll behavior |
| 4 | asset layering / crop / mobile fallback |
| 5 | render budget / deterministic verification |
| 6 | GPU memory / disposal / adaptive quality / fallback |

A higher tier is justified only when its design benefit exceeds these costs.

---

# Existing Project Rule

Before adding dependencies:

1. inspect `package.json`
2. detect existing animation/runtime conventions
3. reuse established engine where it can satisfy the requirement
4. avoid adding GSAP + Motion + anime + Three.js simultaneously without explicit architectural reason

For small tasks, dependency expansion is usually a design failure, not sophistication.

---

# Verification by Tier

## Tier 0–1
- desktop/mobile screenshot
- hover/focus/reduced motion

## Tier 2
- enter/exit
- interrupted transition
- state changes
- mobile/touch behavior

## Tier 3
- start/mid/end scroll states
- pinned section release
- reverse scrolling
- resize cleanup

## Tier 4
- layer composition
- mobile crop
- pointer-off fallback
- reduced-motion static scene

## Tier 5
- start/mid/end deterministic frame where feasible
- CPU/GPU sanity
- resolution fallback
- blank/error artifact check

## Tier 6
- canvas actually renders
- start/mid/end scene states
- resize / route unmount
- GPU cleanup
- mobile quality tier
- reduced-motion behavior

