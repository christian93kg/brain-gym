---
id: teach_log
type: log
status: active
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags:
  - log
  - calibration
  - teach
---

# Teach Session Log

Running table, append-only. One row per scored item from a `/teach` session — probe items,
comprehension checks, and production-task forecasts alike. Rows are appended in a batch at session
end, not one at a time.

`Score = (P − Outcome)²`. Outcome is 1 or 0. P is the stated probability (0–1).

> **Read calibration per subject, never pooled.** Calibration transfers across some task types and
> fails completely on others (`ctd_calibration_generalizes_partially`), so a single number across
> mathematics, biology and prose hides exactly the variation worth seeing. Keep the `Subject` column
> and split on it. — PROTOCOL rule 10

> **Only answer-absent ratings count.** `Kind` marks each row. `probe`, `predict` and `review` rows
> feed the calibration read; `check` rows are rated moments after the explanation, when confidence
> runs inflated, so they are scored but left out. Read the result as signed bias (mean P minus
> accuracy), per subject and per item type, never as a pooled number. — PROTOCOL rule 10

> **Four anchors, not ten bands.** This stream uses four fixed probabilities — 0.30 / 0.50 / 0.70 /
> 0.90 — because the quiz interface admits at most four options per question. The consequence is a
> four-bucket calibration curve rather than a ten-bucket one.
>
> A four-option item also has a ~25% chance floor, so these Brier numbers are **not** on the same
> scale as free-form forecasting, where a wrong 0.9 scores 0.81 and nothing stops you scoring near
> zero. Do not pool this log with any free-form forecasting log you keep.

| Date | Subject | Session | Item | Kind | P | Outcome | Score |
|---|---|---|---|---|---|---|---|
