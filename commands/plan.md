---
description: Start enhanced planning with thorough questioning and subagent exploration. Uses iterative confidence metrics to deeply understand requirements before planning implementation.
---

# Enhanced Planning Mode

You are now in enhanced planning mode. Your goal is to achieve **high confidence** (80+) in your understanding before presenting an implementation plan.

## Core Principle

**Iterate until confident. Delegate exploration. Validate deeply. Confirm with user.**

## Confidence Score

Calculate confidence using this formula:

```
Score = Intent(20%) + Context(15%) + Requirements(15%) + Solution(15%) + Validation(15%) + Risk(10%) + Alignment(10%)
```

| Level      | Score | Description                    |
| ---------- | ----- | ------------------------------ |
| INITIAL    | 0-24  | Gathering basic information    |
| DEVELOPING | 25-49 | Some understanding, gaps exist |
| SOLID      | 50-74 | Good understanding, validating |
| HIGH       | 75-89 | Ready to present plan          |
| READY      | 90+   | Complete confidence            |

**Target:** Reach HIGH (80+) before presenting the plan. Display score after each step.

## Model Enforcement (REQUIRED)

You MUST follow these model restrictions for ALL Task tool invocations:

| Task Type          | Model      | Subagent        | Constraint                                       |
| ------------------ | ---------- | --------------- | ------------------------------------------------ |
| File search        | **haiku**  | Explore         | MUST use - fast, cheap                           |
| Dependency scan    | **haiku**  | Explore         | MUST use - simple pattern matching               |
| Pre-flight checks  | **haiku**  | Explore         | MUST use - simple health checks                  |
| Pattern triage     | **haiku**  | Explore         | MUST use - flag areas for deeper analysis        |
| Code analysis      | **sonnet** | Explore         | MUST use - needs comprehension                   |
| Approach testing   | **sonnet** | Explore         | MUST use - pattern matching, feasibility         |
| Web research       | **sonnet** | Explore         | MUST use - WebSearch/WebFetch for docs/patterns  |
| Targeted analysis  | **sonnet** | Explore         | MUST use - analyze areas flagged by triage       |
| Complexity scoring | **sonnet** | Explore         | MUST use - quantify implementation effort        |
| Flow analysis      | **opus**   | general-purpose | ESCALATION ONLY - when sonnet finds complexity   |
| Risk assessment    | **opus**   | general-purpose | ESCALATION ONLY - when sonnet finds high risks   |
| Plan review        | **opus**   | general-purpose | QUALITY OVERRIDE - comprehensive review required |
| Plan execution     | **opus**   | general-purpose | MUST use - autonomous implementation             |
| User interaction   | **opus**   | (main)          | Main thread only - NOT spawned as subagent       |

**Model Selection Criteria:**

- **Haiku**: Simple file/pattern searches, dependency scanning, triage - mechanical tasks without reasoning
- **Sonnet**: Code comprehension, pattern detection, approach feasibility, web research, targeted analysis - tasks requiring reasoning
- **Opus**: Complex flow tracing, high-risk assessment, plan review, plan execution - reserved for high-value tasks

**Negative Constraints:**

- **Haiku** MUST NOT: analyze code patterns, investigate dependencies, reason about architecture, test approaches
- **Sonnet** MUST NOT: be used for simple file searches (use haiku), execute plans (use opus), perform final review (use opus)
- **Opus** subagents: Reserved for escalation (complex flows/high risks), plan review, and plan execution only

**Cost Optimization Rule:**

- Use **haiku triage → sonnet analysis → opus escalation** pattern to minimize opus usage
- Only escalate to opus when sonnet analysis finds complexity or ambiguity

**Context Optimization Rule (CRITICAL):**

- Main thread MUST NOT use Read, Grep, or Glob tools directly
- ALL file exploration MUST be delegated to subagents
- Main thread only receives summaries, preserving context for longer sessions

---

## Planning Process

### Phase 0.5: Pre-Flight Health Check (~5/100)

**Launch 1 haiku subagent for repository health check:**

```
# Pre-flight check - MUST use haiku
Task (Explore, model=haiku):
"Perform pre-flight health check:
1. Git status - any uncommitted changes?
2. Dependencies - are node_modules/vendor installed?
3. Build status - any obvious compilation errors?
4. Test status - do tests pass? (quick check only)

Return: Health report with any blockers or warnings."
```

If blockers found, alert user before proceeding:

```
⚠️ Pre-flight issues detected:
- [issue 1]
- [issue 2]

Recommend resolving before planning. Continue anyway?
```

### Phase 1: Intent Clarification (~15/100)

Ask clarifying questions using AskUserQuestion:

- What exactly needs to be built?
- What problem does this solve?
- What does success look like?
- What constraints exist?

### Phase 2: Codebase Exploration (~45/100)

**Launch 5 subagents in parallel (single message, multiple Task calls):**

```
# Task 1: File search + dependency scan - MUST use haiku
Task 1 (Explore, model=haiku):
"Search for files related to [feature area].
Also identify:
- Import/export dependencies
- Affected modules
- Related test files

Return: file paths, dependency graph, and affected areas."

# Task 2: Test file discovery - MUST use haiku
Task 2 (Explore, model=haiku):
"Search for test files and testing patterns:
1. Test file locations and naming conventions
2. Test frameworks used (jest, pytest, etc.)
3. Existing test coverage for related areas
4. Test utilities and helpers available

Return: test file paths, framework info, and coverage gaps."

# Task 3: Code analysis + pattern detection - MUST use sonnet
Task 3 (Explore, model=sonnet):
"Analyze the codebase for:
1. Existing patterns and conventions
2. Similar implementations to reference
3. Integration points for [feature]

Return structured summary with:
- Key files found (with paths)
- Patterns observed
- Code examples to follow"

# Task 4: Approach feasibility testing - MUST use sonnet
Task 4 (Explore, model=sonnet):
"Evaluate feasibility of implementing [feature] in this codebase:
1. Does the codebase support this pattern?
2. What existing code can be reused?
3. What new abstractions are needed?
4. Are there conflicting patterns?

Return feasibility assessment with evidence from codebase."

# Task 5: Web research - MUST use sonnet with WebSearch/WebFetch
Task 5 (Explore, model=sonnet):
"Research external resources for [feature]:
1. Use WebSearch to find best practices and documentation
2. Use WebFetch to retrieve relevant articles/docs
3. Look for common patterns and pitfalls
4. Find reference implementations if available

Search queries to try:
- '[technology] [feature] best practices'
- '[technology] [feature] implementation guide'
- '[feature] common pitfalls'

Return: Summary of best practices, relevant links, and recommendations."
```

### Phase 3: Solution Validation (~65/100)

Based on exploration results:

1. Identify potential approaches
2. Evaluate against existing patterns
3. Ask user about trade-offs using AskUserQuestion

Example:

```json
{
  "questions": [
    {
      "question": "Which approach should we use?",
      "header": "Approach",
      "options": [
        { "label": "Option A", "description": "[trade-offs]" },
        { "label": "Option B", "description": "[trade-offs]" }
      ],
      "multiSelect": false
    }
  ]
}
```

### Phase 3.5: Deep Validation (~75/100)

Deep validation uses a **three-tier approach** to minimize opus costs while maintaining quality:

#### Phase 3.5a: Triage (Haiku)

**Launch 4 haiku subagents in parallel for pattern detection:**

```
# Task 1: Async/flow pattern triage - MUST use haiku
Task 1 (Explore, model=haiku):
"Search for patterns that indicate complexity:
1. Async/await patterns in affected files
2. State management (Redux, Context, stores)
3. Event emitters or pub/sub patterns
4. Database transactions or locks

Return: List of files with complexity indicators (yes/no per category)."

# Task 2: Security pattern triage - MUST use haiku
Task 2 (Explore, model=haiku):
"Search for security-sensitive patterns:
1. Authentication/authorization checks
2. Input validation or sanitization
3. SQL queries or ORM usage
4. External API calls or secrets

Return: List of files with security indicators (yes/no per category)."

# Task 3: Test coverage triage - MUST use haiku
Task 3 (Explore, model=haiku):
"Search for test coverage gaps:
1. Test files for affected modules
2. Mock/stub patterns used
3. Integration test presence
4. E2E test coverage

Return: Coverage summary (tested/untested per module)."

# Task 4: Risk indicator triage - MUST use haiku
Task 4 (Explore, model=haiku):
"Search for risk indicators:
1. TODO/FIXME/HACK comments in affected areas
2. Deprecated code or APIs
3. Complex conditionals (nested if/else)
4. Large files (>500 lines)

Return: Risk indicator counts per file."
```

#### Phase 3.5b: Targeted Analysis (Sonnet)

**Launch sonnet subagents only for areas flagged by triage:**

```
# For each area flagged by triage, launch targeted analysis:

# If async patterns found:
Task (Explore, model=sonnet):
"Analyze async flow in [flagged files]:
1. Identify race condition risks
2. Map state transitions
3. Check error handling in async paths

Return: Flow issues with severity (Low/Medium/High)."

# If security patterns found:
Task (Explore, model=sonnet):
"Analyze security in [flagged files]:
1. Review input validation completeness
2. Check authorization logic
3. Identify data exposure risks

Return: Security issues with severity and recommendations."

# If test coverage gaps found:
Task (Explore, model=sonnet):
"Analyze testing strategy for [flagged modules]:
1. What test types are needed?
2. What mocks/fixtures are required?
3. Estimate test implementation effort

Return: Testing plan with priorities."
```

#### Phase 3.5c: Opus Escalation (Conditional)

**Only escalate to opus if sonnet analysis found:**

- High-severity flow complexity (async boundaries, race conditions)
- High-severity security risks
- Architectural ambiguity requiring expert judgment

```
# CONDITIONAL: Only if sonnet found high-severity issues

# If complex flow issues found:
Task (general-purpose, model=opus):
"Deep analysis of complex flow in [specific area]:
1. Map complete data flow with async boundaries
2. Identify all race condition scenarios
3. Design synchronization strategy
4. Recommend architectural changes if needed

Return: Comprehensive flow map with solutions."

# If high-severity security risks found:
Task (general-purpose, model=opus):
"Deep security analysis for [specific vulnerability]:
1. Assess exploitability
2. Map attack surface
3. Design defense-in-depth strategy
4. Recommend security controls

Return: Security assessment with mitigation plan."
```

**Escalation Decision Matrix:**

| Sonnet Finding             | Severity | Escalate to Opus? |
| -------------------------- | -------- | ----------------- |
| Simple flow                | Low      | No                |
| Async without race risk    | Medium   | No                |
| Async with race conditions | High     | **Yes**           |
| Basic input validation     | Low      | No                |
| Auth logic gaps            | Medium   | No                |
| Data exposure risk         | High     | **Yes**           |
| Architectural ambiguity    | High     | **Yes**           |

### Phase 4: Plan Review (~85/100)

**Launch opus subagent for comprehensive plan review:**

```
# Plan review - QUALITY OVERRIDE: Use opus for comprehensive review
Task (general-purpose, model=opus):
"Review this implementation plan for [feature]:

[Draft plan summary]

Check:
1. Plan Quality
   - Are all steps clear and actionable?
   - Is the scope well-defined?
   - Are dependencies properly ordered?

2. Code Impact
   - Are all affected files identified?
   - Are integration points covered?
   - Is test coverage addressed?

3. Risk Coverage
   - Are edge cases documented?
   - Are rollback strategies defined?
   - Are security concerns addressed?

4. Completeness
   - Does plan achieve stated goals?
   - Are success criteria measurable?
   - Is anything missing?

Return: Review score (0-100), issues found, suggestions for improvement."
```

If review score < 80%, iterate on the plan before presenting.

### Phase 5: Plan Presentation (~90/100)

When confidence >= 80% AND review passes, present:

```markdown
## Implementation Plan

### Confidence: [score]/100 (HIGH)

### Review Score: [review_score]/100

### Summary

[1-2 sentences on what will be built]

### Steps

1. **[Step title]**
   - Files: `path/to/file`
   - Changes: [description]
   - Dependencies: [what must be done first]

### Key Decisions

| Decision | Status            | Rationale |
| -------- | ----------------- | --------- |
| [choice] | Confirmed/Assumed | [why]     |

### Risks & Mitigations

| Risk   | Severity     | Mitigation       |
| ------ | ------------ | ---------------- |
| [risk] | High/Med/Low | [how to address] |

### Edge Cases

| Scenario | Handling        |
| -------- | --------------- |
| [case]   | [how addressed] |
```

Then ask for approval:

```json
{
  "questions": [
    {
      "question": "Ready to proceed with this plan?",
      "header": "Proceed?",
      "options": [
        {
          "label": "Yes, execute plan",
          "description": "Launch execution subagent to implement"
        },
        {
          "label": "Yes, but I'll implement",
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

### Phase 5.5: Complexity Scoring (~92/100)

**Launch sonnet subagent for implementation complexity analysis:**

```
# Complexity scoring - MUST use sonnet
Task (Explore, model=sonnet):
"Score implementation complexity for each step in the plan:

For each step, calculate:
1. Complexity (1-5): How intricate is the change?
2. Risk (1-5): What could go wrong?
3. Dependencies (count): How many other steps depend on this?
4. Estimated effort: S/M/L

Also identify:
- Critical path (longest chain of dependencies)
- Highest-risk steps (complexity * risk > 15)
- Suggested execution order (dependency-aware)
- Incremental delivery opportunities (MVP scope)

Return: Complexity matrix with execution recommendations."
```

Present complexity summary:

```markdown
### Implementation Complexity

| Step | Complexity | Risk | Dependencies | Effort | Priority |
| ---- | ---------- | ---- | ------------ | ------ | -------- |
| 1    | 3          | 2    | 0            | M      | First    |
| 2    | 4          | 3    | 1            | L      | Second   |

**Critical Path:** Step 1 → Step 2 → Step 4
**High-Risk Steps:** Step 2 (score: 12)
**MVP Scope:** Steps 1-3 (core functionality)
```

### Phase 6: Plan Execution (~100/100)

**If user selected "Yes, execute plan", launch opus subagent for autonomous execution:**

```
# Plan execution - MUST use opus + general-purpose
Task (general-purpose, model=opus):
"Execute this implementation plan autonomously:

## Plan Summary
[Full plan from Phase 5]

## Complexity Analysis
[From Phase 5.5]

## Execution Instructions
1. Follow the suggested execution order
2. For each step:
   - Read relevant files (via subagents if needed)
   - Make the required changes
   - Verify changes work (run tests if available)
   - Move to next step
3. If you encounter blockers:
   - Document the blocker
   - Attempt reasonable workarounds
   - If truly stuck, return with status and ask for guidance
4. After all steps complete:
   - Run full test suite
   - Summarize all changes made
   - List any follow-up items

## Success Criteria
[From original plan]

Return: Execution report with:
- Steps completed (with file paths modified)
- Tests run and results
- Any issues encountered and resolutions
- Follow-up recommendations"
```

**Execution Status Updates:**

The execution subagent will return a comprehensive report. Present to user:

```markdown
## Execution Complete

### Summary

[Brief description of what was implemented]

### Changes Made

| Step | Files Modified | Status  |
| ---- | -------------- | ------- |
| 1    | `path/to/file` | ✅ Done |
| 2    | `path/to/file` | ✅ Done |

### Test Results

- Unit tests: ✅ Passing (42/42)
- Integration tests: ✅ Passing (8/8)

### Follow-up Items

- [ ] Update documentation
- [ ] Add additional edge case tests

### Files Modified

- `src/feature/new.ts` (created)
- `src/feature/existing.ts` (modified)
- `tests/feature.test.ts` (created)
```

## Factor Scoring Guide

| Factor       | Low (0-25%)      | Medium (50%)         | High (75-100%)            |
| ------------ | ---------------- | -------------------- | ------------------------- |
| Intent       | Vague request    | Core goal understood | Explicit, confirmed goals |
| Context      | No exploration   | Key files identified | All areas mapped          |
| Requirements | Scope unknown    | Scope clear          | Edge cases documented     |
| Solution     | No approach      | Approach identified  | Validated with evidence   |
| Validation   | Not validated    | Basic checks done    | Deep flow/risk analysis   |
| Risk         | Not considered   | Main risks noted     | Mitigations planned       |
| Alignment    | No confirmations | Basic confirmed      | Key decisions confirmed   |

## Subagent Usage Summary (REQUIRED)

| Phase | Task               | Subagent        | Model      | Parallel? | Enforcement                      |
| ----- | ------------------ | --------------- | ---------- | --------- | -------------------------------- |
| 0.5   | Pre-flight check   | Explore         | **haiku**  | No        | MUST use - health check          |
| 2     | File search        | Explore         | **haiku**  | Yes (5)   | MUST use - fast/cheap            |
| 2     | Test discovery     | Explore         | **haiku**  | Yes (5)   | MUST use - pattern matching      |
| 2     | Code analysis      | Explore         | **sonnet** | Yes (5)   | MUST use - needs comprehension   |
| 2     | Approach testing   | Explore         | **sonnet** | Yes (5)   | MUST use - feasibility           |
| 2     | Web research       | Explore         | **sonnet** | Yes (5)   | MUST use - WebSearch/WebFetch    |
| 3.5a  | Pattern triage     | Explore         | **haiku**  | Yes (4)   | MUST use - flag areas            |
| 3.5b  | Targeted analysis  | Explore         | **sonnet** | Yes (2-4) | MUST use - analyze flagged areas |
| 3.5c  | Flow escalation    | general-purpose | **opus**   | Yes (0-2) | CONDITIONAL - high severity only |
| 3.5c  | Risk escalation    | general-purpose | **opus**   | Yes (0-2) | CONDITIONAL - high severity only |
| 4     | Plan review        | general-purpose | **opus**   | No        | QUALITY OVERRIDE                 |
| 5.5   | Complexity scoring | Explore         | **sonnet** | No        | MUST use - quantify effort       |
| 6     | Plan execution     | general-purpose | **opus**   | No        | MUST use - autonomous execution  |
| 1,3,5 | User interaction   | (main)          | **opus**   | No        | Main thread only                 |

## Parallel Execution Strategy

```
Phase 0.5 (Pre-Flight) - 1 subagent:
└── haiku: Repository health check

Phase 2 (Exploration) - 5 parallel subagents:
├── haiku:  File search + dependency mapping
├── haiku:  Test file discovery
├── sonnet: Code analysis + pattern detection
├── sonnet: Approach feasibility testing
└── sonnet: Web research (WebSearch/WebFetch)

Phase 3.5a (Triage) - 4 parallel haiku subagents:
├── haiku: Async/flow pattern search
├── haiku: Security pattern search
├── haiku: Test coverage search
└── haiku: Risk indicator search

Phase 3.5b (Analysis) - 2-4 parallel sonnet subagents (conditional):
├── sonnet: Async flow analysis (if flagged)
├── sonnet: Security analysis (if flagged)
├── sonnet: Testing strategy (if flagged)
└── sonnet: Risk analysis (if flagged)

Phase 3.5c (Escalation) - 0-2 opus subagents (conditional):
├── opus: Complex flow analysis (if high-severity)
└── opus: Deep security analysis (if high-severity)

Phase 4 (Review) - 1 sequential subagent:
└── opus: Comprehensive plan review

Phase 5 (Presentation) - Main thread:
└── opus: Synthesize and present plan

Phase 5.5 (Complexity) - 1 sequential subagent:
└── sonnet: Implementation complexity scoring

Phase 6 (Execution) - 1 sequential subagent:
└── opus: Autonomous plan execution
```

## Cost Comparison

| Scenario          | Haiku | Sonnet | Opus | Est. Cost Reduction |
| ----------------- | ----- | ------ | ---- | ------------------- |
| **Old (v2.0)**    | 3     | 2      | 4    | Baseline            |
| **New (Simple)**  | 9     | 8      | 3    | ~35% reduction      |
| **New (Complex)** | 9     | 10     | 5    | ~15% reduction      |

_Cost reduction assumes opus is ~15x more expensive than haiku and ~5x more than sonnet._

## Minimum Thresholds for HIGH

- Intent >= 70%
- Context >= 60%
- Requirements >= 50%
- Solution >= 60%
- Validation >= 50%
- Alignment >= 50%

## Anti-Patterns

**Don't:**

- Present plan before 80% confidence
- Skip exploration (delegate it instead)
- Make assumptions without asking
- Ask more than 4 questions per round
- Use opus for simple searches (use haiku)
- Use opus directly without haiku triage first
- Skip the triage phase in 3.5a
- Read files directly in main thread (use subagents)
- Skip the review phase
- Execute without complexity scoring

**Do:**

- Show confidence score at every step
- Delegate ALL file operations to subagents
- Use haiku triage → sonnet analysis → opus escalation pattern
- Launch parallel subagents when possible
- Run web research in Phase 2 for external context
- Only escalate to opus for high-severity findings
- Run deep validation before drafting plan
- Always run plan review before presenting
- Score complexity before execution
- Offer autonomous execution option
- Confirm key decisions with user
- Keep iterating until HIGH

## Escape Hatch

If user wants the plan early:

```
You: Current confidence is [X]/100. I can present now, but note:
- [gap 1: e.g., "Flow analysis not completed"]
- [gap 2: e.g., "Risk assessment pending"]
- [gap 3: e.g., "Plan review not performed"]

[Present plan with "Assumed" or "Unvalidated" status on relevant sections]
```
