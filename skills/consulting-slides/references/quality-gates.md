# Consulting Slides Quality Gates

Use these gates before declaring a deck complete.

## Pass 1 — Story

### Title-only test

Read only slide titles in sequence.

Pass when:

- the sequence forms a coherent argument
- the answer appears early enough for the audience
- supporting titles explain why the answer is true
- the deck ends with implication, recommendation, or action

Fail when titles look like a table of contents:

- Background
- Market
- Customers
- Competition
- Recommendation

### One-job test

For every slide complete:

> The audience should leave this page understanding that ______.

Fail when the answer contains two independent conclusions.

### Necessity test

For every slide ask:

> If this slide disappeared, would the decision logic break?

If not, remove it, merge it into a stronger page, or move it to appendix.

## Pass 2 — Evidence

### Claim-evidence fit

For every action title ask:

- Does the evidence directly support this claim?
- Is the claim stronger than the evidence?
- Is a correlation being written as causation?
- Is a local result being generalized without support?

### Number check

Verify:

- units
- percentages
- bases / denominators
- time period
- currency
- rounding
- arithmetic
- consistency across slides

### Source check

Every material external number should be traceable to:

- source name
- publication / data date
- page, table, URL, or query where practical

If a number is modelled or estimated, label it accordingly.

## Pass 3 — Design and export

### 3-second test

Show or inspect the slide briefly.

Within roughly three seconds, a viewer should detect:

1. what the page is about
2. what matters most
3. where the evidence is

If not, reduce content or strengthen hierarchy.

### 3-metre test

From a distance or in a zoomed-out montage, the primary message should remain legible.

The test is not that every footnote can be read from three metres. It is that the action title, major visual pattern, and highlighted evidence survive distance.

### Complexity test

Do not solve complexity by shrinking everything.

Preferred order:

1. delete redundancy
2. remove low-priority detail
3. move detail to footnote
4. move detail to appendix
5. split into multiple slides
6. only then tune typography

### Alignment test

Check:

- common left edges
- common title zone
- common footer/source zone
- chart labels aligned to the chart
- equal items use equal spacing
- unequal importance does not receive equal visual weight

### Consistency test

Across the deck verify:

- same font family and role mapping
- same color semantics
- same number formats
- same capitalization convention
- same source format
- same axis / label behavior for comparable charts

## PPTX engineering gates

When a `.pptx` is generated, do not rely on code inspection alone.

Required where tools permit:

1. render all slides to images
2. create or inspect a montage
3. detect out-of-bounds elements
4. detect unintended overlaps
5. inspect missing/substituted fonts
6. open representative slides at full size

Any warning must be fixed or explicitly documented as intentional.

## Scoring rubric

Score each category 0–2:

| Category | 0 | 1 | 2 |
|---|---|---|---|
| Storyline | fragmented | understandable | compelling argument |
| Action titles | mostly topics | mixed | conclusion-led throughout |
| Evidence | weak/untraceable | partial | direct and traceable |
| Visual fit | wrong/decorative | acceptable | relationship-driven |
| Hierarchy | cluttered | readable | instantly scannable |
| Consistency | inconsistent | minor variance | systematic |
| Source discipline | missing | partial | auditable |
| Engineering QA | not checked | partial | rendered and validated |

Recommended shipping threshold: **13/16**, with no zero in Evidence, Source discipline, or Engineering QA for formal external decks.
