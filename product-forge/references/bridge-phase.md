# Bridge Phase — Detailed Reference

The Bridge phase transforms a design spec into buildable instructions. It produces three
artifacts that no other skill generates:

## 1. API Contract

### How to Extract

Read the DEFINITIVE-SPEC.md. For each component that mentions endpoints, API calls,
or data flow between frontend and backend:

1. Identify every HTTP interaction (explicit or implied)
2. Determine the method (POST for mutations, GET for reads)
3. Define the request body shape (from the spec's data types)
4. Define the response shape (what the caller needs)
5. Note which component is the caller and which is the callee

### Template

```markdown
## API Contract: [Product Name]

Generated from: .edison/explorations/[date]-[feature]/synthesis/DEFINITIVE-SPEC.md

### External Services (backend APIs)

| Method | Path | Request Body | Response | Called By | Notes |
|--------|------|-------------|----------|-----------|-------|
| POST | /api/service/init | `{ user_id: string, config: object }` | `{ status: "ok" }` | Onboarding route | Initializes backend model |

### Next.js API Routes (BFF layer)

| Method | Path | Request Body | Response | Frontend Page | Notes |
|--------|------|-------------|----------|--------------|-------|
| POST | /api/onboarding | `{ goal: string, ... }` | `{ user_id, first_item }` | /onboarding | Stores user, calls backend |

### Key Data Types (shared)

```typescript
// These types MUST be used by all agents. No agent may define its own versions.
interface User { ... }
interface Experiment { ... }
```

### Contract Rules
- All mutation endpoints use POST (not GET with query params)
- All responses include an error shape: `{ error: string }` with appropriate status code
- All IDs are UUIDs (crypto.randomUUID())
- Timestamps are ISO 8601 strings
- The backend service URL comes from DOE_ENGINE_URL env var
```

### Why This Matters

In the CannaLens session, three agents built components in parallel:
- The DOE engine expected POST for `/experiments/next`
- The Next.js API route called it as GET
- The onboarding route generated a user ID but didn't pass it to the next-experiment call

These bugs took ~10 minutes to debug. The API contract takes ~2 minutes to write.

## 2. Build Plan

### How to Generate

Read the spec's component list. For each component, identify:
- What it depends on (other components, shared types, running services)
- What depends on it
- Whether it can be built in parallel with others

Then assign to waves:
- **Wave 1:** Components with no dependencies (schema, backend service, types)
- **Wave 2:** Components that depend on Wave 1 (frontend pages, API routes)
- **Wave 3:** Components that depend on a running system (polish, integration tests)

### Between-Wave Actions

After each wave, there's a mandatory verification step:

| After Wave | Action | Tool |
|------------|--------|------|
| Wave 1 | Start servers, test backend API with curl | Bash |
| Wave 2 | `next build` to verify compilation, agent-browser on each page | agent-browser-verify |
| Wave 3 | Full E2E integration test, final build check | Bash + agent-browser |

### Idle Time Utilization

While agents run, the main thread should do non-overlapping work:

| Agents Running | Main Thread Does |
|---------------|-----------------|
| Wave 1 (schema + backend) | Write integration test script skeleton |
| Wave 2 (frontend + routes) | Generate seed data, write README |
| Wave 3 (polish + simplify) | Prepare git commits, write setup instructions |

## 3. Seed Data

### Why Narrative Data Matters

Mock data that tells a story is dramatically more convincing than random data. The demo
should show the product's value proposition playing out over time.

### Template

For a product with an iterative/learning loop:

```
Entry 1: Starting state (baseline, calibration, first attempt)
  → Low satisfaction, the system is learning
Entry 2-3: Exploration (system tries different approaches)
  → Mixed results, some better some worse
Entry 4-5: Discovery (system finds something promising)
  → Satisfaction improves noticeably
Entry 6-7: Refinement (system fine-tunes the winner)
  → High satisfaction, converging
Entry 8: Optimized state (system has found the answer)
  → Consistently high satisfaction
```

Each entry should include:
- What the system recommended (the "input")
- What the user experienced (the "output")
- A brief quote or note that sounds human ("Slept great, no grogginess!")
- A satisfaction score that trends upward with realistic noise
