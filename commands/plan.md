---
description: Start enhanced planning with thorough questioning. Uses iterative confidence metrics to deeply understand requirements before planning implementation.
---

# Enhanced Planning Mode

You are now in enhanced planning mode. Your goal is to achieve **high confidence** in your understanding before presenting an implementation plan.

## Core Principle

**Iterate until confident. Ask, explore, validate, repeat.**

Planning is an iterative process. Keep gathering information, asking questions, and validating understanding until you reach HIGH confidence (80+). Only then present the plan.

## Confidence Metrics System

Calculate and display confidence using this weighted formula:

```
PlanConfidence = (Intent × 0.25) + (Context × 0.20) + (Requirements × 0.15) +
                 (Solution × 0.20) + (Risk × 0.10) + (Alignment × 0.10)
```

### Factor Weights

| Factor                   | Weight | Description                                        |
| ------------------------ | ------ | -------------------------------------------------- |
| Intent Clarity           | 25%    | How well you understand what the user wants        |
| Context Completeness     | 20%    | How much relevant codebase context you've gathered |
| Requirements Specificity | 15%    | Clarity of scope, constraints, and edge cases      |
| Solution Viability       | 20%    | Confidence the proposed approach will work         |
| Risk Assessment          | 10%    | How well you've identified potential issues        |
| User Alignment           | 10%    | User confirmations received during planning        |

### Confidence Levels

| Level          | Score  | Description                                  |
| -------------- | ------ | -------------------------------------------- |
| **INITIAL**    | 0-24   | Just starting, gathering basic information   |
| **DEVELOPING** | 25-49  | Some understanding, many gaps remain         |
| **SOLID**      | 50-74  | Good understanding, validating approach      |
| **HIGH**       | 75-89  | Strong understanding, ready to present plan  |
| **READY**      | 90-100 | Complete understanding, high confidence plan |

**Target:** Reach HIGH confidence (80+) before presenting the plan.

## Factor Measurement Criteria

### Intent Clarity (0-100%)

| Score | Criteria                                                  |
| ----- | --------------------------------------------------------- |
| 0%    | User request is vague or unclear                          |
| 25%   | General idea understood, specifics unclear                |
| 50%   | Core goal understood, some ambiguity remains              |
| 75%   | Clear understanding of what user wants                    |
| 100%  | Explicit, confirmed understanding of goals and motivation |

### Context Completeness (0-100%)

| Score | Criteria                                           |
| ----- | -------------------------------------------------- |
| 0%    | No codebase exploration yet                        |
| 25%   | Basic project structure understood                 |
| 50%   | Key files and patterns identified                  |
| 75%   | Relevant code thoroughly examined                  |
| 100%  | All affected areas mapped, dependencies understood |

### Requirements Specificity (0-100%)

| Score | Criteria                                                  |
| ----- | --------------------------------------------------------- |
| 0%    | Scope and constraints unknown                             |
| 25%   | Basic scope defined                                       |
| 50%   | Scope clear, some constraints identified                  |
| 75%   | Clear scope, constraints, and main edge cases             |
| 100%  | Comprehensive requirements with all edge cases documented |

### Solution Viability (0-100%)

| Score | Criteria                                       |
| ----- | ---------------------------------------------- |
| 0%    | No approach identified                         |
| 25%   | General direction known                        |
| 50%   | Approach identified, feasibility uncertain     |
| 75%   | Validated approach with evidence from codebase |
| 100%  | Proven approach with clear implementation path |

### Risk Assessment (0-100%)

| Score | Criteria                                               |
| ----- | ------------------------------------------------------ |
| 0%    | Risks not considered                                   |
| 25%   | Aware risks exist, not enumerated                      |
| 50%   | Main risks identified                                  |
| 75%   | Risks identified with potential mitigations            |
| 100%  | Comprehensive risk analysis with mitigation strategies |

### User Alignment (0-100%)

| Score | Criteria                                                |
| ----- | ------------------------------------------------------- |
| 0%    | No confirmation questions asked                         |
| 25%   | Questions asked, awaiting response                      |
| 50%   | Basic understanding confirmed                           |
| 75%   | Key decisions confirmed by user                         |
| 100%  | All major decisions and trade-offs explicitly confirmed |

## Planning Process (Iterative)

### Iteration Loop

```
1. Assess current confidence → Display metrics
2. Identify lowest-scoring factor → Target for improvement
3. Take action (ask question, explore code, validate assumption)
4. Recalculate confidence → Display updated metrics
5. Confidence < 80%? → Return to step 2
6. Confidence >= 80% → Present plan with approval question
```

### Starting Point (~12/100 INITIAL)

When planning begins:

```markdown
### Planning Progress: 12/100 (INITIAL)

| Factor                   | Score | Note                   |
| ------------------------ | ----- | ---------------------- |
| Intent Clarity           | 20%   | Basic request received |
| Context Completeness     | 0%    | No exploration yet     |
| Requirements Specificity | 10%   | Scope unclear          |
| Solution Viability       | 0%    | No approach yet        |
| Risk Assessment          | 0%    | Not assessed           |
| User Alignment           | 10%   | Initial request only   |

**To increase confidence:** Clarify intent and understand what user wants to achieve.
```

### Mid-Planning (~55/100 SOLID)

After some iteration:

```markdown
### Planning Progress: 55/100 (SOLID)

| Factor                   | Score | Note                          |
| ------------------------ | ----- | ----------------------------- |
| Intent Clarity           | 80%   | Goals confirmed               |
| Context Completeness     | 60%   | Key files examined            |
| Requirements Specificity | 50%   | Scope defined, edge cases TBD |
| Solution Viability       | 45%   | 2 approaches identified       |
| Risk Assessment          | 30%   | Some risks noted              |
| User Alignment           | 60%   | 2 decisions confirmed         |

**To increase confidence:** Validate approach viability, identify edge cases.
```

### Ready to Present (~82/100 HIGH)

When threshold met:

```markdown
### Planning Progress: 82/100 (HIGH)

| Factor                   | Score | Note                           |
| ------------------------ | ----- | ------------------------------ |
| Intent Clarity           | 95%   | Clear, confirmed goals         |
| Context Completeness     | 80%   | All relevant code examined     |
| Requirements Specificity | 75%   | Scope + edge cases documented  |
| Solution Viability       | 85%   | Approach validated in codebase |
| Risk Assessment          | 70%   | Key risks with mitigations     |
| User Alignment           | 80%   | Major decisions confirmed      |

**Threshold met.** Ready to present implementation plan.
```

## Questioning Strategy

### Prioritize Low-Scoring Factors

Target questions at factors with lowest scores. Examples:

**Intent Clarity low?** Ask:

- What exactly needs to be built?
- What problem is this solving?
- What does success look like?

**Context Completeness low?** Explore:

- Related files and patterns
- Existing conventions
- Dependencies and affected areas

**Requirements Specificity low?** Ask:

- What's in scope vs out of scope?
- What constraints exist?
- What edge cases should we handle?

**Solution Viability low?** Explore and ask:

- What approaches are possible?
- What trade-offs exist between approaches?
- Which approach aligns with existing patterns?

**Risk Assessment low?** Consider:

- What could go wrong?
- What are the dependencies?
- What's the rollback plan?

**User Alignment low?** Confirm:

- Does this match your expectation?
- Is this the approach you prefer?
- Any concerns about this direction?

### Question Guidelines

**Use AskUserQuestion tool when:**

- There are 2-4 clear options to choose from
- User preference matters for the decision
- You need to validate an assumption

**Ask in conversation when:**

- You need open-ended explanation
- The question is highly contextual
- Multiple factors need discussion

**Limit:** 2-4 questions per round. Don't overwhelm.

## Plan Presentation

When confidence >= 80%, present the complete plan:

```markdown
## Implementation Plan

### Planning Progress: 84/100 (HIGH)

| Factor               | Score | Note |
| -------------------- | ----- | ---- |
| [Full metrics table] |       |      |

### Summary

[1-2 sentence overview of what will be built]

### Implementation Steps

1. **[Step 1 title]**
   - Files: `path/to/file.ts`
   - Changes: [description]

2. **[Step 2 title]**
   - Files: `path/to/file.ts`
   - Changes: [description]

[Continue for all steps]

### Key Decisions

| Decision     | Status    | Rationale         |
| ------------ | --------- | ----------------- |
| [Decision 1] | Confirmed | [Why this choice] |
| [Decision 2] | Assumed   | [Assumption made] |

### Risks Identified

| Risk     | Mitigation       |
| -------- | ---------------- |
| [Risk 1] | [How to address] |

### Out of Scope

- [Item 1]
- [Item 2]
```

Then ask for approval:

```json
{
  "questions": [
    {
      "question": "Ready to proceed with this implementation plan?",
      "header": "Proceed?",
      "options": [
        {
          "label": "Yes, proceed",
          "description": "Start implementing the plan"
        },
        { "label": "Revise plan", "description": "I have changes to suggest" },
        {
          "label": "More questions",
          "description": "I need to clarify something first"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

## Minimum Thresholds for HIGH (80+)

To reach HIGH confidence, these minimums must be met:

- Intent Clarity >= 70%
- Context Completeness >= 60%
- Requirements Specificity >= 50%
- Solution Viability >= 60%
- User Alignment >= 50%

If weighted score is 80+ but minimums not met, continue iterating.

## Anti-Patterns to Avoid

**Don't:**

- Present a plan before reaching 80% confidence
- Make assumptions when you could ask
- Skip code exploration
- Ask vague questions ("How should this work?")
- Overwhelm with too many questions (max 4 per round)
- Stop iterating because "it's taking too long"

**Do:**

- Show confidence metrics at every step
- Target lowest-scoring factors
- Ask specific, actionable questions
- Explore codebase to validate assumptions
- Confirm key decisions before finalizing plan
- Keep iterating until HIGH confidence

## Escape Hatches

If user wants to proceed with lower confidence:

```
User: Just give me the plan, I don't need more questions

You: Current confidence is 62/100. I can present the plan now, but note these gaps:
- Solution approach not fully validated
- Edge cases not discussed

[Present plan with confidence metrics and highlighted assumptions]
```

Mark unvalidated decisions as "Assumed" in the Key Decisions table.

## Arguments

If the user provides context with the command:

```
/plan Add user authentication with JWT
```

Use this as your starting point, but still iterate to build confidence. Initial intent clarity might start at 30-40% instead of 20%.

Remember: **A high-confidence plan prevents wasted implementation effort. Iterate until confident.**
