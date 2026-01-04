---
name: thorough-analysis
description: Enables thorough, confidence-driven code analysis for improvements. Triggers when users want to improve, optimize, refactor, or enhance code. Iteratively investigates with frequent confirmation questions until confident in recommendations.
---

# Thorough Analysis Skill

When analyzing any code, feature, or system for potential improvements, follow this iterative, confidence-driven approach.

## Triggering Conditions

Activate this skill when:

- User asks to "improve" or "optimize" something
- User asks to "review" code for quality
- User asks "what can be better" or "how can this be improved"
- User wants to refactor or clean up code
- User asks about technical debt or code quality
- User asks to "analyze" performance, security, readability, etc.
- User describes something that "could be better" or "feels off"

## Core Principle

**Analyze iteratively. Quantify confidence. Confirm frequently.**

After EVERY analysis step, calculate and display your confidence score. Ask 2-3 questions to confirm findings and priorities before moving forward. Keep analyzing until you reach HIGH confidence (80+) in your recommendations.

## The Walkthrough Protocol

Before identifying improvements, explain the code's purpose aloud. This forces you to understand what the code does before judging what it should do better. Improvements are meaningless without context.

**Apply it:**

```markdown
Before analyzing for improvements, let me walk through what this code does:

1. This module handles user authentication requests
2. When a login request comes in, it validates credentials against the database
3. If valid, it generates a JWT token and stores the session
4. The token is returned to the client with a 7-day expiry
5. I notice it also handles password reset, but that flow is separate...

**Understanding established.** Now I can identify what could be improved.
```

Use phrases like:

- "Let me walk through what this code is meant to do..."
- "This function's responsibility appears to be..."
- "I see this pattern: [describe], which suggests..."
- "The flow goes: X → Y → Z, and the purpose is..."

Then ask: "Now that I understand its purpose, what could be improved?"

## Confidence Metrics System

Calculate confidence using this weighted formula:

```
AnalysisConfidence = (Goals × 0.20) + (Exploration × 0.20) + (Opportunities × 0.15) +
                     (Priorities × 0.15) + (Trade-offs × 0.15) + (Alignment × 0.15)
```

### Factor Weights

| Factor               | Weight | Description                                     |
| -------------------- | ------ | ----------------------------------------------- |
| Goals Understood     | 20%    | What improvements user wants and why            |
| Codebase Explored    | 20%    | Thoroughness of target area examination         |
| Opportunities Found  | 15%    | Quality and coverage of identified improvements |
| Priorities Confirmed | 15%    | User validated which improvements matter most   |
| Trade-offs Discussed | 15%    | User aware of costs/impacts of proposed changes |
| User Alignment       | 15%    | Overall confirmation of analysis direction      |

### Confidence Levels

| Level          | Score  | Description                                |
| -------------- | ------ | ------------------------------------------ |
| **INITIAL**    | 0-24   | Just starting, gathering basic information |
| **DEVELOPING** | 25-49  | Some understanding, many gaps remain       |
| **SOLID**      | 50-74  | Good understanding, validating approach    |
| **HIGH**       | 75-89  | Strong understanding, ready to present     |
| **READY**      | 90-100 | Complete understanding, high confidence    |

**Target:** Reach HIGH confidence (80+) before presenting final findings.

## Factor Measurement Criteria

### Goals Understood (0-100%)

| Score | Criteria                                                      |
| ----- | ------------------------------------------------------------- |
| 0%    | User request is vague, no clarity on what to improve          |
| 25%   | General area known (e.g., "performance"), specifics unclear   |
| 50%   | Core improvement goals understood, some ambiguity remains     |
| 75%   | Clear understanding of what user wants to improve and why     |
| 100%  | Explicit, confirmed understanding of goals, motivation, scope |

### Codebase Explored (0-100%)

| Score | Criteria                                                     |
| ----- | ------------------------------------------------------------ |
| 0%    | No codebase exploration yet                                  |
| 25%   | Basic structure understood, key files identified             |
| 50%   | Target area examined, patterns observed                      |
| 75%   | Thorough examination of target area and related dependencies |
| 100%  | Complete exploration with all affected areas mapped          |

### Opportunities Found (0-100%)

| Score | Criteria                                                  |
| ----- | --------------------------------------------------------- |
| 0%    | No improvement opportunities identified                   |
| 25%   | 1-2 obvious opportunities, surface-level analysis         |
| 50%   | Several opportunities across multiple categories          |
| 75%   | Comprehensive list with impact/effort assessed            |
| 100%  | Exhaustive analysis with prioritized, actionable findings |

### Priorities Confirmed (0-100%)

| Score | Criteria                                                 |
| ----- | -------------------------------------------------------- |
| 0%    | No discussion of priorities with user                    |
| 25%   | Presented findings, awaiting user input                  |
| 50%   | User indicated general preference                        |
| 75%   | User confirmed which specific improvements matter most   |
| 100%  | Explicit priority ranking with user-confirmed exclusions |

### Trade-offs Discussed (0-100%)

| Score | Criteria                                                   |
| ----- | ---------------------------------------------------------- |
| 0%    | Trade-offs not considered or presented                     |
| 25%   | Aware trade-offs exist, not discussed with user            |
| 50%   | Main trade-offs presented to user                          |
| 75%   | User acknowledged trade-offs, indicated acceptance         |
| 100%  | All significant trade-offs explicitly confirmed acceptable |

### User Alignment (0-100%)

| Score | Criteria                                                     |
| ----- | ------------------------------------------------------------ |
| 0%    | No confirmation questions asked                              |
| 25%   | Questions asked, awaiting response                           |
| 50%   | Basic understanding confirmed                                |
| 75%   | Key decisions and direction confirmed by user                |
| 100%  | Complete alignment on analysis scope, findings, and approach |

## Minimum Thresholds for HIGH (80+)

To reach HIGH confidence, these minimums must be met:

- Goals Understood >= 70%
- Codebase Explored >= 60%
- Opportunities Found >= 50%
- Priorities Confirmed >= 50%
- Trade-offs Discussed >= 40%
- User Alignment >= 50%

If weighted score is 80+ but minimums not met, continue iterating.

## Impact/Effort Matrix

For each improvement opportunity, score on two dimensions to prioritize:

### Impact Scoring

| Score | Level     | Criteria                                             |
| ----- | --------- | ---------------------------------------------------- |
| 4     | Critical  | Affects performance, security, or core functionality |
| 3     | Important | Improves maintainability or prevents future issues   |
| 2     | Moderate  | Nice improvement but not essential                   |
| 1     | Minor     | Cosmetic, style-only, or marginal benefit            |

### Effort Scoring

| Score | Level     | Criteria                                      |
| ----- | --------- | --------------------------------------------- |
| 4     | Low       | < 1 hour, localized change, minimal risk      |
| 3     | Medium    | 1-4 hours, touches few files, low risk        |
| 2     | High      | Day+ work, architectural considerations       |
| 1     | Very High | Multi-day, significant refactoring, high risk |

### Priority Calculation

**Priority = Impact + Effort** (higher is better, max 8)

| Priority | Action                |
| -------- | --------------------- |
| 7-8      | Do first (quick wins) |
| 5-6      | Plan for soon         |
| 3-4      | Consider if time      |
| 1-2      | Defer or skip         |

### Example Priority Table

| Finding                | Impact | Effort | Priority | Recommendation   |
| ---------------------- | ------ | ------ | -------- | ---------------- |
| N+1 query in user list | 4      | 3      | 7        | Do first         |
| Add type annotations   | 2      | 4      | 6        | Plan for soon    |
| Refactor auth module   | 4      | 1      | 5        | Plan for soon    |
| Rename variables       | 1      | 4      | 5        | Consider if time |
| Extract microservice   | 3      | 1      | 4        | Defer            |

## Quality Characteristic Hierarchy (ISO 25010)

Organize findings by these standard software quality characteristics:

### 1. Performance Efficiency

How well does it use resources?

- **Time Behavior** - Response times, throughput rates
- **Resource Utilization** - CPU, memory, storage, network efficiency
- **Capacity** - Maximum limits and scalability

### 2. Reliability

How dependable is it?

- **Maturity** - Frequency of failures under normal operation
- **Availability** - System uptime and accessibility
- **Fault Tolerance** - Graceful handling of failures
- **Recoverability** - Ability to recover state after failure

### 3. Security

How protected is it?

- **Confidentiality** - Data accessible only to authorized users
- **Integrity** - Data accuracy and consistency
- **Non-repudiation** - Actions can be proven to have occurred
- **Accountability** - Actions can be traced to entities
- **Authenticity** - Identity verification

### 4. Maintainability

How easy is it to modify?

- **Modularity** - Components can be changed independently
- **Reusability** - Assets usable in multiple systems
- **Analysability** - Ease of diagnosing problems
- **Modifiability** - Ease of making changes
- **Testability** - Ease of establishing test criteria

### 5. Compatibility

How well does it work with others?

- **Co-existence** - Works alongside other systems
- **Interoperability** - Exchanges and uses information with other systems

### 6. Portability

How easily can it be transferred?

- **Adaptability** - Can be adapted for different environments
- **Installability** - Ease of installation
- **Replaceability** - Can replace another component

### Using the Hierarchy

Present findings grouped by these categories:

```markdown
### Findings by Quality Characteristic

#### Performance Efficiency (2 findings)

| Finding                   | Impact    | Effort | Priority |
| ------------------------- | --------- | ------ | -------- |
| N+1 query pattern         | Critical  | Medium | 7        |
| Unoptimized image loading | Important | Low    | 7        |

#### Maintainability (3 findings)

| Finding                  | Impact    | Effort | Priority |
| ------------------------ | --------- | ------ | -------- |
| God class in UserService | Important | High   | 5        |
| Missing type annotations | Moderate  | Low    | 6        |
| Code duplication         | Moderate  | Medium | 5        |

#### Security (1 finding)

| Finding            | Impact   | Effort | Priority |
| ------------------ | -------- | ------ | -------- |
| SQL injection risk | Critical | Medium | 7        |
```

## Common Improvement Patterns Reference

### God Class

**Symptoms:** Large class (>500 lines), many responsibilities, low cohesion, "knows too much"

**Impact:** Critical for maintainability - changes ripple unpredictably

**Detection:**

- Class has 10+ methods across different domains
- Constructor takes many unrelated dependencies
- Methods don't share much state

**Typical Solution:** Split into focused, single-responsibility classes

### Feature Envy

**Symptoms:** Method uses data from another class more than its own

**Impact:** Important - indicates misplaced logic

**Detection:**

- Method makes many calls to getters/methods of another object
- More external references than internal ones

**Typical Solution:** Move method to the class whose data it uses

### Long Method

**Symptoms:** Method > 20-30 lines, multiple levels of abstraction, hard to name

**Impact:** Moderate - reduces readability and testability

**Detection:**

- Method has multiple sections doing different things
- Comments explaining "sections" of the method
- Deeply nested conditionals/loops

**Typical Solution:** Extract helper methods with descriptive names

### Data Class

**Symptoms:** Class with only getters/setters, no behavior

**Impact:** Moderate - missed encapsulation opportunity

**Detection:**

- Class is essentially a struct
- Behavior that should belong to it is elsewhere

**Typical Solution:** Move behavior into the class, or convert to record/interface if truly passive

### N+1 Query

**Symptoms:** Loop making individual database calls, performance degrades with data size

**Impact:** Critical for performance - O(n) queries instead of O(1)

**Detection:**

- Database calls inside loops
- Lazy loading without batching
- Performance tests show linear query count growth

**Typical Solution:** Batch queries, eager loading, query optimization

### Premature Abstraction

**Symptoms:** Complex abstractions for single use case, "just in case" flexibility

**Impact:** Moderate - adds complexity without benefit

**Detection:**

- Interface with single implementation
- Abstract class with no meaningful inheritance
- Over-parameterized for current needs

**Typical Solution:** Inline until real need emerges (Rule of Three)

### Missing Abstraction

**Symptoms:** Duplicate code across 3+ locations, shotgun surgery on changes

**Impact:** Important - maintenance burden compounds

**Detection:**

- Same pattern repeated multiple times
- Changes require editing multiple files identically
- Copy-paste evidence in commit history

**Typical Solution:** Extract shared utility, component, or service

### Inconsistent Naming

**Symptoms:** Similar concepts named differently, confusion about terminology

**Impact:** Minor but cumulative - mental overhead

**Detection:**

- `user`, `customer`, `client`, `account` used interchangeably
- `get`, `fetch`, `retrieve`, `load` for same operation
- Snake_case mixed with camelCase

**Typical Solution:** Establish ubiquitous language, apply consistently

### Dead Code

**Symptoms:** Unused imports, unreachable branches, commented-out code

**Impact:** Minor - clutter and confusion

**Detection:**

- IDE warnings about unused symbols
- Coverage reports showing untouched code
- `// TODO: remove this` comments

**Typical Solution:** Delete it. Version control has history if needed.

### Magic Numbers/Strings

**Symptoms:** Hard-coded values with no explanation, scattered throughout code

**Impact:** Moderate - maintenance risk and mystery

**Detection:**

- Literal values in conditionals (`if (status === 3)`)
- Repeated string literals (`"admin"` in multiple places)
- Business logic hidden in constants

**Typical Solution:** Extract to named constants or configuration

## Analysis Phases

### Phase 1: Initial Understanding (~15/100 INITIAL)

Gather complete information about what needs improvement.

```
User: Can you improve this API?

You: I'll help analyze this for improvements. First, let me understand what you're looking for.

### Analysis Progress: 15/100 (INITIAL)

| Factor               | Score | Note                    |
| -------------------- | ----- | ----------------------- |
| Goals Understood     | 25%   | General area identified |
| Codebase Explored    | 0%    | Not started             |
| Opportunities Found  | 0%    | Not started             |
| Priorities Confirmed | 0%    | Not discussed           |
| Trade-offs Discussed | 0%    | Not discussed           |
| User Alignment       | 20%   | Initial request only    |

**To increase confidence:** Clarify improvement goals and constraints.

[Use AskUserQuestion:]
- What aspect of the API do you want to improve? (performance, readability, security, maintainability)
- Why is this improvement needed now? Is something not working, or is this proactive?
- What constraints should I know about? (Can't change X, must maintain Y)
```

**Questions to ask:**

- What exactly should be improved?
- Why now? What motivated this?
- What does success look like?
- What cannot be changed?

### Phase 2: Code Exploration (~40/100 DEVELOPING)

Based on understanding, explore the target area systematically using the Walkthrough Protocol.

```
[After Phase 1 questions answered]

You: Now I'll explore the code using the Walkthrough Protocol.

### Analysis Progress: 40/100 (DEVELOPING)

| Factor               | Score | Note                                |
| -------------------- | ----- | ----------------------------------- |
| Goals Understood     | 80%   | Improve API performance, slow calls |
| Codebase Explored    | 50%   | Key files examined                  |
| Opportunities Found  | 30%   | Initial findings                    |
| Priorities Confirmed | 0%    | Awaiting findings                   |
| Trade-offs Discussed | 0%    | Not yet                             |
| User Alignment       | 50%   | Goals confirmed                     |

**To increase confidence:** Complete exploration, identify opportunities.

### Walkthrough: API Module

Let me walk through what this code does:

1. `src/api/users.ts` handles user-related endpoints
2. The `getUsers` function queries the database with a WHERE clause
3. For each user, it then fetches their preferences in a loop...
4. **Wait - this is an N+1 query pattern.**

[Continue exploration, document findings]
```

### Phase 3: Deep Analysis Questions (~60/100 SOLID)

Present initial findings with Impact/Effort scores and ask for prioritization.

```
### Analysis Progress: 60/100 (SOLID)

| Factor               | Score | Note                           |
| -------------------- | ----- | ------------------------------ |
| Goals Understood     | 85%   | Clear goals                    |
| Codebase Explored    | 75%   | 12 files examined              |
| Opportunities Found  | 60%   | 8 opportunities identified     |
| Priorities Confirmed | 30%   | Awaiting user input            |
| Trade-offs Discussed | 20%   | Some identified                |
| User Alignment       | 65%   | Direction confirmed            |

**To increase confidence:** Confirm priorities, discuss trade-offs.

### Initial Findings by Category

#### Performance Efficiency (3 findings)

| Finding            | Impact   | Effort | Priority | Location           |
| ------------------ | -------- | ------ | -------- | ------------------ |
| N+1 query pattern  | Critical | Medium | 7        | `users.ts:45`      |
| Missing pagination | Important| Low    | 7        | `list.ts:23`       |
| Sync file I/O      | Moderate | Medium | 5        | `export.ts:89`     |

#### Maintainability (3 findings)

| Finding              | Impact   | Effort | Priority | Location           |
| -------------------- | -------- | ------ | -------- | ------------------ |
| God class UserService| Important| High   | 5        | `UserService.ts`   |
| Missing types        | Moderate | Low    | 6        | Multiple files     |
| Code duplication     | Moderate | Medium | 5        | `handlers/*.ts`    |

### Trade-offs Identified

- Fixing N+1 query would change the data fetching pattern, may affect caching
- Splitting UserService requires refactoring consumers

[Use AskUserQuestion:]
- Which improvement category should we prioritize? (Performance, Maintainability, Both equally)
- The N+1 fix would change data loading. Is this acceptable?
- Should I also look at related modules that may have similar issues?
```

### Phase 4: Validation Exploration (~80/100 HIGH)

Validate findings against user priorities, look for anything missed.

```
### Analysis Progress: 78/100 (HIGH)

| Factor               | Score | Note                               |
| -------------------- | ----- | ---------------------------------- |
| Goals Understood     | 90%   | Fully clear                        |
| Codebase Explored    | 80%   | Second pass complete               |
| Opportunities Found  | 75%   | Validated against priorities       |
| Priorities Confirmed | 80%   | User confirmed: performance first  |
| Trade-offs Discussed | 65%   | Major trade-offs accepted          |
| User Alignment       | 80%   | Strong alignment                   |

**To increase confidence:** Complete trade-off discussion.

### Validation Results

After validating against your priorities, here's the refined list:

#### Priority 1: Performance (Quick Wins)
1. N+1 query fix - Priority 7 ✓ Confirmed
2. Missing pagination - Priority 7 ✓ Confirmed

#### Priority 2: Maintainability (Next Sprint)
1. Missing types - Priority 6 ✓ Confirmed
2. Code duplication - Priority 5 (deferred per user)

### New Discovery During Validation

While validating the N+1 fix location, I found the query pattern is used by 3 other handlers.
Fixing at the root (shared repository method) would improve all of them.

[Use AskUserQuestion:]
- Should I expand scope to fix at the root level?
- Trade-off: Broader change, but fixes 4 places at once
```

**If validation reveals new information:** Loop back to Phase 3 and ask new questions.

### Phase 5: Present Findings (~85/100 READY)

Only present final findings when all minimum thresholds are met.

```
### Analysis Progress: 86/100 (HIGH)

| Factor               | Score | Note                              |
| -------------------- | ----- | --------------------------------- |
| Goals Understood     | 95%   | Explicit and confirmed            |
| Codebase Explored    | 85%   | Comprehensive coverage            |
| Opportunities Found  | 80%   | Prioritized list complete         |
| Priorities Confirmed | 90%   | User-validated priorities         |
| Trade-offs Discussed | 75%   | All major trade-offs accepted     |
| User Alignment       | 85%   | Strong alignment                  |

### Threshold Check for HIGH

- [x] Goals Understood >= 70% (Current: 95% - Met)
- [x] Codebase Explored >= 60% (Current: 85% - Met)
- [x] Opportunities Found >= 50% (Current: 80% - Met)
- [x] Priorities Confirmed >= 50% (Current: 90% - Met)
- [x] Trade-offs Discussed >= 40% (Current: 75% - Met)
- [x] User Alignment >= 50% (Current: 85% - Met)

**Status:** All HIGH thresholds met. Ready to present findings.

## Analysis Complete

### Summary

Analyzed API handlers in `src/api/` focusing on performance improvements as requested.
Found 6 actionable improvements across 2 categories, prioritized by impact and effort.

### Findings by Priority

#### Do First (Priority 7-8)

| # | Finding            | Category    | Impact   | Effort | Location      |
| - | ------------------ | ----------- | -------- | ------ | ------------- |
| 1 | N+1 query pattern  | Performance | Critical | Medium | `users.ts:45` |
| 2 | Missing pagination | Performance | Important| Low    | `list.ts:23`  |

#### Plan for Soon (Priority 5-6)

| # | Finding            | Category       | Impact   | Effort | Location          |
| - | ------------------ | -------------- | -------- | ------ | ----------------- |
| 3 | Missing types      | Maintainability| Moderate | Low    | Multiple files    |
| 4 | Sync file I/O      | Performance    | Moderate | Medium | `export.ts:89`    |

#### Deferred (Per User Request)

| # | Finding            | Category       | Impact   | Effort | Reason        |
| - | ------------------ | -------------- | -------- | ------ | ------------- |
| 5 | God class split    | Maintainability| Important| High   | Next quarter  |
| 6 | Code duplication   | Maintainability| Moderate | Medium | Low priority  |

### Trade-offs Acknowledged

- N+1 fix changes data loading pattern (accepted)
- Root-level fix affects 4 handlers (accepted - preferred)
- God class refactor deferred to next quarter

### Out of Scope

- Database schema changes (constraint)
- UI/frontend code (not in scope)
- Third-party API integrations (separate analysis needed)

### Next Steps

[Use AskUserQuestion:]
- Would you like me to create an implementation plan?
- Options: Yes (full plan), Yes (selected items), No (analysis only)
```

## Tool Selection

Choose the right tool for each analysis step:

| Tool                   | Use When                                             |
| ---------------------- | ---------------------------------------------------- |
| **Grep**               | Finding patterns, counting usage, consistency checks |
| **Glob**               | Locating file types, finding naming conventions      |
| **Read**               | Understanding context, examining implementations     |
| **LSP findReferences** | Checking usage before suggesting changes             |
| **LSP incomingCalls**  | Understanding who depends on a component             |
| **LSP documentSymbol** | Getting overview of file structure                   |

### Tool Selection Decision Tree

```
What are you trying to understand?
├── File structure/naming → Glob
├── Where is X used? → LSP findReferences
├── What calls this? → LSP incomingCalls
├── How does this work? → Read (with Walkthrough Protocol)
└── Are there patterns? → Grep
```

## Escape Hatches

If user wants findings before reaching HIGH confidence:

```
User: Just show me what you've found

You: Current confidence is 58/100 (SOLID). I can present findings now, but note these gaps:

### Preliminary Analysis

**Confidence Gaps:**
- Trade-offs not fully discussed (some recommendations may have hidden costs)
- Validation pass incomplete (may miss related issues)

### Findings (Preliminary)

[Present current findings with "Preliminary" label]

| Finding           | Confidence | Note                    |
| ----------------- | ---------- | ----------------------- |
| N+1 query pattern | High       | Validated               |
| Missing types     | Medium     | Not fully scoped        |
| God class split   | Low        | Trade-offs not discussed|

**Recommendation:** Continue analysis to reach HIGH confidence, or confirm you want to proceed with these preliminary findings.
```

Mark unvalidated findings as "Preliminary" or "Needs Validation" in the output.

## Question Guidelines

### When to Use AskUserQuestion

Use the `AskUserQuestion` tool when:

- There are 2-4 clear options to choose from
- User preference matters for the decision
- You need to validate an assumption
- Prioritization input is needed

### Example AskUserQuestion Structures

**Priority confirmation:**

```json
{
  "questions": [
    {
      "question": "Which improvement category should we focus on first?",
      "header": "Priority",
      "options": [
        {
          "label": "Performance",
          "description": "Speed and efficiency improvements"
        },
        {
          "label": "Maintainability",
          "description": "Code quality and readability"
        },
        { "label": "Security", "description": "Vulnerability fixes" },
        {
          "label": "All equally",
          "description": "Don't prioritize, address everything"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Trade-off acceptance:**

```json
{
  "questions": [
    {
      "question": "The N+1 fix would change the data loading pattern. Is this acceptable?",
      "header": "Trade-off",
      "options": [
        {
          "label": "Yes, proceed",
          "description": "I understand and accept this change"
        },
        {
          "label": "No, find alternative",
          "description": "Look for a less disruptive approach"
        },
        {
          "label": "Need more info",
          "description": "Explain the impact in more detail"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Scope decision:**

```json
{
  "questions": [
    {
      "question": "Should I expand analysis to related modules?",
      "header": "Scope",
      "options": [
        {
          "label": "Yes, expand",
          "description": "Check related code for similar issues"
        },
        {
          "label": "No, stay focused",
          "description": "Keep scope to current target"
        },
        {
          "label": "Later",
          "description": "Complete current analysis first, then decide"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

**Next steps:**

```json
{
  "questions": [
    {
      "question": "Would you like me to create an implementation plan for these improvements?",
      "header": "Next Step",
      "options": [
        {
          "label": "Yes, full plan",
          "description": "Create plan for all findings"
        },
        { "label": "Yes, selected", "description": "I'll specify which items" },
        {
          "label": "No, analysis only",
          "description": "I just needed the analysis"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

### Question Frequency

- Ask 2-4 questions per round (don't overwhelm)
- Ask after every major analysis action
- Always ask before presenting final findings

## Anti-Patterns to Avoid

**Don't:**

- Present findings without understanding user's priorities
- Assume all improvements are equally wanted
- Skip the Walkthrough Protocol
- Skip validation exploration
- Present overwhelming lists without prioritization
- Make recommendations without knowing constraints
- Stop at initial findings without user confirmation
- Propose changes without discussing trade-offs

**Do:**

- Use the Walkthrough Protocol before identifying improvements
- Ask questions after every analysis action
- Score findings on Impact/Effort for prioritization
- Validate findings before presenting final results
- Group by ISO 25010 quality characteristics
- Include priority score for each finding
- Confirm priorities and trade-offs explicitly
- Ask if user wants implementation plan

## Iteration Loop

The analysis process is iterative:

```
1. Understand goals → Ask questions → Confirm understanding
2. Explore code (Walkthrough) → Present initial findings → Ask questions
3. Score Impact/Effort → Discuss priorities → Ask about trade-offs → Confirm direction
4. Validate findings → New discoveries? → Loop back to questions
5. All thresholds met → Present final findings → Ask about next steps
```

Remember: **Thorough analysis prevents wasted effort on unwanted changes. Confidence comes from iteration.**
