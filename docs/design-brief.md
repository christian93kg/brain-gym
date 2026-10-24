# brain-gym · design brief

Two art directions to explore in Claude Design, plus the constraints that apply to both.
Untracked scratch file — delete it or commit it, either is fine.

---

## Shared context (paste into both prompts)

**What the project is.** `brain-gym` is a tutor skill for Claude Code that refuses to explain
anything until it has measured what you already know. You commit a prediction *and a probability*
before every answer; everything is scored with the Brier rule, `(P − outcome)²`. Four phases:

```
Probe  ───►  Plan  ───►  Teach  ───►  Revisit
20 items     a DAG of    one node     spaced at
max, or      the whole   per message, 10–20% of the
stop at 85%  arc         each closed  retention
accuracy                 by a scored  interval
                         item
```

The probe binary-searches each dependency strand downward until it finds the floor. A **confident
wrong answer** is the most informative result available, so the tutor hunts for them, and the
teaching arc starts at the belief that produced one — not at chapter one.

**Real output the artwork can draw from** (this is verbatim from the README):

```
probe · differential forms                  11 items · stopped at 82%

line integrals           held      3/3   confident throughout
linear algebra           held      3/3   confident throughout
multivariable notation   shaky     2/3   one miss at "Guessing"
vector calculus          MISSING   1/2   confident and wrong once

worst item               stated P = 0.90, wrong        brier 0.81
"grad, div and curl are three unrelated operators"

arc      12 nodes, 3 skipped as already held
         entry point moved to exterior derivative, not 1-forms
```

**The one non-negotiable design rule:** the artwork must *be* the data. The current hero is a real
calibration curve running below the perfect-calibration diagonal — overconfident at the top end.
Decoration that merely gestures at measurement is a downgrade. Whatever is drawn should be
readable as a true plot, section, or record of an actual session.

**Palette (current, keep unless the direction argues otherwise):**

| Role | Hex |
|---|---|
| ground | `#0d0b0c` |
| foreground | `#e9e2e7` |
| accent — the measured thing | `#f778ba` |
| accent 2 — the ideal / reference | `#d2a8ff` |
| muted | `#a89ba3` |
| dim | `#70626a` |
| grid | `#20161c` |
| axis | `#3a2f35` |

### Hard technical constraints

1. **No web fonts.** GitHub will not load them. Convert all type to **outlined paths**. (The
   current SVG survives on system monospace via `textLength` + `lengthAdjust="spacingAndGlyphs"`
   hacks — paths are the better answer.)
2. **Assume no animation.** GitHub proxies images through camo and sanitizes SVG; SMIL and CSS
   animation are unreliable. Design static-first. Motion is a bonus to be verified, never a premise.
3. **SVG, hand-editable**, with a `role="img"` and a descriptive `aria-label` — the hero carries
   real information, so the alt text must describe the *finding*, not just the picture.
4. **1200 × 630** for the OG / social-preview image; displayed at 820px wide in the README, so
   nothing may depend on detail below ~1.5px at that scale.
5. Ship a **light and dark pair** for `<picture>` + `prefers-color-scheme`. Currently dark-only.

### Deliverables (both directions)

- `docs/og.svg` — the hero, dark
- `docs/og-light.svg` — light counterpart, same composition, not a naive inversion
- **Four phase glyphs** — probe / plan / teach / revisit — to replace the ASCII pipeline diagram
  in the README. Small, monoline, legible at 32px.
- **A repeatable figure style** so the probe-output block and the phase diagram read as one hand
- **A mark** — the plugin currently has none. Needs to work at 16px (favicon), 64px (plugin
  manifest), and as a corner element on the hero.

---

## Direction A · Botanical plate

**The idiom.** A Victorian scientific engraving — but rendered as **white-line engraving on
near-black** rather than ink on cream. Hairline `#e9e2e7` strokes, stipple and cross-hatch for
tone, on `#0d0b0c` ground. This is the fusion point: the botanical cross-section tradition
executed in the existing pink/black palette, which also solves the problem that a cream plate
looks broken beside GitHub's dark mode.

**Why this project.** The metaphor isn't applied, it's structural. The probe really is a downward
search for a floor; the plan really is a branching dependency graph. So the plant *is* the DAG:

- **roots** — the prerequisite strands, drawn descending; the taproot bores deepest, to the node
  that broke
- **stem and branches** — the teaching arc, one fork per node
- **leaves** — concepts. Drawn open and whole where the probe found them **held**; drawn in
  cutaway section, veins exposed, where they are **shaky**; drawn absent or severed where
  **MISSING**
- **one severed root**, and only this, in fluoro `#f778ba` — the confident wrong answer that the
  arc starts from. It should be the single warmest thing in the frame.

**Plate apparatus.** Numbered margin callouts in the engraving tradition, with the project's own
language as the captions:

> *Fig. 1 · radicle* — stated P = 0.90, wrong. brier 0.81.
> "grad, div and curl are three unrelated operators"
> *the belief behind it. the arc starts here, not at 1-forms.*

Include a specimen label block bottom-right — the plate's "collection data" is the session
metadata: `11 items · stopped at 82% · 12 nodes, 3 skipped`. A scale bar reading in Brier score
rather than millimetres is the kind of joke that rewards a second look; use it once.

**Register.** The repo already carries claim IDs, confidence tiers and verification dates
(`EVIDENCE.md`). A scientific plate is the honest visual grammar for that, not a costume.

**Mark.** A sectioned seed, or the severed radicle alone.

**Failure modes to avoid.** Generic AI-botanical prettiness. Symmetry — real specimens aren't
symmetrical, and neither is a knowledge graph. Filling the frame; engraved plates breathe, and the
headline type needs the left third.

---

## Direction B · Phosphor oscilloscope

**The idiom.** Keep the palette exactly, push the composition toward **measurement hardware**
rather than a chart. The reference is a storage-scope screen photographed slightly hot: graticule,
a trace with faint bloom where it's brightest, and the CRT's characteristic soft falloff at the
edges of the phosphor.

**What's drawn.** The same calibration data as today — stated confidence on X, actual accuracy on
Y, the measured curve sitting below the perfect-calibration diagonal — but as an *instrument
readout*:

- **graticule** in `#20161c`, with the finer subdivision ticks along the centre axes that real
  scopes have
- **the measured trace** in `#f778ba`, with a slight outer glow, brightest where the curve dwells
  and thinner through the fast section — phosphor persistence, not a uniform stroke
- **the ideal diagonal** in `#d2a8ff`, dashed, dimmer — a reference channel, not a data channel
- **corner readouts** in the instrument's own voice:
  `BRIER 0.81` · `N = 11` · `P̄ 0.82` · `STOP 85%` · `CH1 measured` · `CH2 ideal`
- optional: a **second trace** for the recall curve at 10–20% spacing, faintly, as CH3

**Why it works.** The tagline is *nothing taught until it's measured*. An instrument panel says
that without a word of copy, and it upgrades the existing chart from "a slide" to "a reading taken
off a device."

**Phase glyphs** come free here: four small scope screens, each showing one phase's characteristic
trace — the probe's descending staircase, the plan's branching, the teach loop, the revisit decay.

**Mark.** A single graticule cell with the trace crossing it.

**Failure modes to avoid.** Overdoing the bloom until it reads as a synthwave asset. Scanlines —
they're a different decade and a different idea. The glow should look like *photographed phosphor*,
restrained enough that the data stays the brightest thing on screen.

---

## How to evaluate

Put both hero candidates at 820px on a GitHub README, in **both** colour schemes, next to the
current `docs/og.svg`. The question is not which is prettier. It is: **which one still tells you
something true about the project once you stop looking at it as a picture?**
