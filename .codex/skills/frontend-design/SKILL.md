---
name: frontend-design
description: Use when the user wants to design, restyle, or materially improve a website, web app screen, component set, or landing page without a strict Figma source of truth. Trigger for requests about visual direction, layout, typography, spacing, color systems, responsive behavior, interaction polish, and design-system-aware frontend UI work.
---

# Frontend Design

## Overview

Use this skill for design-led frontend work in code. It is for turning product goals, rough direction, or weak existing UI into an intentional interface that fits the repo's framework, component model, and brand constraints.

## When to Use This Skill

- The user asks to design or redesign a page, section, feature surface, or component.
- The user wants a landing page, dashboard, onboarding flow, marketing page, or visual refresh.
- The user wants stronger hierarchy, spacing, typography, color, motion, or responsive behavior.
- The user gives loose inspiration rather than a pixel-perfect source file.
- If the user provides a Figma URL or expects 1:1 implementation from Figma, use `figma-implement-design` instead.

## Workflow

### 1. Ground in the Existing Frontend

- Inspect the current UI before designing.
- Read shared components, CSS variables or tokens, layout primitives, routing entrypoints, and any design-system files.
- When working in an existing product, preserve the established visual language unless the user clearly asks for a reset.

### 2. Lock the Design Direction

- Define the page goal, audience, and primary action.
- State the visual direction in concrete terms: typography, density, color mood, contrast level, spacing rhythm, and motion style.
- For substantial work, give the user a short plan before mutating code.

### 3. Design System-First

- Prefer reusable tokens and components over page-specific one-offs.
- Reuse existing buttons, cards, form fields, and layout shells when they are close enough.
- If the current system is weak, strengthen it with a small set of clear rules rather than scattering ad hoc overrides.

### 4. Build Clear Hierarchy

- Make the most important action obvious.
- Use whitespace, contrast, size, and typography to create a reading order.
- Avoid decorative clutter that does not support the concept.
- Favor one strong visual idea over several weak ones.

### 5. Ship Complete UI States

- Cover desktop and mobile, plus intermediate breakpoints when the layout materially changes.
- Include hover, focus, active, disabled, loading, empty, and error states where relevant.
- Check wrapping, overflow, image cropping, and long-content edge cases.

### 6. Polish Before Hand-off

- Review against `references/frontend-design-checklist.md`.
- Remove magic numbers that should be tokens.
- Tighten spacing inconsistencies, weak contrast, and generic styling that flattens the design.
- Run the most relevant local build, tests, or screenshots available for the changed surface.

## Design Rules

- Avoid generic "AI template" output. The interface should have a clear point of view.
- Preserve the product's existing design system when one exists.
- Prefer CSS variables or project tokens over repeated literals.
- Typography should feel deliberate, not default.
- Motion should improve orientation or emphasis, not act as filler.
- Background treatments, gradients, and patterns are optional; use them only when they strengthen the direction.
- Do not add heavy libraries to solve simple styling problems.
- Maintain accessibility, semantic structure, and keyboard usability while improving visuals.

## Example Triggers

- "Redesign this dashboard so it feels more premium."
- "Refresh the landing page without changing the product copy."
- "Make this settings page feel less cramped on desktop and mobile."
- "Improve this component library's visual hierarchy and states."

## Reference

- Use `references/frontend-design-checklist.md` for review criteria and execution guardrails.
