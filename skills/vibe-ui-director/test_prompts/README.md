# Vibe UI Director — Test Prompts

这些提示用于回归测试 Skill 是否真正改善 Vibe Coding UI，而不是只生成“更漂亮的模板”。

## Test 1 — Generic SaaS Landing Page

```text
create 一个 AI Agent SaaS 首页。产品帮助运营人员自动整理客户反馈、生成优先级并同步到 Jira。使用 Next.js + Tailwind + shadcn。
```

### Pass Criteria

- 不直接套 Hero + 3 Cards + Testimonials 默认结构。
- 设计方向来自“客户反馈/优先级/运营工作流”。
- 至少一个真实业务对象成为视觉核心，而不是抽象 AI Orb。
- 没有无理由紫蓝渐变、glass、glow。
- CTA 明确且唯一。

---

## Test 2 — Enterprise Dashboard

```text
create 一个企业任务调度平台 Dashboard。用户是研发和运维人员，需要快速发现失败任务、延迟任务和执行器异常。React + Ant Design。
```

### Pass Criteria

- 不是纯 KPI 卡片墙。
- hierarchy 围绕“发现异常并处理”。
- 风险状态不用颜色作为唯一信息。
- 高密度数据布局仍可扫描。
- 有 loading / empty / error / degraded 状态考虑。

---

## Test 3 — Redesign AI-looking Page

```text
redesign 当前 landing page。它现在有紫色渐变标题、6 个 rounded feature cards、每个 icon 都有渐变背景、所有 section 都居中、卡片 hover 会向上移动。保留原有业务内容和功能。
```

### Pass Criteria

- 能识别多个 AI-Slop signature。
- 不只是换色。
- 删除无价值装饰。
- 重建 hierarchy 和 section rhythm。
- 至少解释一个“保留”和一个“删除”的设计选择。

---

## Test 4 — UX Review

```text
review 一个用户 API Key 设置页面：只有一个输入框、Save 按钮和当前状态。保存请求通常 2–4 秒，有时会返回 key 无效或服务不可用。
```

### Pass Criteria

- 检查 focus/loading/disabled/error/success。
- 区分 invalid key 与 service unavailable。
- 不建议 generic toast 解决所有状态。
- 保留用户输入。
- 输出有限的高影响 findings。

---

## Test 5 — Mobile Learning Product

```text
create 一个 7–10 岁儿童使用的英语单词练习页面，主要在手机使用。每轮 10 个单词，包含读音、图片、选择答案、即时反馈和本轮进度。
```

### Pass Criteria

- 设计与儿童学习场景相关，而不是普通 SaaS 风格。
- touch target 足够大。
- 错误反馈不具有惩罚感，但明确。
- progress 有意义。
- 不过度动画。
- 不能只靠颜色表达正确/错误。

---

## Test 6 — Polish Existing Product

```text
polish 一个已经可用的后台订单详情页，不改变信息架构。重点提升 typography、spacing、状态、操作层级和整体专业感。
```

### Pass Criteria

- 不进行无请求的大规模 redesign。
- 优先一致性和层级，而不是添加装饰。
- Primary / destructive / secondary action 权重合理。
- 有长文本、loading、error、empty 等边界检查。

---

# Failure Signals

如果输出出现以下情况，应视为 Skill 回归：

- 每个测试都趋向同一种视觉风格。
- 为了“高级感”添加 gradient / blur / glass。
- 大量 card 化。
- 只审视觉、不审交互状态。
- 输出几十条 checklist 而不排序。
- 不看实际业务对象。
- mobile 只是 desktop 缩小。
- 只修改颜色字体就声称完成 redesign。
