# UI Review Rubric

目标：在 review / polish 模式下优先发现影响真实使用和视觉质量的高价值问题，而不是输出冗长 checklist。

## 评分维度

每项 0–2 分，总分 20。

| Dimension | 0 | 1 | 2 |
|---|---|---|---|
| Task clarity | 核心任务不清楚 | 可理解但竞争焦点多 | 主要任务立即清楚 |
| Hierarchy | 信息权重混乱 | 基本有层级 | 主次清晰且与业务一致 |
| Layout | 拥挤/失衡/脆弱 | 基本稳定 | 节奏、对齐、密度成熟 |
| Typography | 随机/难读 | 可用但普通 | 字体系统明确且支持品牌 |
| Visual system | token 不一致 | 部分统一 | 色彩/spacing/radius/elevation 一致 |
| Interaction | 关键状态缺失 | happy path 完整 | 状态、反馈、恢复完整 |
| Responsive | 只是缩小 | 基本适配 | 内容驱动的重排与优先级 |
| Accessibility | 明显阻碍 | 基础合格 | 键盘、对比、语义、motion 扎实 |
| Content | generic/含糊 | 基本清晰 | 具体、用户语言、动作一致 |
| Distinctiveness | 高度模板化 | 有少量特点 | 明确、克制且符合业务的视觉观点 |

## Ship Readiness

- 18–20：可发布，仅做小幅 polish。
- 15–17：基本成熟，有少量高影响修复。
- 11–14：可用但明显需要设计迭代。
- 7–10：存在系统性 UI/UX 问题。
- 0–6：应回到结构/设计方向重做，而不是继续 polish。

换算为 X/10 时除以 2。

## Finding Priority

### Critical
阻止用户完成任务、严重可访问性问题、数据丢失、高风险误操作。

### High
明显破坏 hierarchy、核心 flow、responsive 或产品可信度的问题。

### Medium
一致性、局部可读性、细节状态、可发现性等问题。

### Low
纯装饰细节。只有在没有更高影响问题时才处理。

## Review Method

先看渲染结果，再看实现代码（如果两者都可用）。

第一轮只回答：

1. 5 秒内我知道这里是什么吗？
2. 我知道下一步要做什么吗？
3. 页面最醒目的东西真的是最重要的吗？
4. 有没有看起来“为了设计而设计”的东西？
5. 有没有明显的 AI template signature？

然后检查具体系统。

## Reporting Rule

不要罗列 30 个低价值问题。默认选择 3–7 个最高影响问题。

每项包含：

- Observation：看到了什么。
- Impact：为什么影响用户/业务。
- Fix：具体怎么改。
- Priority：Critical / High / Medium。

如果页面已经有优秀决策，明确列在 `Keep`，避免重构时破坏已有优势。
