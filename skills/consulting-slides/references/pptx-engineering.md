# PPTX Engineering Guide

Use this reference when the requested deliverable is an editable PowerPoint file.

## 1. Authoring choice

Prefer PptxGenJS or another engine that preserves editable text, shapes, and native charts.

Do not rasterize entire slides unless the source is itself a raster artifact and editability is not required.

## 2. Default geometry

Unless a source template dictates otherwise:

- aspect ratio: 16:9
- stable title zone
- stable content grid
- stable footer/source zone
- consistent page margins

Do not hand-position every element independently if the same anchors can be reused.

## 3. Typography

Set theme fonts explicitly.

Prefer fonts that are likely to exist in the delivery environment. If a special font is required, verify fallback behavior before shipping.

## 4. Native charts first

Use native charts for common bar, line, pie, stacked bar, scatter, and similar business graphics when editability matters.

Use SVG for diagrams that are difficult to express natively.

Keep chart data, labels, units, and number formats consistent with the source register.

## 5. Text handling

Avoid overflowing text boxes.

Preferred order when copy does not fit:

1. shorten the copy
2. split the slide
3. expand the content area if hierarchy allows
4. reduce font size modestly as the last resort

Do not use tiny fonts to preserve a broken slide structure.

## 6. Image handling

Preserve aspect ratio.

Use crop when the image is a visual field and contain when every pixel matters, such as screenshots or charts.

Do not stretch screenshots.

## 7. Source code requirements

When possible, deliver the authoring source alongside the `.pptx`.

The source should:

- define shared theme constants
- define reusable grid/layout helpers
- avoid unexplained magic coordinates
- keep slide content separate enough to revise
- include comments for any intentional overlap

## 8. Validation

After generation:

1. render the `.pptx` to per-slide images
2. inspect a montage/contact sheet
3. inspect dense slides at full size
4. run out-of-bounds checks
5. run overlap checks where supported
6. inspect font substitution

Do not ship based only on “the script completed successfully.”

## 9. Delivery package

Preferred package:

```text
deck.pptx
source/
  deck.js or deck.ts
assets/
source-register.md or source-register.csv
qa.md
```

For lightweight internal decks, the source register and QA file may be omitted if the information is already embedded and auditable.

## 10. Useful external practices incorporated

This engineering layer follows the general practice used by production slide skills that:

- author with PptxGenJS
- preserve editable objects
- render decks before delivery
- detect overflow and overlap
- inspect font substitution

The consulting layer remains separate from the rendering engine so the same storyline and quality gates can be used with PowerPoint, Google Slides, HTML decks, or future slide tools.
