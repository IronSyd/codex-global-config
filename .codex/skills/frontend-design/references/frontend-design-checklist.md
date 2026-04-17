# Frontend Design Checklist

Use this checklist during implementation and final review. Skip items that do not apply to the surface.

## 1. Discovery

- Identify the entrypoint, route, or component boundary being changed.
- Find shared tokens, CSS variables, theme files, and reusable UI primitives first.
- Check whether the product already has a visual grammar for cards, spacing, borders, shadows, and type.
- Confirm the primary user action and what success looks like on the page.

## 2. Direction

- Define the intended feel in a few words: for example, editorial, technical, premium, playful, dense, calm.
- Decide what should dominate visually above the fold.
- Choose what to avoid, such as over-decoration, excessive motion, low-contrast palettes, or crowded panels.

## 3. Layout and Hierarchy

- Is the page broken into clear sections with a readable flow?
- Does spacing create rhythm between sections and inside components?
- Is the main action more visually prominent than secondary actions?
- Do cards, tables, forms, and sidebars align to a consistent structure?

## 4. Typography

- Is there a clear title, subtitle, body, and metadata scale?
- Are line lengths and line heights comfortable to scan?
- Does font choice match the product rather than default browser aesthetics?
- Are weights and sizes used intentionally instead of randomly increasing everything?

## 5. Color and Surfaces

- Are colors mapped to existing tokens or centralized variables?
- Do surfaces have a clear separation model: fill, border, shadow, blur, or contrast?
- Is accent color used sparingly enough to preserve meaning?
- Does text maintain strong contrast against every background it appears on?

## 6. Components and States

- Do controls have hover, focus, active, disabled, and loading states where needed?
- Are empty, error, and success states visually coherent with the rest of the page?
- Are icons, avatars, and illustrations consistent in size and style?
- Has repeated styling been pulled into reusable classes, tokens, or components?

## 7. Responsive Behavior

- Does the layout still read well on mobile, not just shrink?
- Are tap targets and spacing comfortable on smaller screens?
- Do long labels, tables, charts, or filters have a deliberate small-screen strategy?
- Are sticky areas, modals, drawers, and overflow regions usable on narrow viewports?

## 8. Final QA

- Remove stray one-off values that should become tokens.
- Check alignment, border radius, shadows, and transition timing for consistency.
- Verify keyboard navigation and visible focus styles.
- Check long content, empty data, image failure, and loading placeholders.
- If the repo supports snapshots or screenshots, use them to catch visual regressions.
