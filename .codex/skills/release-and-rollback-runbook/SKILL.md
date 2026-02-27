---
name: release-and-rollback-runbook
description: Build release plans and rollback runbooks for production changes. Use when preparing deployments, approving go-live, or reducing release risk for critical updates.
---

# Release And Rollback Runbook

## Overview
Create a release runbook with clear go/no-go criteria, rollout steps, monitoring checks, and rollback procedures.

## Inputs
Collect:
- release scope and deployment artifacts
- dependent services and external integrations
- maintenance window and stakeholder constraints
- observability signals and incident contacts

## Workflow
1. Define release objective, scope, and blast radius.
2. Define pre-release checks (build, tests, migrations, config, secrets).
3. Define rollout method (`all-at-once`, `canary`, `phased`) with timing.
4. Define live verification checkpoints and thresholds.
5. Define rollback triggers and exact rollback steps.
6. Define communication plan for internal and external stakeholders.
7. Run tabletop or dry-run for critical releases.
8. Capture post-release outcomes and follow-up actions.

## Deliverables
Produce:
- release checklist
- rollout timeline with owners
- rollback runbook and trigger table
- communication templates

## Quality Bar
Accept the runbook only when:
- rollback can be executed without new decisions
- monitoring thresholds are explicit and actionable
- all critical owners are assigned and available
- deployment steps are sequenced and time-bounded

## Resources
- `references/release-checklist-template.md`
