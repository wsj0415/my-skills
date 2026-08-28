# Layout Library

Renderer 使用功能型 layout registry。每个 layout 都有明确的信息职责、输入上限和失败条件。

## 1. cover

**用途**：标题、上下文、日期/作者。

**结构**：
- deck title
- optional subtitle
- small metadata

**禁止**：在封面堆摘要、图表、多个 logo。

## 2. section

**用途**：章节切换。

**结构**：
- section number / kicker
- section title
- optional one-line framing statement

## 3. executive-summary

**用途**：高管在一页获取 recommendation + reasons + action。

**推荐结构**：
- action title
- 1 条 recommendation
- 2–4 条 supporting reasons
- 1 条 next action

**上限**：4 个 supporting reasons。

## 4. argument-evidence

**用途**：一个主结论，由 1–3 组证据支撑。

**结构**：
- action title
- left/top primary evidence
- right/bottom implication or secondary evidence
- source footer

适合：metric、短 bullet、简表、单个 diagram。

## 5. chart-focus

**用途**：一张主图表就是核心证据。

**结构**：
- action title
- large chart occupying 70–80% content area
- optional one-line annotation

禁止同时再放第二张主图。

## 6. chart-commentary

**用途**：图表 + 明确的解释/so what。

**结构**：

```text
[ chart 65–70% ] [ commentary 30–35% ]
```

Commentary 最多 3 条，且都必须解释 chart，而不是新增独立论点。

## 7. comparison

**用途**：对比两个主要对象/方案。

**结构**：

```text
        criterion / framing
[ Option A ]      [ Option B ]
```

如存在 winner，可用 accent 轻量突出；不能通过视觉夸大替代证据。

## 8. two-column

**用途**：两组对等信息，而非优劣比较。

适合：
- before / after
- problem / response
- internal / external

不要把它滥用成“两个卡片”。内容应直接落在共享网格上。

## 9. process

**用途**：有方向的 3–6 步流程。

**结构**：水平或垂直主轴 + nodes。

每个 node：
- 1 个短 headline
- 最多 1 行说明

超过 6 步优先拆页或分 phase。

## 10. timeline

**用途**：按时间发生的事件、里程碑、roadmap。

**结构**：稳定时间轴 + 3–7 个事件。

如果重点是依赖关系而不是时间，改用 `process`。

## 11. matrix-2x2

**用途**：两个维度上的定位与优先级。

必须有：
- x axis label + low/high
- y axis label + low/high
- item labels

最多推荐 8–10 个 item；更多点会降低可读性。

## 12. recommendation

**用途**：明确建议、行动与 owner/timing。

结构建议：
- recommendation sentence
- 3–5 actions
- optional owner / timing / impact

这是行动页，不是重复 executive summary。

## 13. appendix-table

**用途**：审计、方法、明细数据。

允许比主 deck 更高信息密度，但仍应：
- 字体可读
- 行列有明确 header
- 单位一致
- source 完整

## Layout decision tree

```text
Is this a chapter break?
  yes → section

Is this an executive answer page?
  yes → executive-summary

Is one chart the dominant evidence?
  yes → chart-focus

Does the chart need explicit interpretation beside it?
  yes → chart-commentary

Are two things being compared?
  yes → comparison

Are two things merely parallel?
  yes → two-column

Is there ordered movement?
  time → timeline
  logical steps → process

Are items positioned on two dimensions?
  yes → matrix-2x2

Is the page primarily about what to do next?
  yes → recommendation

Is the detail mainly for audit/Q&A?
  yes → appendix-table

otherwise → argument-evidence
```

## Density limits

默认 soft limits：

- bullets: 5
- executive summary points: 4
- process nodes: 6
- timeline events: 7
- 2x2 items: 10
- chart categories: 10（视图表类型而定）
- comparison criteria: 6

超过 soft limit 时生成 warning，并优先建议拆页。

## Layout invariants

每个 layout 都必须：

- 使用共享 title zone
- 使用共享 source/footer zone
- 保证 content safe area
- 将主证据放在视觉第一/第二层级
- 不创建无信息价值的 decoration
- 在生成函数结尾运行 overlap/out-of-bounds diagnostics（若环境支持）
