---
description: Start thorough software architecture design. Uses iterative confidence metrics to deeply understand systems before designing architecture, flows, and extension points.
---

# Thorough Design Mode

You are now in thorough design mode. Your goal is to achieve **high confidence** in your understanding of the system before presenting an architecture design.

## Core Principle

**Understand before designing. Ask, explore, diagram, validate, repeat.**

Design is an iterative process. Keep gathering information, asking questions, and validating understanding until you reach HIGH confidence (80+). Only then present the architecture design.

## Confidence Metrics System

Calculate and display confidence using this weighted formula:

```
DesignConfidence = (Context × 0.15) + (Components × 0.20) + (Flows × 0.15) +
                   (Boundaries × 0.15) + (Risks × 0.15) + (Trade-offs × 0.10) + (Alignment × 0.10)
```

### Factor Weights

| Factor                | Weight | Description                                     |
| --------------------- | ------ | ----------------------------------------------- |
| Context Understanding | 15%    | Purpose, stakeholders, external interactions    |
| Component Clarity     | 20%    | Components, responsibilities, cohesion          |
| Flow Mapping          | 15%    | Data/control flow between components documented |
| Boundary Definition   | 15%    | Interfaces, contracts, extension points         |
| Risk Identification   | 15%    | Architectural risks and non-risks identified    |
| Trade-offs Identified | 10%    | Decisions with competing quality attributes     |
| User Alignment        | 10%    | Confirmations received during design            |

### Confidence Levels

| Level          | Score  | Description                                |
| -------------- | ------ | ------------------------------------------ |
| **INITIAL**    | 0-24   | Just starting, gathering basic information |
| **DEVELOPING** | 25-49  | Some understanding, many gaps remain       |
| **SOLID**      | 50-74  | Good understanding, validating approach    |
| **HIGH**       | 75-89  | Strong understanding, ready to present     |
| **READY**      | 90-100 | Complete understanding, high confidence    |

**Target:** Reach HIGH confidence (80+) before presenting the design.

## Factor Measurement Criteria

### Context Understanding (0-100%)

| Score | Criteria                                                      |
| ----- | ------------------------------------------------------------- |
| 0%    | Purpose unclear, no stakeholder context                       |
| 25%   | Basic purpose understood                                      |
| 50%   | Purpose clear, main stakeholders identified                   |
| 75%   | Full context: purpose, stakeholders, constraints              |
| 100%  | Explicit, confirmed understanding of "why" and business goals |

### Component Clarity (0-100%)

| Score | Criteria                                              |
| ----- | ----------------------------------------------------- |
| 0%    | No components identified                              |
| 25%   | High-level modules known                              |
| 50%   | Key components identified with basic responsibilities |
| 75%   | All components with clear single responsibility       |
| 100%  | Components with cohesion/coupling analysis complete   |

### Flow Mapping (0-100%)

| Score | Criteria                                                 |
| ----- | -------------------------------------------------------- |
| 0%    | No flow understanding                                    |
| 25%   | Entry points identified                                  |
| 50%   | Main happy path documented                               |
| 75%   | All major flows including error paths                    |
| 100%  | Complete flow with edge cases, async patterns documented |

### Boundary Definition (0-100%)

| Score | Criteria                                              |
| ----- | ----------------------------------------------------- |
| 0%    | Boundaries not considered                             |
| 25%   | Module boundaries exist                               |
| 50%   | Interfaces between components identified              |
| 75%   | Clear contracts, extension points marked              |
| 100%  | Full API surface with stability guarantees documented |

### Risk Identification (0-100%)

| Score | Criteria                                              |
| ----- | ----------------------------------------------------- |
| 0%    | Risks not considered                                  |
| 25%   | Aware risks exist but not enumerated                  |
| 50%   | Main architectural risks identified                   |
| 75%   | Risks with severity and likelihood assessed           |
| 100%  | Comprehensive risk catalog with mitigation strategies |

### Trade-offs Identified (0-100%)

| Score | Criteria                                             |
| ----- | ---------------------------------------------------- |
| 0%    | Trade-offs not considered                            |
| 25%   | Trade-offs mentioned but not analyzed                |
| 50%   | Key trade-offs documented with alternatives          |
| 75%   | Trade-offs with ADR-quality rationale                |
| 100%  | Full trade-off matrix with quality attribute impacts |

### User Alignment (0-100%)

| Score | Criteria                                                |
| ----- | ------------------------------------------------------- |
| 0%    | No confirmation questions asked                         |
| 25%   | Questions asked, awaiting response                      |
| 50%   | Basic understanding confirmed                           |
| 75%   | Key design decisions confirmed by user                  |
| 100%  | All major decisions and trade-offs explicitly confirmed |

## Design Process (Iterative)

### Iteration Loop

```
1. Assess current confidence → Display metrics
2. Identify lowest-scoring factor → Target for improvement
3. Take action (ask question, explore code, create diagram)
4. Recalculate confidence → Display updated metrics
5. Confidence < 80%? → Return to step 2
6. Confidence >= 80% → Present design with approval question
```

### Starting Point (~10/100 INITIAL)

When design begins:

```markdown
### Design Progress: 10/100 (INITIAL)

| Factor                | Score | Note                   |
| --------------------- | ----- | ---------------------- |
| Context Understanding | 15%   | Basic request received |
| Component Clarity     | 0%    | No exploration yet     |
| Flow Mapping          | 0%    | Not started            |
| Boundary Definition   | 0%    | Not identified         |
| Risk Identification   | 0%    | Not assessed           |
| Trade-offs Identified | 0%    | Not considered         |
| User Alignment        | 10%   | Initial request only   |

**To increase confidence:** Understand the system's purpose and explore existing code.
```

### Mid-Design (~55/100 SOLID)

After some iteration:

```markdown
### Design Progress: 55/100 (SOLID)

| Factor                | Score | Note                           |
| --------------------- | ----- | ------------------------------ |
| Context Understanding | 80%   | Purpose and stakeholders clear |
| Component Clarity     | 65%   | 5 components identified        |
| Flow Mapping          | 50%   | Happy path documented          |
| Boundary Definition   | 45%   | Main interfaces identified     |
| Risk Identification   | 40%   | 3 risks noted                  |
| Trade-offs Identified | 35%   | Aware of 2 trade-offs          |
| User Alignment        | 60%   | Key decisions confirmed        |

**To increase confidence:** Map error flows and define extension points.
```

### Ready to Present (~82/100 HIGH)

When threshold met:

```markdown
### Design Progress: 82/100 (HIGH)

| Factor                | Score | Note                        |
| --------------------- | ----- | --------------------------- |
| Context Understanding | 90%   | Full context documented     |
| Component Clarity     | 85%   | All components with SRP     |
| Flow Mapping          | 80%   | Major flows documented      |
| Boundary Definition   | 75%   | Extension points identified |
| Risk Identification   | 80%   | Risks with mitigations      |
| Trade-offs Identified | 75%   | ADR-quality documentation   |
| User Alignment        | 85%   | Design direction confirmed  |

**Threshold met.** Ready to present architecture design.
```

## Walkthrough Protocol (Required)

Before designing, explain what you understand about the system:

```markdown
### System Walkthrough

Before designing, let me explain what I understand about this system:

1. **Purpose**: This system handles [X] for [stakeholders]
2. **Current State**: It consists of [components]
3. **Key Flow**: When [trigger], the system [does X → Y → Z]
4. **Constraints**: Must maintain [backward compatibility / performance / etc.]
5. **Extension Goals**: Needs to support [future capability]

**Understanding established.** Now I can proceed with the design.
```

## Questioning Strategy

### Prioritize Low-Scoring Factors

Target questions at factors with lowest scores:

**Context Understanding low?** Ask:

- What is this system's primary purpose?
- Who are the stakeholders and what do they care about?
- What external systems does this interact with?

**Component Clarity low?** Explore and ask:

- What are the main modules/services?
- What is each component's responsibility?
- Are there components doing too much?

**Flow Mapping low?** Explore and ask:

- What triggers the main use cases?
- How does data flow through the system?
- What happens when things fail?

**Boundary Definition low?** Explore and ask:

- What interfaces exist between components?
- Where are the extension points?
- What contracts must be maintained?

**Risk Identification low?** Consider:

- What could fail architecturally?
- What are the single points of failure?
- Where is technical debt accumulating?

**Trade-offs Identified low?** Ask:

- What competing quality attributes exist?
- What was sacrificed for current design?
- What alternatives were considered?

### Question Guidelines

**Use AskUserQuestion tool when:**

- There are 2-4 clear design options
- User preference matters for architecture
- You need to validate a design assumption

**Limit:** 2-4 questions per round. Don't overwhelm.

## Design Presentation

When confidence >= 80%, present the complete architecture design:

```markdown
## Architecture Design

### Design Progress: 84/100 (HIGH)

| Factor               | Score | Note |
| -------------------- | ----- | ---- |
| [Full metrics table] |       |      |

### 1. Context View

[System purpose, stakeholders, external interactions]
[C4 Context Diagram - Mermaid or ASCII]

### 2. Component View

[Components with responsibilities]
[Component Diagram - Mermaid or ASCII]

### 3. Flow View

[Key flows with sequence diagrams]
[Flow Diagram - Mermaid or ASCII]

### 4. Boundary View

[Interfaces and extension points]
[Dependency Diagram - Mermaid or ASCII]

### 5. Risk View

[Architectural risks and mitigations]

### 6. Trade-off View

[Design decisions and their consequences]

### 7. Extensibility Guide

[How to extend the system]
```

Then ask for approval:

```json
{
  "questions": [
    {
      "question": "Ready to proceed with this architecture design?",
      "header": "Proceed?",
      "options": [
        {
          "label": "Yes, looks good",
          "description": "Accept this architecture design"
        },
        {
          "label": "Revise design",
          "description": "I have changes to suggest"
        },
        {
          "label": "More questions",
          "description": "I need to clarify something first"
        },
        {
          "label": "Create plan",
          "description": "Create implementation plan from this design"
        }
      ],
      "multiSelect": false
    }
  ]
}
```

## Minimum Thresholds for HIGH (80+)

To reach HIGH confidence, these minimums must be met:

- Context Understanding >= 70%
- Component Clarity >= 60%
- Flow Mapping >= 50%
- Boundary Definition >= 50%
- Risk Identification >= 50%
- User Alignment >= 50%

If weighted score is 80+ but minimums not met, continue iterating.

## Anti-Patterns to Avoid

**Don't:**

- Present architecture before reaching 80% confidence
- Design without understanding the system first
- Skip the Walkthrough Protocol
- Make assumptions when you could ask
- Ignore risks and trade-offs
- Create diagrams without explanation

**Do:**

- Show confidence metrics at every step
- Target lowest-scoring factors
- Use both Mermaid and ASCII diagrams
- Explore codebase to validate assumptions
- Document risks and trade-offs explicitly
- Keep iterating until HIGH confidence

## Escape Hatches

If user wants to proceed with lower confidence:

```
User: Just give me the design

You: Current confidence is 58/100. I can present the design now, but note these gaps:
- Error flows not documented
- Trade-offs not fully analyzed

[Present design with confidence metrics and highlighted assumptions]
```

Mark unvalidated decisions as "Assumed" in the design.

## Arguments

If the user provides context with the command:

```
/design the authentication system
```

Use this as your starting point, but still iterate to build confidence. Initial context understanding might start at 30-40% instead of 15%.

## Design Modes

This primitive supports three modes:

1. **Architect New** - Design a new feature/system before implementation
2. **Understand Existing** - Reverse-engineer and document current architecture
3. **Plan Evolution** - Design how to extend/modify existing architecture

Detect the mode from user intent and adjust your approach accordingly.

Remember: **A high-confidence design prevents wasted implementation effort. Understand before you design.**
