---
name: system-architecture-and-adrs
description: Design system architecture and create ADRs for critical technical decisions. Use when introducing new services, changing system boundaries, selecting infrastructure patterns, or documenting high-impact tradeoffs.
---

# System Architecture And ADRs

## Overview
Produce an architecture package that explains system boundaries, data flow, reliability/security posture, and the technical decisions that justify the design.

## Inputs
Collect:
- product requirements and SLO/SLA expectations
- existing system topology and constraints
- scaling, availability, and security requirements
- team ownership model and operational limits

## Workflow
1. Define architecture goals and non-goals.
2. Draw context and container-level boundaries (actors, services, data stores, third-party dependencies).
3. Define primary runtime flows (read, write, async, failure path).
4. Map non-functional requirements to concrete architecture controls.
5. Identify decision points with meaningful alternatives.
6. Write ADRs for each critical decision with rationale and consequences.
7. Define implementation sequence with risk reduction checkpoints.
8. Define observability and operational ownership for each component.

## Deliverables
Produce:
- architecture overview (context + container view)
- data flow and failure-mode notes
- ADR set with status (`proposed`, `accepted`, `superseded`)
- implementation sequence and ownership map

## Quality Bar
Accept the architecture package only when:
- every critical decision has an ADR
- failure modes and mitigation paths are documented
- ownership boundaries are explicit
- rollout order is feasible for current team capacity

## Resources
- `references/adr-template.md`
- `references/architecture-checklist.md`
