# Product as Visual Material

优秀的技术产品页面不一定需要额外寻找“装饰素材”。很多时候，**产品能力本身就是最强视觉素材**。

本 reference 用于 developer tools、AI infrastructure、observability、data tooling、automation、creative coding、GPU/WebGL 等产品。

---

# 1. Capability-as-Proof

如果产品具备可展示的实时能力，优先让 Hero / Feature Surface 展示真实能力，而不是用抽象插画代替。

例如：

- shader library → 真实 shader 输出；
- observability → trace / span / topology / latency propagation；
- agent platform → agent run / tool call / state transition；
- database → query / schema / realtime mutation；
- deployment platform → build / deploy / edge routing；
- image/video tool → before / process / output；
- workflow tool → input → transformation → destination。

原则：

> Show the product doing the thing it claims to do.

---

# 2. Hero = Claim + Live Evidence

Developer / infrastructure marketing Hero 可以使用：

```text
Claim
+
Product-native visual proof
+
Immediate way to inspect / try / understand
```

而不是：

```text
Claim
+
Generic gradient / orb / particles
```

Product-native proof 可能是：

- executable demo;
- interactive canvas;
- terminal command;
- live code + rendered output;
- real product screenshot;
- real system diagram driven by actual concepts;
- small simulated-but-truthful workflow using real domain objects。

不伪造 benchmark、customer、uptime 或 production event。

---

# 3. One Capability, Multiple Surfaces

当一个核心能力可以产生多个真实输出时，可将其本身作为 section macrostructure。

```text
One Capability
      ↓
Web / App
Image
Video
CLI / CI
API
Data / Artifact
```

这比通用 `6 feature cards` 更有说服力，因为页面结构直接来自产品能力。

每个 output surface：

- 使用一致 frame grammar；
- label 表示真实媒介或运行环境；
- detail 使用真实格式/分辨率/状态（只有数据确实可知时）；
- 内容本身承担视觉差异，不靠每张卡不同渐变。

---

# 4. Source → Transformation → Outputs

开发者产品经常适合以下视觉语法：

```text
Source / Command / API
          ↓
Transformation Engine
          ↓
Multiple Real Outputs
```

可以使用 connector lines、nodes、code labels、runtime tags，但这些结构必须编码真实关系。

禁止 decorative topology：如果线、节点和箭头不能回答“谁连接谁、为什么”，删除。

---

# 5. Enhancement Layer Is Optional

高级 GPU / canvas / shader / 3D Hero 应视为 enhancement，而不是页面可用性的基础。

理想分层：

```text
Server-rendered / semantic content
        +
Progressively enhanced canvas / GPU scene
```

要求：

- GPU scene 失败时核心标题、说明、CTA 仍存在；
- canvas 默认 `aria-hidden`（如果纯视觉）；
- visual layer 不截获主内容 pointer events；
- capability detection 可以关闭增强层；
- renderer 生命周期必须 cleanup/dispose；
- theme change、resize、performance sampling 等不应破坏 HTML 内容。

这条规则适用于 WebGPU / WebGL / Three.js / shader / particle。

---

# 6. Visual System From Domain Primitives

优先从产品原语构建视觉词汇。

例：Observability

```text
span
trace
critical path
latency
error propagation
dependency
```

例：GPU / shader

```text
pipeline
material
light
surface
render target
frame
compute
```

例：Agent

```text
run
tool call
state
memory
artifact
approval
handoff
```

然后再决定：

- shape；
- motion；
- connection；
- typography；
- surface treatment。

不要从“tech = neon grid”反推产品语言。

---

# 7. Proof Surface > Marketing Card

如果可以展示真实：

- code；
- output；
- workflow；
- state；
- command；
- artifact；

就优先于：

```text
Icon
Feature title
Two-line marketing copy
```

Marketing copy 可以解释 proof，但不能代替 proof。

---

# 8. Media Priority for Developer Products

```text
1. Real executable/demo evidence
2. Real product surface / screenshot
3. Real code + output relationship
4. Domain diagram / data visualization
5. Render / illustration tied to domain
6. 2.5D enhancement
7. Shader / particle / 3D atmosphere
8. Generic abstract tech decoration
```

越往下，越需要额外 justification。

---

# 9. Progressive Enhancement Gate

对于 Tier 5–6 视觉，检查：

- Is the HTML content useful without it?
- Can the visual be disabled by capability/performance policy?
- Does it have a static/mobile fallback?
- Is the scene decorative or informative?
- If informative, is equivalent information available accessibly?
- Are expensive assets preloaded only when needed?
- Is teardown explicit?

没有可靠 fallback 时，不应让 GPU visual 承担唯一产品解释职责。

---

# 10. Anti-copy Rule

学习优秀开发者网站时，只迁移：

- product-native visual proof；
- capability-driven section structure；
- source-to-output storytelling；
- progressive enhancement architecture；
- restrained technical labeling。

不要复制：

- 独特 logo geometry；
- proprietary shader / prism / artwork；
- exact hero composition；
- exact color treatment；
- copywriting / naming；
- unique interaction choreography。

目标不是“做得像某个开发者网站”，而是让自己的产品能力成为自己的视觉语言。
