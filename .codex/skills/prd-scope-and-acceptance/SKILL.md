---
name: prd-scope-and-acceptance
description: Define product requirement documents, scope boundaries, acceptance criteria, and non-goals. Use when starting a new feature, planning a roadmap item, or turning ideas into implementation-ready specs.
---

# PRD Scope And Acceptance

## Overview
Create a decision-complete PRD that defines why the work matters, what is in scope, what is out of scope, and how success will be accepted.

## Inputs
Collect:
- business objective and target user
- current state and known constraints
- timeline, budget, and staffing limits
- dependencies and external approvals

## Workflow
1. Define the problem and desired outcome in one paragraph.
2. Define the target user segments and primary use cases.
3. Split scope into `in scope` and `out of scope` with explicit boundaries.
4. Write functional requirements as testable statements.
5. Write non-functional requirements (security, reliability, latency, compliance) only where required.
6. Convert success into acceptance criteria using Given/When/Then or equivalent testable format.
7. List risks, assumptions, open questions, and mitigation owners.
8. Produce implementation handoff notes for engineering, QA, and launch operations.

## Deliverables
Produce:
- PRD document
- scope boundary table (`in`, `out`, `deferred`)
- acceptance criteria matrix mapped to requirements
- non-goals list
- assumptions and risk register

## Quality Bar
Accept the PRD only when:
- every requirement has at least one acceptance criterion
- scope boundaries are explicit and non-overlapping
- assumptions and dependencies have owners
- an engineer can implement without making product decisions

## Resources
- `references/prd-template.md`
