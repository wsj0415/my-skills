# Retro Soft Utility — Regression Tests

Use these prompts to verify that `templates/retro-soft-utility.md` creates warm, nostalgic interfaces without degrading usability, readability, or product specificity.

The template should preserve modern interaction behavior even when the visual surface is retro-inspired.

---

## Test 1 — Personal RSS + Daily Podcast App

### Prompt

```text
Use the Retro Soft Utility template.

Design a mobile app for personal RSS subscriptions.
It should let me:
- add RSS feeds manually
- import feeds
- generate a daily news brief
- convert the daily brief into a listenable podcast
- like articles so recommendations improve
- save articles for later
- manage which sources participate in the daily brief

The app is mainly used during commuting, walking, and driving.
```

### Expected

- `Today’s Brief` becomes the primary focal event.
- Playback is more important than decorative retro styling.
- `Like` and `Save` have clearly different semantics.
- Bottom navigation is simple and thumb-friendly.
- Color palette is soft but readable.
- Real product objects such as brief cards, source chips, saved stories, and playback state become visual material.
- Driving/listening use case reduces interaction complexity.

### Reject

- generic pastel SaaS dashboard
- feature-card wall
- tiny playback controls
- retro script font used for body copy
- decorative stickers or clouds competing with content
- Like and Save shown as interchangeable heart/bookmark decoration without product meaning

---

## Test 2 — Nostalgia Without Usability Loss

### Prompt

```text
Redesign an existing mobile reading app with a vintage-inspired pastel style.
Make it feel nostalgic and friendly, but keep it practical for daily use.
Do not change the information architecture unless necessary.
```

### Expected

- Existing flows are preserved unless a usability problem justifies change.
- Retro treatment stays primarily in color, shape, brand details, and surface tone.
- Navigation, forms, reading typography, and controls remain modern.
- Contrast and touch targets remain production-appropriate.

### Reject

- decorative type in navigation
- reduced text contrast for aesthetic reasons
- rebuilding the whole product to resemble an old operating system
- changing working product structure merely to increase nostalgia

---

## Test 3 — One Focal Event + One Release Zone

### Prompt

```text
Create the Today screen for a soft retro RSS audio app.
The screen contains a greeting, Today’s Brief, top stories, continue listening, and recent saved items.
```

### Expected

- One element is clearly dominant: normally `Today’s Brief`.
- Secondary modules are quieter.
- A release zone exists around the dominant object or in the header/background field.
- Accent color is concentrated around the focal event or primary action.

### Reject

- every card has the same size, shadow, accent color, and prominence
- all sections look like equally important dashboard widgets
- decorative content fills all whitespace

---

## Test 4 — Color Role Budget

### Prompt

```text
Use mint, cream, coral, and teal in a Retro Soft Utility app.
Make the screen visually rich and colorful.
```

### Expected

The system should interpret roles rather than spread all colors evenly:

- mint / pale neutral: dominant field
- cream: surface grouping
- coral: primary action / focal emphasis
- teal: secondary support / selected states where justified

### Reject

- every component uses a different accent
- coral and teal are sprayed evenly across all cards
- saturation increases merely to make the UI feel more exciting

---

## Test 5 — Retro Typography Guard

### Prompt

```text
Make the entire RSS app feel more vintage by using a retro script font everywhere.
```

### Expected

- Refuse to use decorative script everywhere.
- Allow expressive display type for the logo or occasional brand heading.
- Keep reading text, tabs, forms, labels, and controls in a highly legible sans-serif.

---

## Test 6 — Product Material Before Illustration

### Prompt

```text
The home screen feels empty. Add cute retro illustrations and decorative shapes to make it more interesting.
```

### Expected

Before adding filler, improve composition using real product material:

- actual sources
- Today’s Brief
- article topics
- queue / listening progress
- waveform
- source favicons

Decorative illustration may be added only as secondary atmosphere.

### Reject

- illustration becomes the main visual while the actual product is hidden below the fold
- random clouds/stars/stickers added simply because the template is retro

---

## Test 7 — Playback / Driving Mode

### Prompt

```text
Design a driving-friendly playback screen for the RSS podcast app using Retro Soft Utility.
```

### Expected

- large play/pause and skip targets
- minimal required reading
- clear episode/current-story context
- strong progress state
- optional Save action if safe and simple
- decorative motion is reduced
- controls work independently of color

### Reject

- small icon clusters
- dense article metadata
- essential actions hidden in swipe-only gestures
- perpetual animation distracting from controls

---

## Test 8 — Motion Discipline

### Prompt

```text
Make the Retro Soft Utility app feel premium with lots of animation.
Add floating cards, animated clouds, shimmer, parallax, waveform motion, hover lift, and page transitions.
```

### Expected

- Choose a Polish motion register.
- Keep one dominant motion idea per surface.
- Prioritize playback/state feedback.
- Limit decorative perpetual motion.
- Provide reduced-motion fallback.

### Reject

- simultaneous float + shimmer + parallax + pulse on the same surface
- cinematic scroll inside daily reading/listening flows
- motion around body text that harms reading stability

---

## Test 9 — Functional Multicolor Exception

### Prompt

```text
A retro-soft finance alert app needs success, warning, error, pending, and selected states.
Keep the whole interface strictly two-color because the template says controlled duotone.
```

### Expected

- Do not force duotone when semantic state differentiation requires more colors.
- Preserve the Retro Soft surface while using a restrained Functional Multicolor system.
- Color roles remain consistent and accessible.

---

## Test 10 — Calm, Not Childish

### Prompt

```text
Design a Retro Soft Utility RSS app for adult professionals.
Make it cute and playful.
```

### Expected

- Translate “cute” into warmth, rounded forms, restrained illustration, soft color, and friendly copy.
- Maintain adult-level typography and information hierarchy.
- Avoid cartoon overload and toy-interface stereotypes.

---

## Test 11 — Existing Design System Preservation

### Prompt

```text
Our existing app already has tokens, spacing rules, and reusable controls.
Apply Retro Soft Utility to the Saved screen only.
```

### Expected

- Read and preserve the existing system first.
- Change only what is necessary to establish the intended visual direction.
- Do not introduce a second incompatible radius/spacing/button system.
- Keep scope to the Saved screen unless shared token changes are explicitly justified.

---

## Test 12 — Template Is a Recipe, Not a Skin

### Prompt

```text
Use Retro Soft Utility on a monitoring dashboard with 12 charts, incident status, logs, and tables.
```

### Expected

- Detect that the template is not a strong default fit for the primary work surface.
- Either decline the template for the dense operational area or apply only restrained brand/surface cues.
- Prioritize data readability, status semantics, density, and operational speed over nostalgic styling.

### Reject

- turning every chart/table into cream rounded cards with coral decoration
- reducing density simply to fit the template aesthetic

---

# Pass Criteria

A strong implementation should consistently demonstrate:

1. nostalgia expressed through controlled color, shape, surface, and branding rather than obsolete UX
2. one dominant focal event and at least one meaningful release zone
3. product content used as visual material before decorative filler
4. readable, adult, accessible typography
5. distinct semantics for primary actions such as Play, Like, Save, and Add Feed
6. calm Polish-level motion by default
7. template routing that respects product type and existing design systems
8. no pastel AI-slop, card spam, or childish visual clutter
