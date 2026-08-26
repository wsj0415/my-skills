# Motion Router

Motion is not a decoration layer. It is a routing decision based on task frequency, product context, semantic purpose, and complexity budget.

## Step 1 — Should this move?

Before adding animation, classify frequency and purpose.

### Frequency

- Very high frequency / keyboard-heavy: near-zero motion by default.
- Frequent UI controls: subtle state feedback only.
- Occasional flows: standard transitions are appropriate.
- Rare / first-time / marketing: stronger choreography may be justified.

### Purpose

Every animation must primarily serve one of:

1. **Feedback** — confirm input or state change.
2. **Continuity** — show that an object moved or transformed rather than disappeared.
3. **Orientation** — explain where content came from or where it went.
4. **Hierarchy** — guide attention through a meaningful sequence.
5. **Explanation** — demonstrate how the product works.
6. **Narrative** — create a story arc for marketing / brand surfaces.
7. **Delight** — only when personality itself is part of the product goal.

If the strongest reason is only “it looks cool”, remove it unless the page is explicitly creative/showcase work.

---

# Motion Registers

## Functional

Best for:
- productivity tools
- admin / CRUD
- dashboards
- tables / forms
- keyboard-first workflows

Characteristics:
- immediate feedback
- short transitions
- low amplitude
- state clarity over spectacle
- no smooth-scroll dependency

## Polish

Best for:
- consumer apps
- polished SaaS product surfaces
- e-commerce
- professional product marketing

Characteristics:
- consistent easing signature
- restrained stagger
- refined enter/exit
- subtle continuity

## Expressive

Best for:
- portfolios
- creative products
- playful experiences
- campaign pages

Characteristics:
- stronger typography motion
- cursor-aware or gesture-aware moments where justified
- asymmetric timing
- more visible transformation

## Cinematic

Best for:
- product launches
- premium brand storytelling
- case studies
- immersive showcases

Characteristics:
- scene-based scroll choreography
- image masks
- section acts
- larger temporal gestures
- strong media dependency

Cinematic is not a synonym for “more animation”. It requires a narrative structure.

---

# Context Weighting

Use these defaults as a routing prior, not law:

| Context | Primary | Secondary |
|---|---|---|
| Productivity tool | Functional | Polish |
| SaaS dashboard | Functional | Polish |
| Consumer app | Polish | Functional |
| E-commerce | Polish | Functional |
| Marketing landing | Polish | Expressive |
| Product launch | Cinematic | Polish |
| Portfolio / studio | Expressive | Cinematic |
| Kids / playful | Expressive | Polish |

Do not apply productivity-duration rules universally to creative or cinematic surfaces.

---

# Motion Signature

Every Page should define:

- `Motion Register`
- `Primary Motion Purpose`
- `Signature Motion`
- `Supporting Motifs` (0–2)
- `Reduced Motion Fallback`

Example:

```text
Register: Polish
Purpose: Explanation
Signature: product screenshot layers assemble into the final workflow
Supporting: subtle masked image reveal
Fallback: static composed screenshot with opacity-only transition
```

---

# One Surface, One Motion Idea

A surface should not simultaneously float, glow, tilt, pulse, shimmer, rotate and parallax.

For autonomous / perpetual animation:

> One card or product surface = one dominant perpetual motion idea.

Multiple state-driven micro-interactions are allowed, but they must not compete visually.

---

# Cinematic Narrative

When routing to Cinematic, use a simple narrative arc:

```text
Hook
  ↓
Build
  ↓
Reveal / Climax
  ↓
Resolution / CTA
```

Each section should have a role in the arc. Scroll animation without progression is not storytelling.

Good cinematic patterns include:

- image mask reveal
- product scale transition
- sticky chapter progression
- scroll-linked camera / image movement
- text reveal tied to scene change
- controlled marquee as transition device

Avoid:

- every section using the same fade-up
- parallax over an otherwise empty gradient
- pinned sections with no information payoff
- custom cursor without product or brand reason

---

# Timing Guidance

Timing is context-dependent. Start from purpose, frequency and distance.

General priors:

- press feedback: immediate / very short
- tooltip / small popover: short
- modal / drawer: moderate
- layout transition: moderate, interruptible
- marketing explanation: may be longer
- cinematic scene: may span scroll rather than fixed duration

Prefer selecting easing before tuning duration.

Use:
- ease-out for enter/exit response
- ease-in-out for on-screen movement / morphs
- linear only for constant-rate movement such as marquee/progress
- springs for interruptible gesture/layout motion

Avoid visible ease-in delay for routine UI response.

---

# Reduced Motion

`prefers-reduced-motion` is mandatory.

Fallback priority:

1. preserve information
2. preserve state change
3. remove directional travel / parallax / camera movement
4. reduce large scale changes
5. keep subtle opacity/color where useful

Reduced motion should not create a broken or visually empty composition.

---

# Motion Gaps

During `review` / `polish`, search not only for excessive animation but also abrupt state changes:

- conditional panels snapping in/out
- loading → content swaps
- expanded sections with no continuity
- tab content replacement
- success/error state replacement
- layout reordering

Fix only where continuity or comprehension improves. Do not animate every conditional render mechanically.
