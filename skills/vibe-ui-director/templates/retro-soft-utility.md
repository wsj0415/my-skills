# Retro Soft Utility

## Purpose

Use this template for mobile-first or app-like products that should feel warm, nostalgic, calm, and approachable while preserving modern usability and task clarity.

Best fits:

- RSS / newsletter readers
- podcast and audio companion apps
- read-it-later products
- journaling / habit / lifestyle utilities
- light educational and family-friendly apps

Avoid as a default for:

- dense enterprise dashboards
- trading terminals
- monitoring consoles
- table-first operational workbenches

---

## Design Thesis

Create a soft retro product surface with modern information architecture and intuitive mobile UX. Nostalgia should lower cognitive pressure and add personality; it must never become a reason to imitate old software or weaken usability.

Target impression:

- calm
- friendly
- lightly playful
- tactile without heavy skeuomorphism
- distinctive without becoming childish

---

## Core Style Signals

- pastel, low-saturation color palette
- soft rounded cards and controls
- flat-first surfaces with mild depth
- subtle ambient shadows
- gentle decorative motifs
- generous whitespace
- clear content hierarchy
- modern bottom navigation for app flows

This is **not** scrapbook clutter, Y2K chaos, glossy glassmorphism, neon vaporwave, or decorative retro typography everywhere.

---

## Design Recipe

Before implementation, record:

```yaml
surface: retro-soft-utility
subject: <product>
primary_task: <one dominant task>
visual_thesis: <why this style fits>
color_mode: neutral-led | mono-accent | controlled-duotone
focal_event: <main visual/task focus>
release_zone: <quiet area>
primary_accent_role: <what coral/apricot encodes>
secondary_accent_role: <what teal/seafoam encodes>
media_role: <real product content used visually>
signature: <one memorable element>
```

Retry / polish passes should preserve this recipe unless new evidence reveals a usability, brand, or product-fit problem.

---

## Color System

Recommended roles:

- **background**: mist mint, pale sage, fog blue, powder grey
- **primary surface**: warm cream, pale ivory, light oatmeal
- **primary accent**: soft coral, apricot, muted tangerine
- **secondary accent**: dusty teal, seafoam, muted aqua
- **text**: desaturated deep slate, blue-grey, ink teal
- **support tones**: sand, soft peach, mist green

Preferred color modes:

- Neutral-led
- Mono-accent
- Controlled Duotone

Use Functional Multicolor only when the product genuinely needs many semantic states.

### Color constraints

- one dominant background family
- one warm primary accent
- one cool secondary support accent
- avoid pure black, harsh white, and hyper-saturated colors
- avoid aggressive multi-color gradients
- every additional color must have a hierarchy, semantic, or brand role
- decoration must never reduce reading contrast

### Default attention budget

Use these as a heuristic, not a literal paint-by-numbers rule:

- 60–75% quiet background field
- 15–25% warm/light surfaces
- 8–15% primary accent
- 3–8% secondary support accent

Do not distribute accent colors evenly across the screen.

---

## Focal Event + Release Zone

Every screen should define:

- **one focal event** — the thing the user should notice or act on first
- **one release zone** — a visually quiet area that lets the composition breathe

Examples of focal events:

- Today’s Brief
- current playback card
- Add Feed
- featured saved article

Examples of release zones:

- quiet header field
- empty background area
- low-information decorative zone
- generous footer spacing

Do not make every section equally loud.

---

## Typography

- **brand/logo**: retro script or soft display face only for branding
- **headings**: rounded or humanist sans
- **body**: highly legible modern sans-serif
- **metadata/durations**: compact sans; tabular numerals when useful

Never use decorative retro fonts for paragraph text, navigation, form labels, or primary controls.

---

## Shape Language

Prefer:

- large rounded rectangles
- friendly circular icon containers
- soft control shapes
- light border definition
- restrained tactile depth

Avoid:

- heavy bevels
- glossy plastic imitation
- thick outlines everywhere
- turning every object into the same rounded pastel blob

---

## Surface Treatment

Flat-first with optional softness:

- flat color planes
- very soft ambient shadow
- mild depth separation
- optional subtle grain
- optional paper-like softness
- optional small cloud, curve, or simple geometric motifs

Avoid strong glass blur, metallic chrome, embossed surfaces, or gradients on every card.

---

## Composition

- one primary card or listening object per screen
- moderate information density
- clear rounded grouping
- calm asymmetry is allowed
- generous outer margins
- decoration stays subordinate to content

Good patterns:

- quiet brand/header area + large focal card
- centered hero card with small supporting modules
- stacked cards with a consistent rhythm
- bottom navigation with obvious selected state

Avoid feature-card spam, badge overload, or giving every section the same visual weight.

---

## Product-as-Visual-Material

Use real product content as the main visual material whenever possible.

For reading/listening products this includes:

- Today’s Brief card
- podcast queue
- source chips / favicons
- saved article cards
- listening progress
- waveform / playback bar
- feed category labels

Real product proof should carry more visual weight than generic illustration.

---

## Interaction Model

The style may be nostalgic; behavior must remain modern.

Require:

- clear bottom navigation
- large touch targets
- strong selected states
- one primary action per screen
- frictionless save / like actions
- low-cognitive playback controls
- one-handed mobile use where relevant

Possible gestures:

- tap
- long-press for quick actions
- swipe to save/archive when discoverable
- lightweight tab switching
- bottom sheets for source management

Do not rely on color alone for state.

---

## Motion Register

Default motion register: **Polish**, occasionally **Expressive** for onboarding or brand moments.

Appropriate motion:

- gentle card entrance
- soft fade/translate transitions
- button press feedback
- tab selection easing
- small waveform or playback motion
- subtle floating decorative accent
- save / like state transition

Avoid:

- cinematic scroll choreography inside utility flows
- heavy 3D hero motion in everyday app screens
- constant motion near reading content
- effect stacking

Always provide reduced-motion fallback for decorative movement and non-essential waveform animation.

---

## Anti-Slop Rules

Reject:

- generic SaaS card layout merely recolored into pastel
- random cute icons without information roles
- fake retro poster styling
- childish illustration overload
- low-contrast pastel misuse
- scrapbook tape/sticker clutter without product meaning
- decorative logo type repeated inside functional UI
- every card receiving identical hover/lift animation

The goal is **warm utility**, not “cute UI”.

---

## Routing Signals

Prefer this template when users ask for:

- retro app design
- vintage but modern mobile UI
- pastel nostalgic interface
- soft playful utility app
- calm listening / reading app
- warm flat mobile design

Do not route here solely because the user said “retro” if the product requires dense operational data or professional monitoring.

---

## Example Fit — Personal RSS + Daily Podcast App

Strong fit for an app that:

- lets users subscribe to RSS feeds
- aggregates a daily news brief
- converts the brief into a listenable podcast
- supports Like as a preference signal
- supports Save as read/listen later
- lets users add custom feeds or import OPML
- supports commuting / walking / driving listening scenarios

Recommended screen archetypes:

- **Today**: Today’s Brief is the focal event
- **Listen**: playback-first, low-distraction screen
- **Saved**: bookmarked stories and liked topics
- **Sources**: feed management and inclusion rules
- **Me**: voice, briefing length, generation and playback preferences

Design target:

> A warm personal morning radio companion, not a cold RSS dashboard.

---

## Quality Gate

Before shipping, verify:

- one focal event is obvious within 5 seconds
- a release zone exists
- colors remain soft but readable
- main tasks are more prominent than decorative motifs
- save / like / play semantics are distinct
- touch targets are comfortable
- decoration can be removed without breaking hierarchy
- the interface feels calm rather than childish
- the UI feels like a real product, not a styled mockup
