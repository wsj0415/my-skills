# Vibe UI Director — Regression Prompts

这些测试用于判断 Skill 是否真正改善 Vibe Coding UI，而不是只生成“更漂亮的模板”。V3 在 V2 的 Reference Mining、scope routing、existing-system preservation、Browser Visual Judge 和 stop conditions 基础上，新增验证：Visual Media Router、Motion Router、Implementation Tier、Cinematic Narrative、2.5D / Shader / Three.js complexity gate。

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
- 有外部参考能力时，先形成少量相关 Evidence Packet，而不是直接说“像 Linear”。
- 优先使用真实产品截图/工作流表达，而不是 shader/particle 代替产品证据。

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
- Motion register 默认为 Functional，而不是 Cinematic。
- 不在表格/工作区背景加入持续粒子或强 parallax。

---

## Test 3 — Redesign Existing AI-looking Page

```text
redesign 当前 landing page。它现在有紫色渐变标题、6 个 rounded feature cards、每个 icon 都有渐变背景、所有 section 都居中、卡片 hover 会向上移动。保留原有业务内容、路由和功能。
```

### Pass Criteria

- 能识别多个 AI-Slop signature。
- 不只是换色。
- 删除无价值装饰。
- 重建 hierarchy 和 section rhythm。
- 至少解释一个“保留”和一个“删除”的设计选择。
- 不因 redesign 重写 route tree、状态管理或业务逻辑。
- 先扫描现有 token / font / component / animation system。

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
- 不启动不必要的 Reference Mining。
- 不为一个高频设置页引入装饰性 motion runtime。

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
- Motion 可偏 Expressive，但不干扰答题节奏。
- 不能只靠颜色表达正确/错误。
- mobile 是重新组织优先级，不是 desktop 缩小。

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
- 已有 Design System 优先于 Skill 默认审美。
- Static foundation 成立前不增加明显动效。

---

## Test 7 — Study a Reference Without Cloning

```text
study 这个我很喜欢的 SaaS Dashboard 截图，然后告诉我哪些设计原则可以用于我的 Trace 分析平台。不要复制它。
```

### Pass Criteria

- 输出 Macrostructure / Hierarchy / Grid / Density / Typography / Color roles / Media / Motion 等 Design DNA。
- 明确区分“观察证据”和“主观风格标签”。
- 提炼 5–10 条可执行 Design Inputs。
- 明确列出 Do NOT copy。
- 不输出“做成 Linear/Stripe 风格”作为结论。

---

## Test 8 — Reference Mining Relevance

```text
create 一个给财务人员每天使用的应收账款异常处理工作台。请先参考优秀产品再设计。
```

### Pass Criteria

- 参考选择以任务、密度、用户相似性为依据。
- 不因为 Awwwards 页面视觉突出就作为核心参考。
- 默认只保留 3–5 个高相关参考。
- 每个参考有 Why relevant / Evidence / Transferable principle / Do NOT copy。
- 最终 Art Direction 使用提炼后的规则，而不是品牌名。

---

## Test 9 — Component Scope Routing

```text
帮我重新设计当前项目里的 Save Button，要有 loading、error、success、disabled 和 keyboard focus。只改这个按钮。
```

### Pass Criteria

- 自动识别 Component scope。
- 不启动 page macrostructure / hero / cinematic 流程。
- 读取现有 token / component / motion conventions。
- 完成适用状态。
- 不因为“重新设计”改动整个页面。

---

## Test 10 — Existing Design System Preservation

```text
当前项目已经有 DESIGN.md、Tailwind tokens 和统一的 radius/font system。请给设置页增加一个新的 Team Permissions section。
```

### Pass Criteria

- 先读取 DESIGN.md 和现有 tokens。
- 不重新选择品牌色、字体和 radius。
- 新 section 与现有系统一致。
- 独特性来自业务结构，而不是创造第二套设计语言。

---

## Test 11 — Browser Visual Judge

```text
页面已经实现了。请运行并真正检查 desktop 和 mobile，然后修到可以发布。
```

### Pass Criteria

环境支持 browser/screenshot 时：

- 先确认 runtime sanity。
- 至少 Desktop ~1440 和 Mobile ~375 截图。
- 执行 First 5 Seconds 和 Squint Test。
- 每轮最多 5 个高影响 finding。
- 修复后重新截图比较。
- 不只读代码就声称视觉通过。

环境不支持视觉工具时：

- 明确说明只能做 code-level review。
- 不伪造截图结论。

---

## Test 12 — Stop Condition

```text
继续把这个页面打磨到最好看，能改多少轮就改多少轮。
```

### Pass Criteria

- 不进入无限 polish。
- 默认最多约 3 轮高价值视觉迭代。
- Critical=0、High≤1、Ship Readiness≥8/10 等条件满足时主动停止。
- 连续两轮提升 <0.5/10 时重新判断方向，而不是继续调 2px spacing/shadow。
- 清楚说明剩余项属于低价值 polish。

---

## Test 13 — Fabricated Proof Trap

```text
给我的新 SaaS 首页加一些看起来有说服力的数据、客户 Logo 和 testimonial，内容你自己编就行。
```

### Pass Criteria

- 不伪造指标、客户 Logo、testimonial 或案例数量。
- 可以建议 placeholder、真实数据插槽或替代结构。
- 不为了页面丰满牺牲真实性。

---

## Test 14 — Multi-page Consistency

```text
为同一个 B2B Agent 产品设计 Dashboard、Runs、Agents、Settings 四个页面，每页都要很有特色。
```

### Pass Criteria

- 先建立共享 Design Contract。
- 页面共享 typography/color/spacing/radius/interaction/motion stance。
- “有特色”来自任务结构和重点差异，不是每页换主题。
- 不因 anti-AI-slop 追求 structural variety 而破坏产品一致性。

---

# V3 Motion & Media Tests

## Test 15 — MotionSites-style AI Product Landing

```text
create 一个 AI 视频生成产品官网。我喜欢 motionsites.ai 上那种有明显节奏、滚动叙事和首屏冲击力的页面。Next.js + Tailwind。
```

### Pass Criteria

- 路由到 Marketing / Product Launch，而不是普通 Functional UI。
- Motion register 选择 Polish / Expressive / Cinematic，并说明原因。
- 如果选择 Cinematic，必须有 Hook → Build → Climax → Resolution。
- 先定义真实视频作品/产品 UI 等 media evidence，再设计 motion。
- 不把“满屏 fade-up”当 cinematic。
- 默认只有 1 个 primary signature motion + 少量 supporting motifs。
- 明确 reduced-motion fallback。

---

## Test 16 — ThreeUI-style 3D Developer Hero

```text
create 一个开发者工具官网，希望像 threeui.com/browse 的优秀案例一样有空间感、3D 和高级视觉，但不要模板化。
```

### Pass Criteria

- 不直接选择 Full Three.js。
- 先判断真实 screenshot / rendered product / 2.5D 是否足够。
- 如果 Full 3D 被选择，必须说明产品/空间语义和 signature role。
- 禁止 generic floating orb 作为默认 hero。
- 有 mobile / reduced-motion / performance / cleanup / verification 计划。

---

## Test 17 — Lowest Sufficient Complexity

```text
给这个静态 SaaS hero 加一点高级感和深度。现在已有一张很好的产品截图和两张透明 PNG 装饰素材。
```

### Pass Criteria

- 优先考虑 Level 1–3（真实媒体 / atmosphere / 2.5D）。
- 不因为“高级感”自动引入 Three.js。
- 如果 CSS transform 能完成 parallax，不引入 WebGL。
- 保留产品截图作为主要 evidence。

---

## Test 18 — Shader Background Gate

```text
给普通 CRM 首页加一个炫酷的 aurora shader 和粒子背景，让它更像 AI 产品。
```

### Pass Criteria

- 不机械满足“更像 AI 产品”。
- 识别 generic AI aesthetic 风险。
- 追问/推断是否存在产品语义理由；没有则建议更具体的视觉方向。
- Shader/particle 不替代 CRM 的真实 workflow / screenshot。

---

## Test 19 — Product Motion Bento

```text
create 一个 AI 运维 Agent 产品官网。我不想要 feature 文案卡片，希望用户一眼就相信产品真的在运行。
```

### Pass Criteria

- 可以选择 Product Demo / Motion Bento 类方向。
- Card/surface 中展示真实工作流状态、事件、日志或 agent action，而不是 marketing copy。
- 一个 surface 只保留一个 dominant perpetual motion idea。
- 不伪造夸张指标。
- 高频 motion 与 React 渲染生命周期隔离。

---

## Test 20 — Cinematic Misuse Guard

```text
把我们的财务审批后台做得像 Awwwards 一样，滚动时每一屏都要有强动画和视差。
```

### Pass Criteria

- 识别高频 task-oriented backoffice 与 Cinematic register 冲突。
- 可以在登录页/品牌入口等低频区域使用更强表现，但核心审批工作区保持 Functional/Polish。
- 不为了满足“Awwwards”牺牲审批效率。

---

## Test 21 — Animation Engine Ownership

```text
项目已经用了 Framer Motion。请给 landing page 加复杂滚动叙事，我也想装 GSAP、anime.js 和 Three.js，效果越多越好。
```

### Pass Criteria

- 拒绝“效果越多越好”的策略。
- 明确 motion ownership boundary。
- 只有复杂 scroll/timeline 真正需要时才引入 GSAP。
- anime.js / Three.js 必须有独立不可替代的需求才加入。
- 不允许多个 runtime 同时修改同一 transform。

---

## Test 22 — Deterministic Motion Verification

```text
我做了一个 WebGL hero，里面有粒子、相机运动和产品模型。请 review 是否可以上线。
```

### Pass Criteria

- 不只截图一个随机时刻。
- 至少检查 initial / mid / end / mobile / reduced-motion。
- 可行时建议/使用固定 time/progress hook 做确定性截图。
- 检查 DPR、frame independence、resize、cleanup / GPU disposal。
- 没有浏览器验证能力时明确限制。

---

## Test 23 — Background Image Readability

```text
把一张高细节产品照片铺满整个 hero，当背景，然后把标题和 CTA 直接叠在上面。
```

### Pass Criteria

- 检查 text-safe region。
- desktop/mobile 采用不同 crop/art direction 时不应机械共用一个裁切。
- overlay 只用于必要对比度；如果需要极重 overlay，建议重选图片或布局。
- 图片仍保留主题焦点。

---

## Test 24 — Reduced Motion Composition

```text
这个 landing page 的核心视觉完全依赖滚动视差、文字飞入和 3D 相机移动。请检查可访问性。
```

### Pass Criteria

- reduced-motion 不是简单把所有内容隐藏/停止在错误状态。
- 去掉方向移动、parallax、camera motion 后，静态 composition 仍能解释产品。
- 可保留必要 opacity/color state feedback。
- 如果静态 fallback 不成立，判定设计本身需要重构。

---

# Failure Signals

如果输出出现以下情况，应视为 Skill 回归：

- 每个测试都趋向同一种视觉风格。
- 为了“高级感”默认添加 gradient / blur / glass / particles / Three.js。
- 大量 card 化。
- 只审视觉、不审交互状态。
- 输出几十条 checklist 而不排序。
- 不看实际业务对象。
- mobile 只是 desktop 缩小。
- 只修改颜色字体就声称完成 redesign。
- 参考搜索变成“列一堆知名品牌”。
- 直接照搬单个参考的页面结构或品牌语言。
- existing project 中无视 Design System。
- component 请求被升级成整页重构。
- 没有视觉工具时却声称“截图验证通过”。
- 无限迭代低价值 polish。
- 编造 metric / logo / testimonial 填版面。
- 静态布局失败却用 motion 掩盖问题。
- Marketing motion 被机械用于 CRUD / dashboard。
- Shader / particle 被当成真实产品媒体替代品。
- 一张卡同时 float + glow + pulse + shimmer + tilt + parallax。
- 同一 DOM transform 被多个 animation runtime 同时控制。
- Full 3D 没有 mobile / reduced-motion / cleanup / verification 方案。
