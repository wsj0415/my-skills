#!/usr/bin/env node

import fs from 'node:fs';

const file = process.argv[2];
if (!file) {
  console.error('Usage: node validate-spec.mjs <deck-spec.json>');
  process.exit(2);
}

const raw = fs.readFileSync(file, 'utf8');
const spec = JSON.parse(raw);

const errors = [];
const warnings = [];

const knownTypes = new Set([
  'cover',
  'section',
  'executive-summary',
  'argument-evidence',
  'chart-focus',
  'chart-commentary',
  'comparison',
  'two-column',
  'process',
  'timeline',
  'matrix-2x2',
  'recommendation',
  'appendix-table',
]);

function error(path, message) {
  errors.push({ level: 'ERROR', path, message });
}

function warn(path, message) {
  warnings.push({ level: 'WARN', path, message });
}

if (!spec.deck || typeof spec.deck !== 'object') error('deck', 'deck object is required');
if (!Array.isArray(spec.slides) || spec.slides.length === 0) error('slides', 'at least one slide is required');

const sources = new Map();
for (const [i, source] of (spec.sources || []).entries()) {
  const path = `sources[${i}]`;
  if (!source?.id) {
    error(`${path}.id`, 'source id is required');
    continue;
  }
  if (sources.has(source.id)) error(`${path}.id`, `duplicate source id: ${source.id}`);
  sources.set(source.id, source);
  if (!source.title) error(`${path}.title`, 'source title is required');
  if (!source.date) warn(`${path}.date`, 'source date is recommended for formal decks');
}

const ids = new Set();
const titles = new Map();

for (const [i, slide] of (spec.slides || []).entries()) {
  const path = `slides[${i}]`;

  if (!slide?.id) error(`${path}.id`, 'slide id is required');
  else if (ids.has(slide.id)) error(`${path}.id`, `duplicate slide id: ${slide.id}`);
  else ids.add(slide.id);

  if (!knownTypes.has(slide?.type)) {
    error(`${path}.type`, `unknown slide type: ${slide?.type}`);
    continue;
  }

  const title = slide.actionTitle || slide.title;
  if (!['cover', 'section'].includes(slide.type) && !slide.actionTitle) {
    error(`${path}.actionTitle`, 'actionTitle is required for non-cover/section slides');
  }

  if (title) {
    const normalized = String(title).trim().toLowerCase();
    if (titles.has(normalized)) warn(path, `duplicate title also used on ${titles.get(normalized)}`);
    else titles.set(normalized, slide.id || path);

    if (String(title).length > 110) warn(path, 'title is long and may require copy editing or two lines');
  }

  for (const sourceId of slide.source || []) {
    if (!sources.has(sourceId)) error(`${path}.source`, `unknown source reference: ${sourceId}`);
  }

  const evidence = Array.isArray(slide.evidence) ? slide.evidence : [];
  for (const [j, item] of evidence.entries()) {
    const epath = `${path}.evidence[${j}]`;

    if (item.kind === 'chart') {
      const categories = item.categories || [];
      const series = item.series || [];
      if (!Array.isArray(categories) || categories.length === 0) error(`${epath}.categories`, 'chart categories are required');
      if (!Array.isArray(series) || series.length === 0) error(`${epath}.series`, 'chart series are required');

      for (const [k, s] of series.entries()) {
        if (!Array.isArray(s.values)) error(`${epath}.series[${k}].values`, 'series values must be an array');
        else if (s.values.length !== categories.length) {
          error(`${epath}.series[${k}].values`, `value count ${s.values.length} does not match category count ${categories.length}`);
        }
      }

      if (categories.length > 10) warn(epath, 'more than 10 chart categories may reduce readability');
    }

    if (item.kind === 'bullets' && Array.isArray(item.items) && item.items.length > 5) {
      warn(epath, 'more than 5 bullets; consider splitting or moving detail to appendix');
    }

    if (item.kind === 'table' && Array.isArray(item.rows) && Array.isArray(item.columns)) {
      if (slide.type !== 'appendix-table' && (item.rows.length > 6 || item.columns.length > 5)) {
        warn(epath, 'dense table in main deck; consider appendix');
      }
    }
  }

  if (slide.type === 'executive-summary' && Array.isArray(slide.points) && slide.points.length > 4) {
    warn(path, 'executive summary has more than 4 supporting points');
  }

  if (slide.type === 'process' && Array.isArray(slide.nodes) && slide.nodes.length > 6) {
    warn(path, 'process has more than 6 nodes');
  }

  if (slide.type === 'timeline' && Array.isArray(slide.events) && slide.events.length > 7) {
    warn(path, 'timeline has more than 7 events');
  }

  if (slide.type === 'matrix-2x2') {
    for (const [j, item] of (slide.items || []).entries()) {
      if (typeof item.x !== 'number' || item.x < 0 || item.x > 1) error(`${path}.items[${j}].x`, 'x must be within 0..1');
      if (typeof item.y !== 'number' || item.y < 0 || item.y > 1) error(`${path}.items[${j}].y`, 'y must be within 0..1');
    }
    if ((slide.items || []).length > 10) warn(path, '2x2 has more than 10 items');
  }
}

for (const finding of [...errors, ...warnings]) {
  console.log(`${finding.level}\t${finding.path}\t${finding.message}`);
}

console.log(`\nValidation summary: ${errors.length} error(s), ${warnings.length} warning(s)`);
process.exit(errors.length ? 1 : 0);
