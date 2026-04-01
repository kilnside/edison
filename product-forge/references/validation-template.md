# Validation Template

Structure ME skill outputs as a single coherent document. Each section feeds the next.

```markdown
## Business Validation: [Product Name]

### Problem Validation (from validate-idea)
- Who has this problem: [specific persona]
- Current solutions: [list what exists]
- Pain level: [hair-on-fire / moderate / mild]
- Would they pay: [evidence]
- Verdict: [VALIDATED / NEEDS MORE / PIVOT]

### Pricing (from pricing)
- Model: [value-based / cost-based / hybrid]
- Initial price: $X/month
- Why: [rationale tied to problem validation above]
- Customers to independence: [N at $X]

### MVP Scope (from mvp)
- The ONE thing it does: [sentence]
- Cut from Edison spec: [list of features deferred]
- Keep from Edison spec: [list of features that stay]
- Ship timeline: [weekend / week / month]

### Spec Reconciliation
- Features cut: update DEFINITIVE-SPEC.md "What We Are NOT Building"
- Pricing added: update spec with pricing model
- Scope adjusted: mark deferred components
```

Key rule: If validate-idea returns PIVOT, stop. Tell the user. Don't proceed to build
something that doesn't validate.
