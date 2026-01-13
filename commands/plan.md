---
description: Start enhanced planning with thorough questioning and subagent exploration. Uses iterative confidence metrics to deeply understand requirements before planning implementation.
---

# Enhanced Planning Mode

You are now in enhanced planning mode. Your goal is to reach **HIGH confidence (80+)** before presenting an implementation plan.

> **Reference:** See `_base.md` for shared patterns (confidence levels, model enforcement, checkpoint format).

## Core Principle

**Iterate until confident. Delegate exploration. Collaborate with user. Validate before acting.**

## Confidence Score

```
Score = Intent(25%) + Exploration(25%) + Requirements(15%) + Validation(20%) + Alignment(15%)
```

| Level      | Score | Description                    |
| ---------- | ----- | ------------------------------ |
| INITIAL    | 0-24  | Gathering basic information    |
| DEVELOPING | 25-49 | Some understanding, gaps exist |
| SOLID      | 50-74 | Good understanding, validating |
| HIGH       | 75-89 | Ready to present plan          |
| READY      | 90+   | Complete confidence            |

**Target:** Reach HIGH (80+) before presenting. Display score after each phase. If below threshold, iterate.

## Model Enforcement (REQUIRED)

| Task Type        | Model      | Subagent        | Constraint                                |
| ---------------- | ---------- | --------------- | ----------------------------------------- |
| File search      | **haiku**  | Explore         | MUST use - fast, cheap                    |
| Dependency scan  | **haiku**  | Explore         | MUST use - pattern matching               |
| Test patterns    | **haiku**  | Explore         | MUST use - simple discovery               |
| Code analysis    | **sonnet** | Explore         | MUST use - needs comprehension            |
| Feasibility      | **sonnet** | Explore         | MUST use - pattern matching               |
| Web research     | **sonnet** | Explore         | MUST use - WebSearch/WebFetch             |
| Complexity score | **sonnet** | Explore         | MUST use - quantify effort                |
| Flow analysis    | **opus**   | general-purpose | MUST use - async boundaries, state flows  |
| Risk assessment  | **opus**   | general-purpose | MUST use - breaking changes, edge cases   |
| Plan review      | **sonnet** | Explore         | MUST use - pattern matching, completeness |
| Plan execution   | **opus**   | general-purpose | MUST use - autonomous implementation      |
| User interaction | **opus**   | (main)          | Main thread only                          |

**Model Selection Criteria:**

- **Haiku**: Simple file/pattern searches, dependency scanning - mechanical tasks without reasoning
- **Sonnet**: Code comprehension, pattern detection, feasibility - tasks requiring understanding
- **Opus**: Flow tracing, risk assessment, plan review, execution - quality-critical reasoning

**Negative Constraints:**

- **Haiku** MUST NOT: analyze code logic, trace flows, assess risks, review plans
- **Sonnet** MUST NOT: be used for simple file searches (use haiku), trace complex flows (use opus), assess architectural risks (use opus)
- **Opus** subagents: Reserved for deep validation, plan review, and execution - high-value tasks only

**Context Rule:** Main thread MUST NOT use Read/Grep/Glob directly. Delegate ALL exploration to subagents.

---

## Planning Process

### Phase 1: Intent Clarification (~25/100)

**Goal:** Understand what the user wants and why.

**Step 1a: Ask clarifying questions**

```json
{
  "questions": [
    {
      "question": "What exactly needs to be built or changed?",
      "header": "Goal",
      "options": [
        {
          "label": "New feature",
          "description": "Building functionality that doesn't exist yet"
        },
        {
          "label": "Bug fix",
          "description": "Fixing existing broken behavior"
        },
        {
          "label": "Refactor",
          "description": "Improving code without changing behavior"
        },
        {
          "label": "Enhancement",
          "description": "Improving existing functionality"
        }
      ],
      "multiSelect": false
    },
    {
      "question": "What problem does this solve?",
      "header": "Problem",
      "options": [
        {
          "label": "User-facing issue",
          "description": "Affects end users directly"
        },
        {
          "label": "Developer experience",
          "description": "Makes development easier/faster"
        },
        {
          "label": "Technical debt",
          "description": "Addresses accumulated code quality issues"
        },
        {
          "label": "Performance",
          "description": "Improves speed or resource usage"
        }
      ],
      "multiSelect": true
    },
    {
      "question": "What does success look like?",
      "header": "Success",
      "options": [
        {
          "label": "Working feature",
          "description": "Feature complete and functional"
        },
        {
          "label": "Tests passing",
          "description": "All tests green including new ones"
        },
        { "label": "Deployed", "description": "Running in production" },
        { "label": "Reviewed", "description": "PR approved by team" }
      ],
      "multiSelect": true
    },
    {
      "question": "How should the implementation be tested?",
      "header": "Testing",
      "options": [
        {
          "label": "Unit tests",
          "description": "Test individual functions/components"
        },
        {
          "label": "Integration tests",
          "description": "Test components working together"
        },
        { "label": "E2E tests", "description": "Test full user workflows" },
        { "label": "Manual testing", "description": "I'll test it manually" }
      ],
      "multiSelect": true
    }
  ]
}
```

**Step 1b: Pre-flight check (optional but recommended)**

```
Task (Explore, model=haiku):
"Quick health check:
1. Git status - uncommitted changes?
2. Dependencies installed?
3. Build/tests passing?
Return: Health summary with any blockers."
```

If blockers found, alert user before proceeding.

**Step 1c: Iterate if needed**

If Intent score < 70%:

1. Identify gap: "I need to understand [specific aspect]"
2. Ask targeted follow-up question
3. Proceed when Intent >= 70%

**Checkpoint:** Display confidence score. Proceed when Intent >= 70%.

---

### Phase 2: Parallel Exploration (~55/100)

**Goal:** Understand the codebase through parallel subagent exploration.

**Launch 5 subagents in parallel (single message, multiple Task calls):**

```
# Task 1: File discovery - MUST use haiku
Task (Explore, model=haiku):
"Find files related to [feature area]:
- Source files and their dependencies
- Related test files
- Config files
Return: File paths with brief descriptions."

# Task 2: Test patterns - MUST use haiku
Task (Explore, model=haiku):
"Discover testing setup:
- Test frameworks used
- Test file locations
- Existing coverage for related areas
Return: Testing summary."

# Task 3: Code analysis - MUST use sonnet
Task (Explore, model=sonnet):
"Analyze codebase for [feature]:
1. Existing patterns and conventions
2. Similar implementations to reference
3. Integration points
Return: Patterns found with code examples."

# Task 4: Feasibility - MUST use sonnet
Task (Explore, model=sonnet):
"Evaluate feasibility of [feature]:
1. Does codebase support this pattern?
2. What can be reused?
3. What new code is needed?
4. Any conflicting patterns?
Return: Feasibility assessment with evidence."

# Task 5: External research - MUST use sonnet (if needed)
Task (Explore, model=sonnet):
"Research best practices for [feature]:
- Use WebSearch for documentation/guides
- Use WebFetch for relevant articles
- Look for common patterns and pitfalls
Return: Best practices summary with links."
```

**After results return:**

Present findings summary to user:

```json
{
  "questions": [
    {
      "question": "Based on what I found, does this match your expectations?",
      "header": "Verify",
      "options": [
        {
          "label": "Yes, continue",
          "description": "Exploration looks complete"
        },
        {
          "label": "Explore more",
          "description": "I think you missed some areas"
        },
        {
          "label": "Clarify findings",
          "description": "I have questions about what you found"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Iterate if needed:**

If Exploration score < 60% or user wants more:

1. Launch additional targeted subagents
2. Re-explore specific areas
3. Loop until user confirms understanding

**Checkpoint:** Display confidence score. Proceed when Exploration >= 60%.

---

### Phase 3: Approach Selection (~70/100)

**Goal:** Select implementation approach and identify risks.

**Step 3a: Present approaches**

Based on exploration, identify potential approaches and present trade-offs:

```json
{
  "questions": [
    {
      "question": "Which approach should we use?",
      "header": "Approach",
      "options": [
        {
          "label": "Option A (Recommended)",
          "description": "[approach with pros/cons]"
        },
        {
          "label": "Option B",
          "description": "[alternative approach with pros/cons]"
        },
        {
          "label": "Need more info",
          "description": "Can't decide yet, need to explore more"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Step 3b: Targeted validation (conditional)**

If complexity indicators found, launch triage → analysis:

```
# Triage - MUST use haiku
Task (Explore, model=haiku):
"Search [affected files] for complexity indicators:
- Async/await patterns
- State management
- Security-sensitive code
- Large files (>500 lines)
Return: Complexity flags per file."

# Analysis (only for flagged areas) - MUST use sonnet
Task (Explore, model=sonnet):
"Deep analysis of [flagged area]:
- Identify specific risks
- Check for edge cases
- Recommend mitigations
Return: Risk assessment with severity."
```

**Step 3c: Confirm understanding**

```json
{
  "questions": [
    {
      "question": "I've identified these risks. Any concerns?",
      "header": "Risks",
      "options": [
        { "label": "Looks good", "description": "Risks are acceptable" },
        {
          "label": "Concerned about specific risk",
          "description": "I want to discuss specific risks"
        },
        {
          "label": "Add more mitigations",
          "description": "I want more safety nets"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Iterate if needed:**

If user has concerns:

1. Address specific concerns
2. Run additional validation
3. Loop until user is comfortable

**Checkpoint:** Display confidence score. Proceed when Validation >= 50% AND Alignment >= 50%.

---

### Phase 3.5: Deep Validation (~80/100)

**Goal:** Use opus for deep analysis of flow and risk before drafting plan.

**Launch 2 opus subagents in parallel:**

```
# Task 1: Flow analysis - MUST use opus + general-purpose
Task (general-purpose, model=opus):
"Analyze data flow for implementing [feature]:
1. Entry points where data enters the system
2. Transformations and state changes along the path
3. Async boundaries and potential race conditions
4. Output destinations and side effects
5. Integration points with existing flows

Return comprehensive flow map with:
- Data flow diagram (text-based)
- Potential bottlenecks identified
- State mutation points
- Async coordination requirements"

# Task 2: Risk assessment - MUST use opus + general-purpose
Task (general-purpose, model=opus):
"Assess implementation risks for [feature]:
1. Breaking changes to existing functionality
2. Edge cases and failure modes
3. Security implications (input validation, auth, data exposure)
4. Performance concerns (N+1 queries, memory, latency)
5. Migration/rollback complexity

Return risk matrix:
| Risk | Severity | Likelihood | Mitigation |
With detailed explanation for each HIGH severity item."
```

**After results return:**

Synthesize findings and present to user:

```json
{
  "questions": [
    {
      "question": "Deep validation found [X risks/concerns]. Ready to proceed to planning?",
      "header": "Validate",
      "options": [
        {
          "label": "Yes, proceed",
          "description": "Risks are acceptable, draft the plan"
        },
        {
          "label": "Address risks first",
          "description": "I want to discuss specific concerns"
        },
        {
          "label": "Re-scope",
          "description": "Reduce scope to avoid high risks"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Checkpoint:** Display confidence score. Proceed when overall score >= 75%.

---

### Phase 4: Plan Review (~85/100)

**Goal:** Have sonnet review the draft plan before presenting to user.

**Step 4a: Draft the plan internally**

Based on all exploration, validation, and deep analysis, draft the implementation plan (do not present yet).

**Step 4b: Launch plan review**

```
# Plan review - MUST use sonnet (pattern matching + completeness check)
Task (Explore, model=sonnet):
"Review this implementation plan:

[Draft plan summary with steps, files, decisions, risks]

Evaluate:
1. **Plan Quality**
   - Are all steps clear and actionable?
   - Is the scope well-defined?
   - Are dependencies properly ordered?

2. **Code Impact**
   - Are all affected files identified?
   - Are integration points covered?
   - Is test coverage addressed?

3. **Risk Coverage**
   - Are edge cases from risk assessment addressed?
   - Are rollback strategies defined?
   - Are security concerns mitigated?

4. **Completeness**
   - Does plan achieve stated goals?
   - Are success criteria measurable?
   - Is anything missing?

Return:
- Review score (0-100)
- Issues found (list)
- Suggestions for improvement"
```

**Step 4c: Iterate if needed**

If review score < 80%:

1. Address issues raised
2. Re-draft affected sections
3. Re-run review until passes

**Checkpoint:** Display confidence score and review score. Proceed when review >= 80%.

---

### Phase 5: Plan Presentation & Execution (~100/100)

**Goal:** Present reviewed plan, score complexity, and optionally execute.

**Step 5a: Present plan**

When confidence >= 80%, present:

```markdown
## Implementation Plan

### Confidence: [score]/100 (HIGH)

### Summary

[1-2 sentences on what will be built]

### Steps

1. **[Step title]**
   - Files: `path/to/file`
   - Changes: [description]
   - Dependencies: [what must be done first]

### Key Decisions

| Decision | Status    | Rationale |
| -------- | --------- | --------- |
| [choice] | Confirmed | [why]     |

### Risks & Mitigations

| Risk   | Severity     | Mitigation |
| ------ | ------------ | ---------- |
| [risk] | High/Med/Low | [how]      |

### Testing Strategy

[How the implementation will be tested]

### Unresolved Questions

- [Requirement needing clarification before implementation]
- [Technical decision requiring more research]
- [Assumption that should be validated during implementation]

_If these affect plan execution, address them before proceeding._
```

**Step 5b: Complexity scoring**

```
# Complexity - MUST use sonnet
Task (Explore, model=sonnet):
"Score complexity for each step:
- Complexity (1-5)
- Risk (1-5)
- Dependencies (count)
- Effort: S/M/L

Identify:
- Critical path
- High-risk steps (complexity × risk > 15)
- MVP scope (minimum viable)
Return: Complexity matrix."
```

Present complexity summary to user.

**Step 5c: Get approval**

```json
{
  "questions": [
    {
      "question": "Ready to proceed with this plan?",
      "header": "Proceed",
      "options": [
        {
          "label": "Yes, execute plan (Recommended)",
          "description": "Launch execution subagent"
        },
        {
          "label": "Yes, I'll implement",
          "description": "I want to implement manually"
        },
        { "label": "Revise plan", "description": "I have changes" },
        { "label": "More questions", "description": "Need to clarify" }
      ],
      "multiSelect": false
    }
  ]
}
```

**Step 5d: Iterate if needed**

If user selects "Revise plan" or "More questions":

1. Address concerns
2. Re-run relevant phases
3. Loop until approved

**Step 5e: Execute (if requested)**

```
# Execution - MUST use opus + general-purpose
Task (general-purpose, model=opus):
"Execute this implementation plan:

[Full plan]
[Complexity analysis]

Instructions:
1. Follow suggested execution order
2. For each step: read files → make changes → verify
3. If blocked: document and attempt workaround
4. After completion: run tests, summarize changes

Return: Execution report with files modified, test results, follow-ups."
```

Present execution report to user.

---

## Iterative Loop Summary

```
┌─────────────────────────────────────────────────────────────────┐
│                      ITERATIVE PLANNING                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Phase 1: Intent            ──► Score < 70%? → Ask more         │
│           ↓                                                      │
│  Phase 2: Exploration       ──► Score < 60%? → Explore more     │
│           ↓                                                      │
│  Phase 3: Approach          ──► Score < 50%? → Validate more    │
│           ↓                                                      │
│  Phase 3.5: Deep Validation ──► Score < 75%? → Analyze more     │
│           ↓                      (opus flow + risk)              │
│  Phase 4: Plan Review       ──► Review < 80%? → Revise draft    │
│           ↓                      (sonnet quality gate)           │
│  Phase 5: Present & Execute ──► User wants changes? → Revise    │
│           ↓                                                      │
│  Execute (optional)                                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘

After EVERY phase:
1. Display confidence score with breakdown
2. Check if threshold met
3. If not: iterate within phase
4. If yes: proceed to next phase
5. Always confirm with user before major transitions
```

## Collaboration Checkpoints

| After     | Ask User                               | Purpose                |
| --------- | -------------------------------------- | ---------------------- |
| Phase 1   | "Does this capture your intent?"       | Confirm understanding  |
| Phase 2   | "Does exploration match expectations?" | Verify coverage        |
| Phase 3   | "Which approach? Any risk concerns?"   | Get decisions          |
| Phase 3.5 | "Deep validation found X. Proceed?"    | Confirm risk tolerance |
| Phase 5   | "Ready to proceed with reviewed plan?" | Final approval         |

---

## Factor Scoring Guide

| Factor       | Low (0-30%)                   | Medium (31-70%)                     | High (71-100%)                                     |
| ------------ | ----------------------------- | ----------------------------------- | -------------------------------------------------- |
| Intent       | < 2 questions answered        | 2-3 questions answered              | All 4 questions answered AND user confirmed intent |
| Exploration  | < 3 files examined            | 3-7 files AND test patterns found   | 8+ files AND dependencies AND patterns mapped      |
| Requirements | No edge cases identified      | 1-2 edge cases noted                | Edge cases AND constraints AND success criteria    |
| Validation   | No approach options presented | 1 approach suggested                | 2+ options with trade-offs AND user chose          |
| Alignment    | 0 user confirmations          | 1 confirmation (intent OR approach) | 3+ confirmations across phases                     |

**How to calculate score:**

1. Rate each factor using the criteria above (0-100%)
2. Apply weights: Intent(25%) + Exploration(25%) + Requirements(15%) + Validation(20%) + Alignment(15%)
3. Sum for total confidence score

## Minimum Thresholds for HIGH (80+)

| Factor       | Minimum | What it measures                |
| ------------ | ------- | ------------------------------- |
| Intent       | 70%     | Goal clarity, user confirmation |
| Exploration  | 60%     | Codebase understanding          |
| Requirements | 50%     | Scope clarity, edge cases       |
| Validation   | 50%     | Approach feasibility            |
| Alignment    | 50%     | User decisions confirmed        |

---

## Anti-Patterns

**Don't:**

- Present plan before 80% confidence
- Skip user confirmation at checkpoints
- Use opus for simple searches (use haiku)
- Read files directly in main thread (use subagents)

**Do:**

- Show confidence score at every phase
- Iterate until thresholds met
- Ask user before major decisions
- Delegate all exploration to subagents

## Escape Hatch

If user wants plan early:

```
Current confidence is [X]/100. I can present now, but note:
- [Gap 1: what's missing]
- [Gap 2: risks]

**Proceeding with preliminary plan...**

[Present plan with 'PRELIMINARY' labels on unvalidated sections]
```
