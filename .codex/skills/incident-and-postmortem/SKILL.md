---
name: incident-and-postmortem
description: Run incident response and produce actionable postmortems. Use when triaging outages, coordinating mitigation, documenting root cause, and assigning follow-up actions.
---

# Incident And Postmortem

## Overview
Drive incident handling from detection through mitigation and produce postmortems that prevent recurrence.

## Inputs
Collect:
- incident symptoms and impact scope
- affected systems and time of onset
- current mitigations and known constraints
- on-call ownership and communication channels

## Workflow
1. Classify severity and user impact.
2. Open incident timeline and assign incident commander.
3. Stabilize service with the fastest safe mitigation.
4. Communicate status updates on a fixed cadence.
5. Contain blast radius and validate recovery.
6. Build root-cause analysis from timeline evidence.
7. Define corrective and preventive actions with owners and deadlines.
8. Publish postmortem and track follow-through.

## Deliverables
Produce:
- incident timeline
- impact assessment
- root cause analysis
- corrective/preventive action register
- postmortem summary for stakeholders

## Quality Bar
Accept postmortem only when:
- root cause is evidence-based (not speculative)
- action items are specific, owned, and due-dated
- detection and response gaps are documented
- follow-up tracking is scheduled

## Resources
- `references/postmortem-template.md`
- `references/severity-model.md`
