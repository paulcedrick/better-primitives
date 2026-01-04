---
description: Start thorough analysis for improvements. Uses iterative questioning to deeply understand what can be improved and how.
---

# Analysis Mode

You are now in analysis mode. Your goal is to **thoroughly analyze** the target area and identify meaningful improvements through iterative questioning and exploration.

## Core Principle

**Analyze deeply. Confirm constantly. Iterate until confident.**

You must ask questions after EVERY analysis step. Do not present final findings until you have HIGH confidence in your understanding and recommendations.

## Analysis Process (Iterative)

### Phase 1: Initial Understanding

Start by understanding what the user wants to improve. Use `AskUserQuestion` to clarify:

**Goals**

- What specifically do you want to improve?
- Why is this improvement needed now?
- What does success look like?

**Constraints**

- What cannot be changed?
- Are there any dependencies to preserve?
- Any performance, security, or compatibility requirements?

**Context**

- Has this been attempted before? What happened?
- Any recent changes that motivated this?
- Who will be affected by these improvements?

**Motivation**

- Is this preventing something from working?
- Is this about quality, performance, maintainability, or something else?
- How urgent is this?

Ask 2-4 questions at a time. Don't overwhelm, but be thorough.

**Confidence Checkpoint:** Before proceeding, self-assess: "Do I understand what the user wants to improve and why?" If not, ask more questions. Then confirm with user: "Do I understand your improvement goals correctly?"

### Phase 2: Initial Code Exploration

After initial understanding, explore the target area:

- Examine the current state of the code/feature
- Identify patterns and conventions in use
- Note areas that stand out for potential improvement
- Document technical constraints from current architecture

### Phase 3: Deep Analysis Questions

Based on exploration findings, use `AskUserQuestion` to clarify:

**Prioritization**

- Present discovered improvement opportunities
- Ask: Which of these matter most to you?
- Ask: Are there improvements here you explicitly don't want?

**Trade-offs**

- Present trade-offs found (e.g., "simplifying X would require changing Y")
- Ask: How do you feel about these trade-offs?
- Ask: Any trade-offs that are deal-breakers?

**Scope Boundaries**

- Ask: Should improvements stay within this area, or is broader refactoring acceptable?
- Ask: Are there related areas I should also analyze?
- Ask: What's the acceptable level of change?

**Risk Tolerance**

- Ask: How conservative should I be with recommendations?
- Ask: Are breaking changes acceptable if they improve quality?

**Confidence Checkpoint:** Before proceeding, self-assess: "Do I have a clear understanding of priorities and constraints?" If not, ask more questions. Then confirm with user: "Does this analysis direction make sense?"

### Phase 4: Validation Exploration

After deep analysis questions, explore again to:

- Validate your initial findings against user priorities
- Look for edge cases or issues you might have missed
- Check if your improvement ideas are actually feasible
- Refine your analysis based on what you discover

**If exploration reveals something that changes your analysis:**

- Loop back to Phase 3
- Ask new clarifying questions about the discovery
- Update your understanding before proceeding

### Phase 5: Final Findings + Next Steps

Only present final findings when you're confident. Include:

**Categorized Findings**

Group improvements by dynamic categories that emerge from analysis (e.g., Performance, Readability, Security, Architecture, Error Handling, etc.)

For each finding:

- What the issue/opportunity is
- Why it matters
- Severity/impact indicator (Critical, Important, Nice-to-have)
- Brief suggestion for how to address it

**Ask: Implementation Plan?**

Use `AskUserQuestion` to ask:

- "Would you like me to create an implementation plan for these improvements?"
- Options: Yes (create plan), No (analysis only), Select specific items

## Confidence System

Unlike debugging (which uses numeric scores), analysis uses milestone-based confidence:

### Confidence Milestones

| Milestone                 | Indicator                                                        |
| ------------------------- | ---------------------------------------------------------------- |
| **Goals Understood**      | User confirmed improvement objectives                            |
| **Constraints Clear**     | Know what can/cannot change                                      |
| **Code Explored**         | Examined target area thoroughly                                  |
| **Priorities Confirmed**  | User validated which improvements matter                         |
| **Trade-offs Discussed**  | User is aware of and accepts trade-offs                          |
| **Findings Validated**    | Second exploration confirmed initial analysis                    |
| **Ready to Present**      | All milestones achieved, confident in recommendations            |

Display milestones at each phase:

```markdown
### Analysis Progress

- [x] Goals Understood
- [x] Constraints Clear
- [x] Code Explored (initial)
- [ ] Priorities Confirmed
- [ ] Trade-offs Discussed
- [ ] Findings Validated
- [ ] Ready to Present

**Current Phase:** Deep Analysis Questions
```

## Output Format

### During Analysis

```markdown
## Analysis Progress

### Milestones

- [x] Goals Understood
- [x] Constraints Clear
- [ ] ...

**Current Phase:** [Phase name]

### Current Findings

[What you've discovered so far]

### Areas Under Investigation

[What you're looking at]

### Questions

[AskUserQuestion with relevant questions]
```

### Final Findings

```markdown
## Analysis Complete

### Summary

[Brief overview of the target area and key findings]

### Findings by Category

#### [Category 1: e.g., Performance]

| Finding | Impact | Suggestion |
|---------|--------|------------|
| [Issue] | Critical/Important/Nice-to-have | [Brief suggestion] |

#### [Category 2: e.g., Readability]

...

### Trade-offs Acknowledged

- [Trade-off 1 that user accepted]
- [Trade-off 2]

### Out of Scope

- [Things explicitly excluded from this analysis]

### Next Steps

[Ask if user wants implementation plan]
```

## Question Guidelines

After every analysis action, use `AskUserQuestion`:

**Good analysis questions:**

- Specific: "Should we prioritize performance or readability for this function?"
- Validating: "I found X could be improved. Does this align with your concerns?"
- Prioritizing: "These 5 areas could be improved. Which matter most?"
- Clarifying: "This change would affect Y. Is that acceptable?"

**Example AskUserQuestion structure:**

```json
{
  "questions": [
    {
      "question": "Which improvement area should we prioritize?",
      "header": "Priority",
      "options": [
        { "label": "Performance", "description": "Speed and efficiency improvements" },
        { "label": "Readability", "description": "Code clarity and maintainability" },
        { "label": "Error Handling", "description": "Better failure modes and recovery" },
        { "label": "All equally", "description": "Don't prioritize, show everything" }
      ],
      "multiSelect": false
    }
  ]
}
```

## Anti-Patterns to Avoid

**Don't:**

- Present findings without understanding user's priorities
- Assume all improvements are wanted
- Skip validation exploration
- Present overwhelming lists without categorization
- Make recommendations without understanding constraints

**Do:**

- Ask questions after every investigation action
- Validate findings before presenting
- Group by meaningful categories
- Include severity/impact for each finding
- Ask if user wants implementation plan

## Arguments

If the user provides a focus area with the command:

```
/analyze performance of the API handlers
```

Use this as your starting focus, but still ask clarifying questions in Phase 1.

Remember: **Thorough analysis prevents wasted effort on unwanted changes.**
