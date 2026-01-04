---
name: thorough-analysis
description: Enables thorough, question-driven analysis for improvements. Triggers when users want to improve, optimize, refactor, or enhance code. Iteratively investigates with frequent confirmation questions until confident in recommendations.
---

# Thorough Analysis Skill

When analyzing any code, feature, or system for potential improvements, follow this iterative, question-driven approach.

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

**Analyze iteratively. Confirm frequently. Validate before concluding.**

After EVERY analysis step, ask 2-3 questions to confirm your findings and priorities before moving forward. Keep analyzing until you reach HIGH confidence in your recommendations.

## Confidence Milestones System

Analysis uses milestone-based confidence rather than numeric scores. Track these milestones throughout the investigation:

### Milestone Checklist

| Milestone                | Description                                              | Required Questions                                    |
| ------------------------ | -------------------------------------------------------- | ----------------------------------------------------- |
| Goals Understood         | Know what user wants to improve and why                  | Goals, motivation, success criteria                   |
| Constraints Clear        | Know what cannot change, dependencies, requirements      | Boundaries, dependencies, non-negotiables             |
| Code Explored (Initial)  | First pass through target area complete                  | N/A (exploration)                                     |
| Priorities Confirmed     | User validated which improvements matter most            | Priority ranking, explicit exclusions                 |
| Trade-offs Discussed     | User aware of and accepts necessary trade-offs           | Trade-off acceptance, risk tolerance                  |
| Findings Validated       | Second exploration confirmed initial analysis            | N/A (validation exploration)                          |
| Ready to Present         | All above milestones achieved                            | Final confirmation before presenting                  |

### Milestone Display Format

Display at **every analysis step**:

```markdown
### Analysis Progress

- [x] Goals Understood - User wants to improve API response times
- [x] Constraints Clear - Cannot change database schema
- [x] Code Explored (Initial) - Examined 8 handler files
- [ ] Priorities Confirmed - Awaiting user input
- [ ] Trade-offs Discussed
- [ ] Findings Validated
- [ ] Ready to Present

**Current Phase:** Deep Analysis Questions
**Next Milestone:** Priorities Confirmed
```

### Minimum Requirements for "Ready to Present"

All of the following must be checked:

- [x] Goals Understood
- [x] Constraints Clear
- [x] Code Explored (Initial)
- [x] Priorities Confirmed
- [x] Trade-offs Discussed
- [x] Findings Validated

If any milestone is unchecked, continue the analysis process.

## Analysis Phases

### Phase 1: Initial Understanding

Gather complete information about what needs improvement.

```
User: Can you improve this API?

You: I'll help analyze this for improvements. First, let me understand what you're looking for.

### Analysis Progress
- [ ] Goals Understood
- [ ] Constraints Clear
- [ ] Code Explored (Initial)
- [ ] Priorities Confirmed
- [ ] Trade-offs Discussed
- [ ] Findings Validated
- [ ] Ready to Present

**Current Phase:** Initial Understanding

[Use AskUserQuestion with questions like:]
- What aspect of the API do you want to improve? (performance, readability, error handling, security)
- Why is this improvement needed now? Is something not working, or is this proactive?
- Are there specific parts that concern you, or should I analyze everything?
- What constraints should I know about? (Can't change X, must maintain Y)
```

**Questions to ask:**

- What exactly should be improved?
- Why now? What motivated this?
- What does success look like?
- What cannot be changed?

**Confidence Checkpoint:** Self-assess whether you understand the goals. If uncertain, ask more questions. Then confirm: "Do I understand your improvement goals correctly?"

### Phase 2: Initial Code Exploration

Based on understanding, explore the target area systematically.

```
[After Phase 1 questions answered]

You: Now I'll explore the code to understand its current state.

### Analysis Progress
- [x] Goals Understood - Improve API performance, specifically slow endpoints
- [x] Constraints Clear - Database schema is fixed, can't add caching layer
- [ ] Code Explored (Initial)
- [ ] Priorities Confirmed
- [ ] Trade-offs Discussed
- [ ] Findings Validated
- [ ] Ready to Present

**Current Phase:** Initial Code Exploration

[Explore files, patterns, identify improvement opportunities]
```

After exploration, present initial findings:

```
### Initial Findings

After examining the codebase, I found several areas that could be improved:

1. **Database Queries (Performance)**
   - File: `src/api/users.ts:45`
   - N+1 query pattern in user listing
   - Impact: Likely significant for performance

2. **Error Handling (Reliability)**
   - File: `src/api/handlers.ts:78-92`
   - Inconsistent error responses
   - Impact: Moderate for API consumers

3. **Code Duplication (Maintainability)**
   - Files: Multiple handlers
   - Repeated validation logic
   - Impact: Lower priority but would improve maintainability

Before I continue, I want to make sure I'm focusing on what matters to you.
```

### Phase 3: Deep Analysis Questions (Iterative)

After exploration, ask questions to prioritize and understand trade-offs.

```
### Analysis Progress
- [x] Goals Understood
- [x] Constraints Clear
- [x] Code Explored (Initial) - Found 7 improvement opportunities
- [ ] Priorities Confirmed - Need user input
- [ ] Trade-offs Discussed
- [ ] Findings Validated
- [ ] Ready to Present

**Current Phase:** Deep Analysis Questions

[Use AskUserQuestion:]
- Which of these improvement areas matter most? (Performance, Error Handling, Code Quality)
- I found the N+1 query could be fixed by restructuring the data fetching. This would change the handler interface. Is that acceptable?
- Should I also look at related handlers that might have similar issues?
```

**Questions to ask:**

- Priority: "Which improvements matter most?"
- Trade-offs: "Fixing X would require changing Y. Acceptable?"
- Scope: "Should I look at related areas?"
- Risk: "How conservative should recommendations be?"

**Confidence Checkpoint:** Self-assess whether priorities are clear. If not, ask more questions. Then confirm: "Does this analysis direction make sense?"

### Phase 4: Validation Exploration

Before presenting final findings, explore again to validate.

```
### Analysis Progress
- [x] Goals Understood
- [x] Constraints Clear
- [x] Code Explored (Initial)
- [x] Priorities Confirmed - Focus on performance, then error handling
- [x] Trade-offs Discussed - Handler interface changes acceptable
- [ ] Findings Validated - Verifying findings now
- [ ] Ready to Present

**Current Phase:** Validation Exploration

I'm now verifying my initial findings and checking for anything I might have missed...

[Explore more deeply, verify assumptions, look for edge cases]
```

**If validation reveals new information:**

Loop back to Phase 3 and ask new questions:

```
While validating, I discovered something new:

The N+1 query issue is actually caused by a shared utility function used by 5 other handlers.
Fixing it would improve all of them, but requires more extensive changes.

[Use AskUserQuestion:]
- Should I expand the scope to fix this at the root, or just patch it in the original handler?
```

### Phase 5: Present Findings

Only present final findings when all milestones are achieved.

```
### Analysis Progress
- [x] Goals Understood
- [x] Constraints Clear
- [x] Code Explored (Initial)
- [x] Priorities Confirmed
- [x] Trade-offs Discussed
- [x] Findings Validated
- [x] Ready to Present

## Analysis Complete

### Summary

Analyzed the API handlers in `src/api/` focusing on performance improvements as requested.
Found 5 actionable improvements across 2 categories.

### Findings by Category

#### Performance (High Priority per User)

| Finding | Impact | Location | Suggestion |
|---------|--------|----------|------------|
| N+1 query pattern | Critical | `users.ts:45` | Batch queries using `getMany()` |
| Unnecessary serialization | Important | `handlers.ts:23` | Move serialization to response layer |
| Missing query indexes | Important | N/A | Add indexes on `user_id`, `created_at` |

#### Error Handling (Medium Priority per User)

| Finding | Impact | Location | Suggestion |
|---------|--------|----------|------------|
| Inconsistent error format | Important | Multiple files | Standardize with error factory |
| Missing error boundaries | Nice-to-have | `handlers.ts` | Add try-catch wrapper |

### Trade-offs Acknowledged

- Handler interface changes are acceptable (confirmed Phase 3)
- Will address root cause in shared utility (confirmed Phase 4)

### Out of Scope

- Database schema changes (constraint)
- Caching layer (constraint)
- Code duplication in non-performance paths (deprioritized by user)

### Next Steps

Would you like me to create an implementation plan for these improvements?
```

Use `AskUserQuestion` to ask about next steps:

```json
{
  "questions": [
    {
      "question": "Would you like me to create an implementation plan?",
      "header": "Next Step",
      "options": [
        { "label": "Yes, full plan", "description": "Create implementation plan for all findings" },
        { "label": "Yes, selected items", "description": "I'll tell you which ones" },
        { "label": "No, analysis only", "description": "I just needed the analysis" }
      ],
      "multiSelect": false
    }
  ]
}
```

## Structured Output Format

Use this format throughout analysis:

```markdown
## Current Analysis Status

### Analysis Progress

- [x/blank] Goals Understood - [brief note if checked]
- [x/blank] Constraints Clear - [brief note if checked]
- [x/blank] Code Explored (Initial)
- [x/blank] Priorities Confirmed
- [x/blank] Trade-offs Discussed
- [x/blank] Findings Validated
- [x/blank] Ready to Present

**Current Phase:** [Phase name]
**Next Milestone:** [What needs to be achieved next]

### Current Findings

[What you've discovered so far, grouped by category]

### Areas Under Investigation

[What you're currently looking at]

### Questions

[AskUserQuestion or conversational questions]
```

## Category Examples

Categories should emerge from the analysis. Common ones include:

- **Performance** - Speed, efficiency, resource usage
- **Readability** - Code clarity, naming, structure
- **Maintainability** - Modularity, coupling, technical debt
- **Error Handling** - Failure modes, recovery, user feedback
- **Security** - Vulnerabilities, input validation, access control
- **Testability** - Test coverage, testable design
- **Architecture** - Patterns, separation of concerns, scalability
- **Documentation** - Comments, API docs, README

Use what's relevant to the analysis, not all of them.

## Question Guidelines

**Always use AskUserQuestion after:**

- Initial understanding gathering (Phase 1)
- Presenting initial findings (after Phase 2)
- Discovering trade-offs (Phase 3)
- Finding new information during validation (Phase 4)
- Before presenting final findings (Phase 5)

**Good analysis questions:**

- Specific: "Should we prioritize the N+1 fix or the error handling?"
- Validating: "Does this finding match what you've observed?"
- Prioritizing: "Of these 5 issues, which matter most?"
- Trade-off: "Fixing this would require X. Is that acceptable?"

**Example AskUserQuestion structure:**

```json
{
  "questions": [
    {
      "question": "Which improvement category should we focus on first?",
      "header": "Focus Area",
      "options": [
        { "label": "Performance", "description": "Speed and efficiency" },
        { "label": "Code Quality", "description": "Readability and maintainability" },
        { "label": "Reliability", "description": "Error handling and edge cases" },
        { "label": "All equally", "description": "Don't prioritize, analyze everything" }
      ],
      "multiSelect": false
    },
    {
      "question": "How extensive should improvements be?",
      "header": "Scope",
      "options": [
        { "label": "Minimal changes", "description": "Quick wins, low risk" },
        { "label": "Moderate refactoring", "description": "Willing to restructure some code" },
        { "label": "Comprehensive", "description": "Open to significant changes if warranted" }
      ],
      "multiSelect": false
    }
  ]
}
```

## Anti-Patterns to Avoid

**Don't:**

- Present findings without understanding user's priorities
- Assume all improvements are equally wanted
- Skip validation exploration
- Present overwhelming lists without categorization
- Make recommendations without knowing constraints
- Stop at initial findings without user confirmation

**Do:**

- Ask questions after every analysis action
- Validate findings before presenting final results
- Group by meaningful, emergent categories
- Include impact level for each finding
- Confirm priorities and trade-offs explicitly
- Ask if user wants implementation plan

## Iteration Loop

The analysis process is iterative:

```
1. Understand goals → Ask questions → Confirm understanding
2. Explore code → Present initial findings → Ask questions
3. Discuss priorities → Ask about trade-offs → Confirm direction
4. Validate findings → New discoveries? → Loop back to questions
5. All milestones checked → Present final findings → Ask about next steps
```

Remember: **Thorough analysis prevents wasted effort on unwanted changes. Understanding comes from questions.**
