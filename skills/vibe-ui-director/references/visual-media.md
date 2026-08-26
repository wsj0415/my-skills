# Visual Media Router

Visual media should explain, reinforce, or emotionally frame the product. Do not use generative effects as a substitute for meaningful product media.

## Visual Media Ladder

Choose the **lowest complexity level that fully serves the design goal**.

### Level 0 — Typography + Layout

Use when hierarchy, content and type already carry the page.

Good for:
- utility UI
- editorial sections
- settings / forms
- dense workbenches

### Level 1 — Real Product Media

Prefer whenever possible:

- real screenshots
- product UI crops
- real photography
- illustration
- diagrams
- real charts / visualized domain objects

For SaaS/product marketing this is usually the strongest default because it proves the product is real.

### Level 2 — Atmosphere

Support Level 1 with restrained:

- grain / noise
- mesh / aura
- geometric line work
- grid / topology
- radial light
- paper / material texture
- subtle gradients

Atmosphere should support legibility, not become the subject unless the brand specifically calls for it.

### Level 3 — Layered 2.5D

Use layered transparent assets / screenshots / illustrations with depth-based motion.

Good when:
- source assets can be separated into foreground / midground / background
- a spatial hero is wanted without full 3D cost
- product imagery benefits from mouse or scroll parallax

Prefer 2.5D over full Three.js when it achieves the same perceptual goal with less complexity.

### Level 4 — Generative Surface

Includes:
- shader gradient / aurora
- noise / fbm / domain warp
- particles
- constellation / flow fields
- image displacement / distortion

Use when the generative behavior has a semantic or brand relationship.

Do not treat shaders or particles as “visual media” equivalent to a product screenshot.

### Level 5 — Full 3D / WebGL Scene

Use for:
- real 3D product visualization
- camera-led product storytelling
- spatial data / object interaction
- immersive launch / portfolio work

This is the most expensive tier and must justify runtime, responsive, accessibility, asset and maintenance cost.

---

# Media Selection Questions

Before choosing a tier, answer:

1. What does the user need to understand or feel?
2. Is there real product/media evidence available?
3. Can a static image explain it better than an effect?
4. Does depth add meaning or only novelty?
5. Can the effect survive mobile and reduced-motion fallback?
6. Will the media remain useful after the novelty wears off?

---

# Atmosphere Before Surface

Material effects such as glass need an environment to interact with.

Wrong:

```text
flat white background
+ transparent card
+ blur
= “glass”
```

Better:

```text
controlled atmosphere
+ semantic color/light field
+ foreground surface
+ readable content
```

Build order:

1. background base
2. media / atmosphere
3. content hierarchy
4. surface treatment
5. motion

Do not let atmosphere reduce text contrast or become a permanent distraction.

---

# Product-specific Surface Examples

## Developer / Infrastructure

Prefer:
- topology lines
- code / terminal fragments when real
- trace / event / node structures
- subtle grid
- product screenshots

Avoid generic sci-fi particles unless the product concept actually benefits.

## AI Creative Tool

May justify:
- generative shader
- layered visual output
- image transformation
- spatial scene

But the generated work/product output should usually remain the hero evidence.

## Enterprise Dashboard

Prefer:
- restrained surfaces
- real data visualization
- product surface crops

Avoid background motion behind dense tables and forms.

## Consumer / Brand

May justify:
- photography
- collage
- illustration
- large media plates
- editorial image sequencing
- cinematic transitions

---

# Image Background Rules

When using large background imagery:

- preserve a reliable text-safe region
- avoid placing body copy over high-detail areas
- provide responsive art direction, not one crop for all sizes
- use overlays only as much as needed for readability
- keep focal subject visible after mobile crop
- do not blur a weak image to fake depth

If text readability requires a 70% dark overlay, reconsider image choice or layout.

---

# 2.5D Rules

A typical layered scene:

```text
Background    → smallest movement
Midground     → medium movement
Foreground    → largest movement
```

Keep movement subtle. Depth should be perceived before it is consciously noticed.

Requirements:
- correct image color space
- stable aspect ratios
- explicit layer ordering
- mobile simplification
- reduced-motion static composition

Do not require WebGL merely to translate a flat image by a few pixels if CSS transforms are sufficient.

---

# Generative Surface Rules

Generative backgrounds must define:

- semantic reason
- dominant visual frequency
- contrast budget
- performance budget
- fallback

Examples:

```text
Observability event flow
→ connected particles may communicate event topology

Creative AI image tool
→ shader morph may communicate transformation

Generic CRM
→ particle constellation is probably decoration-only
```

---

# Full 3D Gate

Before using Three.js / R3F, require at least one strong reason:

- user manipulates a real 3D object
- camera movement explains product structure
- product is inherently spatial
- a launch/brand surface explicitly values immersion
- 3D is the signature visual, not a filler object

Reject full 3D when:

- a decorative floating orb is the only idea
- a screenshot or 2.5D composition communicates better
- mobile fallback would remove the main product explanation
- there is no budget for verification/performance cleanup

---

# Visual Evidence Rule

For product pages, visual evidence hierarchy is usually:

```text
real product proof
> real domain imagery
> purposeful illustration
> 2.5D composition
> generative atmosphere
> decorative effect
```

Do not invert this hierarchy just because a lower item looks more spectacular.
