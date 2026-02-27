---
name: test-strategy-unit-integration-e2e
description: Define risk-based testing strategy across unit, integration, and end-to-end layers. Use when planning quality gates for new features, refactors, releases, or CI policy changes.
---

# Test Strategy Unit Integration E2E

## Overview
Build a layered, risk-based test strategy that balances speed and confidence across unit, integration, and end-to-end tests.

## Inputs
Collect:
- feature scope and regression risk profile
- critical user journeys and failure costs
- current test suite coverage and CI duration limits
- release cadence and rollback tolerance

## Workflow
1. Identify critical flows and rank by business and technical risk.
2. Map each flow to the lowest effective test layer.
3. Define required unit tests for core logic and edge cases.
4. Define required integration tests for service/data boundaries.
5. Define required E2E tests for top customer journeys.
6. Define quality gates per PR and pre-release.
7. Define flaky test handling and quarantine policy.
8. Define coverage targets and trend monitoring.

## Deliverables
Produce:
- coverage matrix by risk and test layer
- minimum quality gate policy
- CI test split plan (fast/slow suites)
- release confidence checklist

## Quality Bar
Accept the strategy only when:
- every high-risk flow has at least one stable test
- gate thresholds are measurable and enforceable
- expected CI duration fits team constraints
- ownership exists for test maintenance

## Resources
- `references/coverage-matrix-template.md`
