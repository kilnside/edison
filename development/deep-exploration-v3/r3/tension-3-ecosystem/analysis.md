# Tension 3: Superpowers Relationship -- Standalone or Ecosystem?

**Agent:** Round 3 -- The Provocateur
**Tension:** Edison positions as standalone, but the best user experience may require complementary skills
**Priorities in tension:** P4 (Cross-Project Learning: "be a tenant"), P6 (Binding Portability: "be compatible"), P7 (Decision Gap Positioning: "own the category")

---

## The Removed Constraint

**Constraint: Skills are isolated units with no inter-skill communication protocol.**

The Agent Skills standard defines skills as independent. Each skill has a trigger, a body, and optional resources. No skill knows another skill exists. No skill can invoke another. No standard exists for one skill to say "I'm done, hand this to skill X." Edison's "Relationship to Other Skills" section names four skills -- Brainstorming, Writing Plans, Frontend Design, Simplify -- but this is a prose suggestion, not a protocol. When Edison says "escalate to Edison if brainstorming reveals unexpected complexity," it is writing a note in a bottle and hoping the ocean delivers it.

The constraint being removed: **What if skills could formally declare interfaces -- typed inputs, typed outputs, and explicit handoff points?**

---

## What Becomes Possible

### 1. Edison's Output Becomes a First-Class Input

Today, Edison produces DEFINITIVE-SPEC.md. It contains embedded task blocks with IMPLEMENTS, DEPENDS ON, AGENT INSTRUCTION, MUST, MUST NOT, and VERIFICATION fields. This is already a structured contract. But nothing consumes it structurally.

If skills could declare input schemas, Writing Plans (or GSD's plan-phase) could declare: "I accept a spec file with IMPLEMENTS blocks. Each block becomes a plan phase." Edison would not need to know which planning skill is installed. It would emit a spec in a known format, and any skill that declares it can consume that format would pick it up.

This is not dependency. It is interface compatibility. The difference matters: a dependency means "Edison requires Superpowers." An interface means "Edison produces output that any compatible skill can consume."

Think of it like Unix pipes. `ls` does not depend on `grep`. But `ls | grep .md` works because both agree on the interface: lines of text to stdout. Edison's DEFINITIVE-SPEC.md is already close to this -- structured markdown with predictable fields. The missing piece is a way for the downstream skill to advertise "I can read this."

### 2. The Brainstorming Handoff Gets Real

Edison's routing tree says: "Simple (1-2 choices) -> Brainstorm skill." But which brainstorm skill? The current spec says "Brainstorming" as if there is exactly one. In reality, the user might have Superpowers' brainstorming, or a custom brainstorm skill, or nothing at all.

With declared interfaces, Edison could say: "I need a skill that accepts a `decision-context` (problem statement + 1-2 options) and returns a `decision` (chosen option + rationale)." If Superpowers' brainstorming is installed and declares it handles `decision-context`, the routing works. If nothing is installed, Edison falls back to handling it inline (which it already can -- the Check at score 0-1 effectively does this).

This eliminates the fragile name-based coupling. Edison does not need to know about "Brainstorming" by name. It needs to know that something in the environment can handle a simple decision. If that thing is called "brainstorming" or "quick-decide" or "coin-flip-3000," Edison does not care.

### 3. Decision Gates Could Compose

Edison's Check is a decision gate: 5 questions, score 0-5, threshold at 2. Other skills have their own gates. GSD has phase validation. TDD has test-first verification. Code review has approval gates. Superpowers' verification-before-completion is another gate.

Today these gates are invisible to each other. A user running Edison's Check, then GSD's plan-phase, then TDD's test scaffolding passes through three independent gates that share no information. Each gate re-discovers context the previous one already established.

With composable gates, Edison's Check output could include: "This decision scored 4/5 on interconnection and irreversibility. Explored via 3 rounds. Spec produced." A downstream gate (GSD's plan-phase validation, say) could read this and know: "The design decisions are already validated. I only need to validate the implementation plan, not re-validate the design."

This is not gatekeeping -- it is gate-passing. A signed receipt that says "Edison already checked this."

### 4. The Ecosystem Map Becomes a Runtime Feature

Edison's "Relationship to Other Skills" section is currently static prose. Four skills named, four one-line descriptions. This is documentation, not functionality.

Imagine instead an ecosystem manifest:

```yaml
# In Edison's SKILL.md or a companion file
interfaces:
  produces:
    - type: definitive-spec
      format: markdown
      schema: "IMPLEMENTS + MUST + MUST_NOT + VERIFICATION blocks"
      consumed_by: ["implementation-planner", "task-tracker"]
    - type: decision-gate-result
      format: structured
      schema: "score: 0-5, questions: [], recommendation: build|explore"
      consumed_by: ["any-gate-aware-skill"]
  consumes:
    - type: simple-decision
      format: structured
      schema: "problem + options[] -> chosen + rationale"
      provided_by: ["brainstorming-skill"]
      fallback: "handle inline via Check at score 0-1"
  routes_to:
    - condition: "Check score 0-1, simple decision"
      interface: simple-decision
    - condition: "spec approved, ready to build"
      interface: implementation-planner
    - condition: "implementation complete"
      interface: code-simplifier
```

This manifest does not create dependencies. Every `consumed_by` and `provided_by` field is a suggestion, not a requirement. The `fallback` field means Edison always works alone. But when the ecosystem is present, the experience compounds.

### 5. Edison Becomes a Protocol, Not Just a Skill

Here is the radical departure: What if Edison's most lasting contribution is not the skill itself but the spec format it produces?

DEFINITIVE-SPEC.md with its embedded task blocks (IMPLEMENTS, MUST, MUST NOT, VERIFICATION) is already a structured contract for implementation. If this format became a standard -- "Edison format specs" -- then any skill that produces design decisions could emit Edison-format specs, and any skill that consumes design decisions could read them.

Edison would not need to be installed for its format to be used. A user could manually write an Edison-format spec and any compatible planning skill would consume it. Edison the skill would be the best way to produce these specs, but not the only way.

This is how successful tools actually work. Markdown did not succeed because one editor enforced it. JSON did not succeed because one API required it. They succeeded because the format was useful independently of any single tool. Edison's spec format is already more structured than most design documents. Formalizing it as a standalone standard -- "spec blocks" or "implementation contracts" -- would make Edison's influence outlast Edison itself.

---

## The Counter-Argument: Why This Might Be Wrong

Skills are not Unix commands. They are prompt instructions read by an LLM. The "interface" between them is not a data pipe -- it is the LLM's context window. When Edison says "use the brainstorming skill for simple decisions," the LLM reads that instruction and, if it has the brainstorming skill loaded, follows both. The "handoff" is implicit in the shared context.

Formalizing interfaces might add bureaucracy without adding capability. The LLM already does soft routing -- it reads all loaded skills and uses judgment about which instructions apply. A YAML manifest adds parsing overhead and rigidity to something that works through natural language flexibility.

There is also the adoption problem. For interfaces to work, multiple skill authors must agree on schemas. The skill ecosystem is young (334 skills as of research). Most skill authors are individuals building for their own use. Asking them to declare typed interfaces is asking them to do more work for a benefit that only materializes when other skills adopt the same schemas. This is a classic coordination problem, and coordination problems kill standards that are not backed by a dominant platform.

---

## Why the Counter-Argument Is Insufficient

The coordination problem is real but Edison does not need to solve it universally. Edison only needs to solve it for its own output. DEFINITIVE-SPEC.md already has a predictable structure. Declaring that structure explicitly costs Edison nothing and makes it possible for any future skill to consume it.

The LLM-as-router argument is true today but fragile. As context windows fill and skill counts grow, implicit routing degrades. A skill that says "I accept Edison-format specs" is more reliable than one that says nothing and hopes the LLM figures it out from 50,000 tokens of loaded skill text.

And the key insight: Edison does not need the ecosystem to adopt interfaces universally. Edison just needs to be the first skill that publishes its output schema. If Writing Plans wants to consume it, great. If GSD wants to consume it, great. If nobody does, Edison still works exactly as before. The interface declaration is a zero-cost option with asymmetric upside.

---

## Kernel Extraction

**Even if the full proposal of typed inter-skill interfaces is rejected, the insight that should survive is this:**

**Edison's DEFINITIVE-SPEC.md is already an interface -- it just does not know it yet.**

The embedded task blocks (IMPLEMENTS, MUST, MUST NOT, VERIFICATION) are a structured contract. They have predictable fields, consistent formatting, and clear semantics. Any implementation skill -- human or AI -- can parse them. The only thing missing is an explicit declaration: "This is my output format. Here is what each field means. If you can read this, you can plan from it."

Edison should publish its spec format as a documented schema, independent of whether any inter-skill protocol ever exists. Not because it creates dependencies, but because it creates legibility. A spec that declares its own structure is easier to consume, easier to validate, and easier to evolve than one that relies on convention and good luck.

The practical change to SKILL.md is small. In the "Relationship to Other Skills" section, add:

```markdown
### Edison's Output Contract

DEFINITIVE-SPEC.md follows a predictable structure that other tools can consume:
- Each `## Component:` block is an independent implementation unit
- `IMPLEMENTS:` traces to a named priority from the exploration
- `MUST:` / `MUST NOT:` are binary-testable requirements
- `VERIFICATION:` describes how to confirm the requirement was met
- `DEPENDS ON:` declares file/component prerequisites

Any skill that reads markdown with these fields can plan from an Edison spec.
No Edison installation required to consume the output.
```

This is not an interface protocol. It is documentation of an existing fact. Edison already produces this output. Stating it explicitly turns an accident of format into a deliberate contract. And deliberate contracts are what ecosystems crystallize around.

---

## The Bigger Picture

The Agent Skills ecosystem is where package managers were in 2010. npm did not exist. Bower was not yet born. People copied JavaScript files by hand. The idea of "packages with declared dependencies and semver ranges" seemed over-engineered for a world where most projects used jQuery and maybe one plugin.

Then the ecosystem grew. And the tools that had declared their interfaces -- even informally, even just in a README -- were the ones that composed into larger systems. The tools that worked in isolation stayed in isolation.

Edison does not need to build npm for skills. But it should be the kind of tool that, when someone eventually builds npm for skills, slots in cleanly because it already declared what it produces and what it can consume. The cost of that declaration is a few lines of markdown. The cost of not declaring it is invisibility when composition becomes possible.

The Provocateur's position: **Edison should be standalone in capability and legible in output.** Not dependent on an ecosystem, but ready for one. The spec format is the interface. Publish it.
