import pptxgen from 'pptxgenjs';
import fs from 'node:fs';

// Replace these imports with the helper path available in your runtime.
// import {
//   autoFontSize,
//   warnIfSlideHasOverlaps,
//   warnIfSlideElementsOutOfBounds,
// } from './pptxgenjs_helpers/index.js';

const specPath = process.argv[2];
const outputPath = process.argv[3] || 'deck.pptx';
if (!specPath) {
  console.error('Usage: node renderer-template.js <deck-spec.json> [deck.pptx]');
  process.exit(2);
}

const spec = JSON.parse(fs.readFileSync(specPath, 'utf8'));
const pptx = new pptxgen();
pptx.layout = 'LAYOUT_WIDE';
pptx.author = spec.deck?.author || 'consulting-pptx-renderer';
pptx.subject = spec.deck?.decision || '';
pptx.title = spec.deck?.title || '';
pptx.company = '';
pptx.lang = spec.deck?.language || 'en-US';
pptx.theme = {
  headFontFace: spec.theme?.fontHeading || 'Aptos Display',
  bodyFontFace: spec.theme?.fontBody || 'Aptos',
  lang: spec.deck?.language || 'en-US',
};

const TOKENS = {
  W: 13.333,
  H: 7.5,
  PAGE_X: 0.60,
  TITLE_Y: 0.42,
  TITLE_H: 0.76,
  CONTENT_Y: 1.45,
  CONTENT_H: 5.25,
  FOOTER_Y: 7.04,
  BG: spec.theme?.background || 'FFFFFF',
  TEXT: '17202A',
  TEXT2: '4D5966',
  MUTED: '7B8794',
  GRID: 'D9DEE5',
  SURFACE: 'F5F7F9',
  ACCENT: (spec.theme?.accent || '#175CD3').replace('#', ''),
  HEADING: spec.theme?.fontHeading || 'Aptos Display',
  BODY: spec.theme?.fontBody || 'Aptos',
};

const sourceMap = new Map((spec.sources || []).map((s) => [s.id, s]));

function addBackground(slide) {
  slide.background = { color: TOKENS.BG };
}

function addActionTitle(slide, title) {
  slide.addText(title || '', {
    x: TOKENS.PAGE_X,
    y: TOKENS.TITLE_Y,
    w: 12.13,
    h: TOKENS.TITLE_H,
    fontFace: TOKENS.HEADING,
    fontSize: 26,
    bold: true,
    color: TOKENS.TEXT,
    margin: 0,
    breakLine: false,
    valign: 'mid',
  });
}

function compactSource(source) {
  if (!source) return '';
  const bits = [source.publisher || source.title, source.date, source.locator].filter(Boolean);
  return bits.join(' · ');
}

function addFooter(slide, slideSpec, pageNumber) {
  const sourceText = (slideSpec.source || [])
    .map((id) => compactSource(sourceMap.get(id)))
    .filter(Boolean)
    .join('; ');

  if (sourceText) {
    slide.addText(`Source: ${sourceText}`, {
      x: TOKENS.PAGE_X,
      y: TOKENS.FOOTER_Y,
      w: 11.2,
      h: 0.20,
      fontFace: TOKENS.BODY,
      fontSize: 8.5,
      color: TOKENS.MUTED,
      margin: 0,
    });
  }

  slide.addText(String(pageNumber), {
    x: 12.35,
    y: TOKENS.FOOTER_Y,
    w: 0.35,
    h: 0.20,
    align: 'right',
    fontFace: TOKENS.BODY,
    fontSize: 8.5,
    color: TOKENS.MUTED,
    margin: 0,
  });
}

function addBullets(slide, items, x, y, w, h) {
  const runs = [];
  for (const item of items || []) {
    runs.push({
      text: String(item),
      options: { bullet: { indent: 14 }, hanging: 3, breakLine: true },
    });
  }
  slide.addText(runs, {
    x, y, w, h,
    fontFace: TOKENS.BODY,
    fontSize: 18,
    color: TOKENS.TEXT,
    margin: 0.04,
    valign: 'top',
    paraSpaceAfterPt: 9,
  });
}

function addMetric(slide, metric, x, y, w, h) {
  slide.addText(`${metric.value ?? ''}${metric.unit || ''}`, {
    x, y, w, h: h * 0.62,
    fontFace: TOKENS.HEADING,
    fontSize: 34,
    bold: true,
    color: TOKENS.ACCENT,
    margin: 0,
    valign: 'mid',
  });
  slide.addText(metric.label || '', {
    x, y: y + h * 0.62, w, h: h * 0.38,
    fontFace: TOKENS.BODY,
    fontSize: 14,
    color: TOKENS.TEXT2,
    margin: 0,
  });
}

function renderCover(slide, s) {
  slide.addText(s.title || spec.deck?.title || '', {
    x: 0.75, y: 2.1, w: 11.8, h: 1.15,
    fontFace: TOKENS.HEADING,
    fontSize: 36,
    bold: true,
    color: TOKENS.TEXT,
    margin: 0,
  });
  if (s.subtitle || spec.deck?.subtitle) {
    slide.addText(s.subtitle || spec.deck.subtitle, {
      x: 0.77, y: 3.45, w: 10.8, h: 0.60,
      fontFace: TOKENS.BODY,
      fontSize: 20,
      color: TOKENS.TEXT2,
      margin: 0,
    });
  }
  slide.addShape(pptx.ShapeType.line, {
    x: 0.75, y: 4.42, w: 1.45, h: 0,
    line: { color: TOKENS.ACCENT, width: 2.5 },
  });
}

function renderSection(slide, s) {
  slide.addText(s.kicker || '', {
    x: 0.75, y: 2.0, w: 4.0, h: 0.35,
    fontFace: TOKENS.BODY, fontSize: 14, bold: true,
    color: TOKENS.ACCENT, margin: 0,
  });
  slide.addText(s.title || '', {
    x: 0.75, y: 2.45, w: 11.4, h: 1.0,
    fontFace: TOKENS.HEADING, fontSize: 32, bold: true,
    color: TOKENS.TEXT, margin: 0,
  });
  if (s.framing) {
    slide.addText(s.framing, {
      x: 0.75, y: 3.62, w: 10.4, h: 0.55,
      fontFace: TOKENS.BODY, fontSize: 18,
      color: TOKENS.TEXT2, margin: 0,
    });
  }
}

function renderExecutiveSummary(slide, s) {
  addActionTitle(slide, s.actionTitle);
  slide.addText(s.recommendation || '', {
    x: 0.65, y: 1.55, w: 12.0, h: 0.58,
    fontFace: TOKENS.BODY, fontSize: 18, bold: true,
    color: TOKENS.TEXT, margin: 0,
  });

  const points = s.points || [];
  const rowH = Math.min(0.93, 3.8 / Math.max(points.length, 1));
  points.forEach((p, i) => {
    const y = 2.35 + i * (rowH + 0.15);
    slide.addText(p.headline || '', {
      x: 0.72, y, w: 2.2, h: rowH,
      fontFace: TOKENS.HEADING, fontSize: 18, bold: true,
      color: i === 0 ? TOKENS.ACCENT : TOKENS.TEXT,
      margin: 0.03, valign: 'mid',
    });
    slide.addText(p.detail || '', {
      x: 3.0, y, w: 9.1, h: rowH,
      fontFace: TOKENS.BODY, fontSize: 17,
      color: TOKENS.TEXT2, margin: 0.03, valign: 'mid',
    });
    if (i < points.length - 1) {
      slide.addShape(pptx.ShapeType.line, {
        x: 0.72, y: y + rowH + 0.075, w: 11.45, h: 0,
        line: { color: TOKENS.GRID, width: 0.7 },
      });
    }
  });

  if (s.nextAction) {
    slide.addText(`Next: ${s.nextAction}`, {
      x: 0.72, y: 6.34, w: 11.5, h: 0.42,
      fontFace: TOKENS.BODY, fontSize: 15.5, bold: true,
      color: TOKENS.ACCENT, margin: 0,
    });
  }
}

function renderChart(slide, chart, x, y, w, h) {
  const chartTypeMap = {
    bar: pptx.ChartType.bar,
    column: pptx.ChartType.bar,
    line: pptx.ChartType.line,
    area: pptx.ChartType.area,
    pie: pptx.ChartType.pie,
    scatter: pptx.ChartType.scatter,
  };
  const type = chartTypeMap[chart.chartType] || pptx.ChartType.bar;
  const data = (chart.series || []).map((series) => ({
    name: series.name || '',
    labels: chart.categories || [],
    values: series.values || [],
  }));

  slide.addChart(type, data, {
    x, y, w, h,
    showLegend: data.length > 1,
    showTitle: false,
    showValue: true,
    showCatName: false,
    showPercent: false,
    chartColors: [TOKENS.ACCENT, '94A3B8', 'CBD5E1', '64748B'],
    showBorder: false,
    showCategoryName: false,
    catAxisLabelColor: TOKENS.TEXT2,
    valAxisLabelColor: TOKENS.MUTED,
    valGridLine: { color: TOKENS.GRID, width: 0.6 },
  });
}

function renderChartCommentary(slide, s) {
  addActionTitle(slide, s.actionTitle);
  const chart = (s.evidence || []).find((e) => e.kind === 'chart');
  if (chart) renderChart(slide, chart, 0.65, 1.60, 8.15, 4.95);
  addBullets(slide, s.commentary || [], 9.15, 1.82, 3.45, 3.9);
  if (s.takeaway) {
    slide.addText(s.takeaway, {
      x: 9.15, y: 5.78, w: 3.45, h: 0.70,
      fontFace: TOKENS.BODY, fontSize: 15.5, bold: true,
      color: TOKENS.ACCENT, margin: 0,
    });
  }
}

function renderArgumentEvidence(slide, s) {
  addActionTitle(slide, s.actionTitle);
  const evidence = s.evidence || [];
  if (!evidence.length) return;

  const primary = evidence[0];
  if (primary.kind === 'metric') {
    addMetric(slide, primary, 0.72, 2.05, 4.1, 2.15);
  } else if (primary.kind === 'bullets') {
    addBullets(slide, primary.items || [], 0.72, 1.75, 7.5, 4.3);
  } else if (primary.kind === 'chart') {
    renderChart(slide, primary, 0.70, 1.65, 8.15, 4.85);
  }

  if (s.takeaway) {
    slide.addText(s.takeaway, {
      x: 9.15, y: 2.0, w: 3.2, h: 1.2,
      fontFace: TOKENS.HEADING, fontSize: 20, bold: true,
      color: TOKENS.ACCENT, margin: 0,
    });
  }
}

function renderMatrix2x2(slide, s) {
  addActionTitle(slide, s.actionTitle);
  const x = 1.65, y = 1.76, w = 8.8, h = 4.65;
  slide.addShape(pptx.ShapeType.line, { x, y: y + h, w, h: 0, line: { color: TOKENS.TEXT2, width: 1 } });
  slide.addShape(pptx.ShapeType.line, { x, y, w: 0, h, line: { color: TOKENS.TEXT2, width: 1 } });
  slide.addShape(pptx.ShapeType.line, { x: x + w / 2, y, w: 0, h, line: { color: TOKENS.GRID, width: 0.8, dash: 'dash' } });
  slide.addShape(pptx.ShapeType.line, { x, y: y + h / 2, w, h: 0, line: { color: TOKENS.GRID, width: 0.8, dash: 'dash' } });

  slide.addText(s.xAxis?.label || '', { x: x + w / 2 - 1.2, y: y + h + 0.18, w: 2.4, h: 0.28, fontFace: TOKENS.BODY, fontSize: 13, color: TOKENS.TEXT2, align: 'center', margin: 0 });
  slide.addText(s.yAxis?.label || '', { x: 0.42, y: y + h / 2 - 0.2, w: 1.0, h: 0.35, fontFace: TOKENS.BODY, fontSize: 13, color: TOKENS.TEXT2, rotate: 270, align: 'center', margin: 0 });

  for (const item of s.items || []) {
    const px = x + Number(item.x) * w;
    const py = y + (1 - Number(item.y)) * h;
    const color = item.highlight ? TOKENS.ACCENT : '64748B';
    slide.addShape(pptx.ShapeType.ellipse, { x: px - 0.08, y: py - 0.08, w: 0.16, h: 0.16, fill: { color }, line: { color } });
    slide.addText(item.label || '', { x: px + 0.10, y: py - 0.12, w: 1.55, h: 0.30, fontFace: TOKENS.BODY, fontSize: 12.5, bold: !!item.highlight, color, margin: 0 });
  }
}

function renderRecommendation(slide, s) {
  addActionTitle(slide, s.actionTitle);
  if (s.recommendation) {
    slide.addText(s.recommendation, {
      x: 0.72, y: 1.58, w: 11.6, h: 0.70,
      fontFace: TOKENS.HEADING, fontSize: 21, bold: true,
      color: TOKENS.TEXT, margin: 0,
    });
  }
  const actions = s.actions || [];
  actions.forEach((a, i) => {
    const y = 2.55 + i * 1.03;
    slide.addText(String(i + 1).padStart(2, '0'), {
      x: 0.76, y, w: 0.55, h: 0.42,
      fontFace: TOKENS.HEADING, fontSize: 14, bold: true,
      color: TOKENS.ACCENT, margin: 0,
    });
    slide.addText(a.label || '', {
      x: 1.45, y, w: 6.4, h: 0.50,
      fontFace: TOKENS.BODY, fontSize: 18, bold: true,
      color: TOKENS.TEXT, margin: 0,
    });
    slide.addText(a.owner || '', {
      x: 8.4, y, w: 1.6, h: 0.42,
      fontFace: TOKENS.BODY, fontSize: 14,
      color: TOKENS.TEXT2, margin: 0,
    });
    slide.addText(a.timing || '', {
      x: 10.25, y, w: 1.9, h: 0.42,
      fontFace: TOKENS.BODY, fontSize: 14,
      color: TOKENS.TEXT2, margin: 0,
    });
    slide.addShape(pptx.ShapeType.line, {
      x: 1.45, y: y + 0.67, w: 10.65, h: 0,
      line: { color: TOKENS.GRID, width: 0.6 },
    });
  });
}

function renderGeneric(slide, s) {
  addActionTitle(slide, s.actionTitle || s.title);
  if (s.takeaway) {
    slide.addText(s.takeaway, {
      x: 0.72, y: 1.85, w: 11.5, h: 0.9,
      fontFace: TOKENS.BODY, fontSize: 20,
      color: TOKENS.TEXT, margin: 0,
    });
  }
}

const RENDERERS = {
  cover: renderCover,
  section: renderSection,
  'executive-summary': renderExecutiveSummary,
  'argument-evidence': renderArgumentEvidence,
  'chart-focus': renderArgumentEvidence,
  'chart-commentary': renderChartCommentary,
  'matrix-2x2': renderMatrix2x2,
  recommendation: renderRecommendation,
  comparison: renderGeneric,
  'two-column': renderGeneric,
  process: renderGeneric,
  timeline: renderGeneric,
  'appendix-table': renderGeneric,
};

for (const [index, s] of (spec.slides || []).entries()) {
  const slide = pptx.addSlide();
  addBackground(slide);
  const render = RENDERERS[s.type] || renderGeneric;
  render(slide, s);
  if (!['cover', 'section'].includes(s.type)) addFooter(slide, s, index + 1);

  // If helpers are available in your runtime, call them here:
  // warnIfSlideHasOverlaps(slide, pptx);
  // warnIfSlideElementsOutOfBounds(slide, pptx);
}

await pptx.writeFile({ fileName: outputPath });
console.log(`Wrote ${outputPath}`);
