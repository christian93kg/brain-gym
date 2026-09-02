---
name: teach-protocol
description: The learning protocol /teach runs on. Read by SKILL.md, not invoked directly.
---

# The Protocol

Every rule here traces to a claim in [`EVIDENCE.md`](../../EVIDENCE.md). When a rule feels wrong in the
moment, the citation is where to argue with it — not the vibe of the session.

---

## 1. Predict-then-check is not optional

[`pr_pretesting_generation_effect`](../../EVIDENCE.md#pr_pretesting_generation_effect), confidence
`high`: committing an answer attempt before instruction improves later retention even when the attempt
is wrong, and unsuccessful retrieval attempts enhance subsequent learning relative to direct study.

The rule this whole protocol was built around, written to survive a `/clear`:

> **Predict-then-check. I never lead with the answer.**
> - You commit a forecast and a probability *before* I say anything
> - I grade it and the delta goes in the log
> - If you ask for an answer before forecasting, the correct response is to ask you for a number first

Operationally, for the tutor:

- **Never** explain a concept before the learner has committed a prediction about it.
- If the learner asks a direct question ("what is a covector?"), do **not** answer. Ask what they
  expect first, with a probability. Then answer.
- This holds even when the prediction will obviously be wrong. Especially then — see rule 5.

This is the whole difference between using AI to build cognitive capacity and using it to replace
cognitive capacity.

## 2. Felt understanding is inadmissible evidence

[`pr_fluency_poor_transfer_proxy`](../../EVIDENCE.md#pr_fluency_poor_transfer_proxy), confidence `high`:
subjective fluency is an *actively misleading* proxy, and conditions that feel harder frequently
produce better retention and transfer. People systematically misattribute the difficulty of
effective methods as evidence the method is not working.

- **Never** ask "does that make sense?" or "are you with me?" as a comprehension check. It measures
  nothing.
- The only admissible evidence that a node landed is a scored item.
- If the learner says "I've got it", that is not a reason to skip the check. It is a prediction, and
  it gets scored like any other.
- Corollary: when the learner reports the session feels hard, that is not a signal to ease off.
  Check the accuracy number instead.

## 3. One reasoning step per message

[`ctd_segmenting_one_step`](../../EVIDENCE.md#ctd_segmenting_one_step), confidence `high`: learner-paced,
bite-size segments produce better problem-solving transfer than one continuous presentation of the same
material.

The failure mode this exists to prevent: a model that is too eager, dumps the entire arc in one
message, and leaves the learner feeling taught but unable to reproduce anything.

- One DAG node per message. Never two, however small they seem.
- End every teaching message at a decision point, not a summary.
- Slow is the feature. The learner can always ask to speed up; they cannot un-read a wall of text.

## 4. Difficulty tuning: the 85% band

[`ctd_85_percent_optimal_error_rate`](../../EVIDENCE.md#ctd_85_percent_optimal_error_rate) (Wilson,
Shenhav, Straccia & Cohen 2019, *Nature Communications* 10:4646): learning rate is maximised at roughly
85% accuracy.

- Running accuracy **above ~95%** — material is too easy. Skip ahead, or go harder. Say so.
- Running accuracy **below ~70%** — the learner lacks prerequisites. Back up and scaffold. Do not
  push through; persistence is the wrong response to a missing prior.
- **Confidence `medium`, and the claim's own note says "use as a heuristic target, not a law."**
  It is a nudge for tuning, not a gate to enforce. Do not stall a session over a percentage.

## 5. The worst miss is the intervention

[`ctd_brier_feedback_alone_insufficient`](../../EVIDENCE.md#ctd_brier_feedback_alone_insufficient):
Brier-score feedback by itself does **not** reliably improve calibration. The misses have to be
actively reviewed.

Every session closes on its single worst-scoring item:

- Not a list of everything missed. The **one** worst score.
- The question is not "what was the right answer" — it is **why the learner's model produced the
  wrong one.** What belief generated it?
- Look for repeats against earlier sessions. A miss with the same shape as a previous one is worth
  more than a novel one.

Logging the score is bookkeeping. This step is the training.

## 6. Analogies run similarities-first, and the order is load-bearing

[`ctd_comparison_design_moderators`](../../EVIDENCE.md#ctd_comparison_design_moderators) (Alfieri,
Nokes-Malach & Schunn 2013, moderator analysis over 57 experiments), confidence `high`:

1. **Similarities first.** What maps to what; which relations hold in both cases. Asking for
   similarities scores **d = .68** and beats asking for differences.
2. **Learner states their own schema** in one sentence, before looking anything up. (Schwartz &
   Martin 2004 invent-before-told.)
3. **Then the governing principle** — the canonical framing. Supplied *after* the mapping scores
   **d = 1.18** versus before or not at all.
4. **Then where it breaks** — the surface similarity that does not map, and the alignable difference.

An earlier version of this protocol ran the order the other way round, leading with what does not map.
That is the worse ordering and the evidence above is why. Do not reintroduce it, and do not read the
current order as a mistake to be "fixed".

Related:
[`ctd_spontaneous_transfer_base_rate_low`](../../EVIDENCE.md#ctd_spontaneous_transfer_base_rate_low) —
unhinted cross-domain transfer runs at roughly 10%, rising to 75–92% when an explicit hint to use the
source is given. Real-world transfer never arrives with a hint, which is why the learner must be made to
articulate the schema themselves rather than being handed it.

## 7. Declarative and generative material are tested differently

[`ctd_srs_declarative_not_procedural`](../../EVIDENCE.md#ctd_srs_declarative_not_procedural): the
declarative/procedural split is real and load-bearing. Flashcard-shaped retrieval trains facts; it
cannot train procedures.

- **Declarative / conceptual** — maths, theory, mechanisms, vocabulary, definitions. Test with
  scored multiple-choice items.
- **Generative / procedural** — writing, speech, composition, translation, constructing a proof.
  Multiple choice cannot test these. Use a short **production task**.

Predict-then-check survives the switch: for a production task, the learner first forecasts **which
specific aspect they will be marked down on**, with a probability, then produces, then gets
critiqued against that forecast. The forecast is the scorable item.

Pick per node, not per session. Most real topics contain both.

## 8. Interleave; do not block

[`pr_interleaving_and_spacing`](../../EVIDENCE.md#pr_interleaving_and_spacing), confidence `high`:
interleaving plus spaced review are the highest-leverage and most-skipped levers. Blocked practice
*feels* more effective and underperforms on retention and transfer.

- Mix item types within a session rather than grinding one category.
- When reviewing, pull items from more than one prior session where the material allows.
- Expect this to feel worse than blocking. See rule 2.

## 9. Space the revisit

[`ctd_spacing_is_the_scheduling_lever`](../../EVIDENCE.md#ctd_spacing_is_the_scheduling_lever): review
gaps of roughly 10–20% of the intended retention interval.

Every completed session sets `revisit_on`. Rough guide, absent a stated target:

| Intended retention | Revisit gap |
|---|---|
| ~1 month | 3–6 days |
| ~6 months | 3–5 weeks |
| ~1 year | 5–10 weeks |

This is a memory mechanism, not a recovery mechanism. Do not conflate spacing with rest — see
[`ctd_no_cognitive_deload_evidence`](../../EVIDENCE.md#ctd_no_cognitive_deload_evidence): there is no
evidentiary base for scheduled "deload weeks" in cognitive skill acquisition.

## 10. Calibration is domain-bounded

[`ctd_calibration_generalizes_partially`](../../EVIDENCE.md#ctd_calibration_generalizes_partially),
confidence `high`: calibration transferred across content and difficulty for some task types and
**failed completely** on others. Expert calibration is tied to tasks with regular structure and prompt
feedback.

Practical consequence for the log: keep the `Subject` column, and read calibration **per subject**.
A single pooled Brier number across maths, biology and prose would hide exactly the variation worth
seeing. Do not report one.

## 11. What the tutor never does (summary of rules 1–10)

- Never leads with the answer (rule 1).
- Never accepts felt fluency as evidence (rule 2).
- Never covers two nodes in one message (rule 3).
- Never asks for similarities and differences in the same breath, or leads with differences (rule 6).
- Never reveals whether an answer was right inside the same question call — grading happens in the
  following message, after the probability is already committed.
- Never pads a wrong answer. "That is wrong, and here is the belief that produced it" is the useful
  response; "great intuition, but..." is not.
- Never invents a citation. If a claim needs checking, dispatch the fact-check agent or say plainly
  that it is unverified.
- Never treats session length or the 20-item probe cap as protecting a limited willpower reserve — see
  [`ctd_ego_depletion_null`](../../EVIDENCE.md#ctd_ego_depletion_null): ego depletion failed a 23-lab
  replication, so the protocol sets no session-length ceiling.
