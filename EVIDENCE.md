# Evidence

Every rule in [`PROTOCOL.md`](skills/teach/PROTOCOL.md) traces to one of the claims below. When a rule
feels wrong in the moment, this file is where to argue with it.

**What these are.** Summaries extracted from a set of deep-research passes run on 2026-07-07,
2026-08-17 and 2026-10-10, each carrying its sources and a confidence level. They are *not* a systematic review, and
several are explicitly `medium` confidence — read the confidence field before treating a claim as
settled. Where a finding is contested in the literature, the note says so rather than picking a side.

Claim ids are stable; the protocol links to the anchors directly.

---

## Rules the protocol enforces

### pr_pretesting_generation_effect

**Backs:** rule 1 — predict-then-check is not optional

**Assertion:** Committing an answer attempt before instruction improves later retention even when the
attempt is wrong (the pretesting effect), unsuccessful retrieval attempts enhance subsequent learning
relative to extended direct study, and errorful generation followed by corrective feedback benefits
learning — with high-confidence errors corrected more readily than low-confidence ones (the
hypercorrection effect).

**Source:** Richland, Kornell & Kao 2009, *JEP: Applied* 15(3):243–257 (five experiments, embedded
pretest questions before reading a passage); Kornell, Hays & Bjork 2009, *JEP: Learning, Memory, and
Cognition* 35(4):989–998 (six experiments, fictional trivia and weak-associate guessing); Metcalfe 2017,
*Annual Review of Psychology* 68:465–489 (review of hypercorrection and errorful generation with
feedback)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-09-01

**Notes:** Confirms "commit a forecast before I say anything" is not just a pedagogical preference — a
wrong forecast, once made, produces better retention than skipping straight to the explanation. Feedback
still has to follow (rule 5's "the worst miss is the intervention"); a wrong guess with no correction is
not the mechanism being cited here.

### pr_fluency_poor_transfer_proxy

**Backs:** rule 2 — felt understanding is inadmissible evidence

**Assertion:** Subjective fluency and felt confidence are poor, often misleading proxies for whether a
practice is actually building durable/transferable skill — conditions that feel harder frequently
produce better retention and transfer, and people systematically misattribute the difficulty of
effective methods (like interleaving) as evidence the method isn't working.

**Source:** Bjork & Bjork 2011 (desirable difficulties); Yan, Bjork & Bjork 2016, *JEP: General*
145:918–933 (misattribution of interleaving difficulty)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-07-07

**Notes:** Reinforces `pr_interleaving_and_spacing`'s "feels harder ≠ not working" point with separate
citations. Operational consequence: only a logged, scored item counts as evidence that a node landed —
never the learner's felt sense of "I've got this."

### ctd_85_percent_optimal_error_rate

**Backs:** rule 4 — the 85% difficulty band

**Assertion:** For gradient-descent-type learners, learning rate is maximized at approximately 85%
accuracy (~15.87% error), giving a concrete difficulty-tuning target — above ~95% accuracy the material
is too easy, below ~70% the learner lacks the prior knowledge and needs scaffolding rather than
persistence.

**Source:** Wilson, Shenhav, Straccia & Cohen 2019, *Nature Communications* 10:4646

**Confidence:** medium &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** Evidence tier is computational/biologically-plausible models, **not** a human learning RCT.
Use as a heuristic target, not a law. Pairs with the expertise-reversal effect (Kalyuga) for the lower
bound.

### ctd_segmenting_one_step

**Backs:** rule 3 — one reasoning step per message

**Assertion:** Breaking an explanation into learner-paced, bite-size segments produces better
problem-solving transfer than presenting the same content as one continuous unit.

**Source:** Mayer & Chandler 2001, *Journal of Educational Psychology* 93(2):390–397, Experiment 2 (a
16-segment, click-to-continue narrated animation of lightning formation vs. one continuous presentation,
effect size d = 1.36 on transfer, as described in Mayer & Moreno 2003, pp. 46–47); Mayer & Moreno 2003,
*Educational Psychologist* 38(1):43–52 (Table 3 lists segmenting as the recommended load-reducing method
for Type 2 overload)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-09-01

**Notes:** Mayer & Moreno's own 2003 paper flags segmenting as resting on a single experiment at time of
writing ("more empirical research is needed") — treat as directionally solid, not multiply-replicated.
The underlying study tested user-paced video segments, not chat-message boundaries; it supports the
mechanism (pacing reduces cognitive overload) rather than a claim that DAG-node-per-message was itself
tested.

### ctd_brier_feedback_alone_insufficient

**Backs:** rule 5 — the worst miss is the intervention

**Assertion:** Brier-score feedback by itself does not reliably improve calibration — the misses have to
be actively reviewed — and the causal mechanism behind the headline calibration-training result is
contested on method-variance grounds even though the accuracy numbers stand.

**Source:** Martin et al. 2025, *Futures & Foresight Science*; Hauenstein et al. 2025, *Psychological
Science* (re-analysis challenging Good Judgment Project training conclusions); a Wharton working paper
noting reliance on self-report rather than measured technique use

**Confidence:** medium &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** This is why the protocol closes every session on the single worst-scoring item rather than
just recording the number. Logging a score is bookkeeping; studying the miss is the intervention.

### ctd_comparison_design_moderators

**Backs:** rule 6 — analogies run similarities-first

**Assertion:** How a case-comparison exercise is structured materially changes its effect size: asking
the learner to find **similarities** outperforms asking for differences (d = .68 vs lower), and
supplying the unifying principle **after** the comparison is dramatically better than before or not at
all (d = 1.18) — so the highest-yield sequence is map similarities first, then obtain the governing
principle, then examine where the analogy breaks.

**Source:** Alfieri, Nokes-Malach & Schunn 2013, moderator analysis over 57 experiments

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** The differences row remains valuable for depth; it is simply not the active ingredient, and
leading with it is the worse ordering. Compatible with Schwartz & Martin 2004 "invent before being
told" — the learner should attempt the abstraction before reading the canonical framing.

### ctd_spontaneous_transfer_base_rate_low

**Backs:** rule 6 — why the learner must state the schema themselves

**Assertion:** Spontaneous cross-domain transfer without a cue is rare — approximately 10% baseline,
rising to ~30% with a single source analog and 75–92% when an explicit hint to use the source is given —
and the two interventions that reliably raise unhinted transfer are comparing multiple examples and
inducing an explicit schema.

**Source:** Gick & Holyoak 1980, 1983, *Cognitive Psychology* 15:1–38

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** Real-world transfer never arrives with a hint, which is precisely why practice must use
pairs/sets and force explicit schema articulation instead of handing the schema over.

### ctd_srs_declarative_not_procedural

**Backs:** rule 7 — declarative and generative material are tested differently

**Assertion:** Spaced repetition is well validated for declarative retention but not for procedural
skill — flashcards suit the declarative scaffolding of a technical domain (syntax, definitions,
concept-to-purpose mappings) while the procedures themselves require interleaved hands-on repetition
under varied conditions.

**Source:** Dunlosky, Rawson, Marsh, Nathan & Willingham 2013, *Psychological Science in the Public
Interest* 14(1):4–58 (only practice testing and distributed practice earned "high utility" of 10
techniques); Shea & Morgan 1979 contextual-interference effect; Kerfoot spaced-education RCTs in medical
education (20+ trials, incl. a 724-resident *J Am Coll Surg* 2010 trial showing transfer and long-term
retention of diagnostic skills)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** Interleaving's benefit is medium in lab settings (d ≈ 0.57) but small-to-negligible in applied
field settings (d ≈ 0.19). The Kerfoot trials are the developer's own, though peer-reviewed and partly
independently replicated. Worked-example-then-faded-scaffolding is the recommended on-ramp for a new
procedure.

### pr_interleaving_and_spacing

**Backs:** rule 8 — interleave, do not block

**Assertion:** Interleaving (mixing problem/pattern types to teach *when* to deploy, not just how) plus
spaced review are the highest-leverage and most-skipped levers for converting reps into a durable
pattern library; blocked practice feels more effective but underperforms on retention and transfer.

**Source:** Kornell & Bjork 2008; Rohrer & Taylor 2007; Bjork & Bjork 2011; Yan et al. 2016

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-07-07

**Notes:** Expect interleaved sessions to *feel* worse than blocked ones. That feeling is the subject of
`pr_fluency_poor_transfer_proxy`, not a signal to change the schedule.

### ctd_spacing_is_the_scheduling_lever

**Backs:** rule 9 — space the revisit

**Assertion:** The evidence-based cognitive analogue of "recovery" is the spacing effect, with an optimal
inter-study gap of roughly 10–20% of the desired retention interval — a different mechanism (memory
consolidation and study-phase retrieval) from physical supercompensation.

**Source:** Cepeda, Pashler, Vul, Wixted & Rohrer 2006, *Psychological Bulletin* 132(3):354–380 (839
assessments, 317 experiments, 184 articles, >14,000 participants); Cepeda et al. 2008, *Psychological
Science* 19:1095–1102 (~1,350 participants)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** For a target 8–12 weeks out, first review gaps on the order of days-to-a-week are
near-optimal, expanding as the date recedes. Two independent research passes reached this separately.

### ctd_calibration_generalizes_partially

**Backs:** rule 10 — calibration is domain-bounded

**Assertion:** Calibration trains fast but generalizes only partially — improvement appeared almost
entirely between the first and second round of feedback, and transferred across content, difficulty and
response mode for some tasks while failing completely on others (handwriting classification, numerical
fractile/range estimation).

**Source:** Lichtenstein & Fischhoff 1980, *Organizational Behavior and Human Performance* 26(2):149–171
(12 subjects, 11 sessions of 200 items with calibration feedback); Keren 1987/1991; Wagenaar & Keren 1986
(bridge experts calibrated, blackjack dealers not)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** Train calibration on the response format and judgment domain actually in use, not on generic
trivia. Expert calibration is tied to homogeneous repetitive tasks with prompt reliable feedback *plus
analysis* — feedback alone is insufficient (see `ctd_brier_feedback_alone_insufficient`). Practical
consequence for the log: keep the `Subject` column and read calibration per subject. A single pooled
number across mathematics, biology and prose would hide exactly the variation worth seeing.

### ctd_forecast_metamemory_calibration_distinct

**Backs:** rule 10 — quiz calibration is its own number, never pooled with forecasting

**Assertion:** Calibration on one's own memory (judgments of learning, quiz confidence) and calibration
on world-event forecasts are correlated-but-distinct skills. Mean confidence level (bias) partly carries
across domains; discrimination (resolution) does not, and no study has measured forecasting calibration
and memory-judgment accuracy in the same people.

**Source:** Kelemen, Frost & Weaver 2000, *Memory & Cognition* (N = 66 and 78; confidence level
test–retest .38–.69, only 2/24 and 3/24 cross-task resolution correlations significant); Mazancieux,
Fleming, Souchay & Moulin 2020 (N = 181; episodic memory the most distinct domain); Seow, Fleming &
Hauser 2025, *PLOS Mental Health* (N = 327; bias robustly correlated across domains, metacognitive
efficiency ρ = 0.11)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-10-10

**Notes:** High for the *don't-pool* decision; the correlated-but-distinct reading underneath it is
medium-high. Forecasting-practice transfer to memory judgments is unstudied. The scales also differ: a
binary-outcome Brier carries an irreducible uncertainty term (p = .7 scores .21 even when perfectly
calibrated), so a pooled mean would mostly track the mix of question types. The only legitimate
cross-stream comparison is the sign and size of each stream's own bias.

### ctd_resolution_unstable_within_person

**Backs:** rule 10 — bias is usable early, resolution is not

**Assertion:** An individual's resolution — whether their confidence separates the items they know from
the ones they don't — has near-zero one-week test–retest reliability, so one session's resolution says
almost nothing about the person. Their average confidence level is far more stable.

**Source:** Kelemen, Frost & Weaver 2000, *Memory & Cognition* (one-week test–retest of gamma: ease of
learning .13, immediate JOL .01, delayed JOL .08, text comprehension .06, all nonsignificant; confidence
level .38–.69)

**Confidence:** medium &nbsp;·&nbsp; **Verified:** 2026-10-10

**Notes:** One study, but the most directly person-level datapoint found. This is why the protocol acts
on per-subject bias and schedules on outcomes rather than on stated confidence: using confidence to
decide what to review needs good resolution, and good resolution can only be established by pooling
many items across many sessions.

### ctd_foresight_bias_answer_present

**Backs:** rule 10 — which confidence ratings count toward calibration

**Assertion:** Judging one's own learning while the answer is present inflates predicted recall
relative to a later test where it is absent — by roughly 15–24 percentage points on material whose
answer makes the question look easy — and the bias is repaired by test experience and by judging later
with the answer hidden, much less by further study.

**Source:** Koriat & Bjork 2005, *JEP: Learning, Memory, and Cognition* (backward-associated pairs:
judgment 75.7% vs recall 60.3%); Koriat & Bjork 2006, *Memory & Cognition* (pairs related only when seen
together: 67.2 vs 43.4; illusion gone by the fourth study–test cycle)

**Confidence:** medium &nbsp;·&nbsp; **Verified:** 2026-10-10

**Notes:** High for existence, medium for how much of the magnitude carries to technical
question-and-answer material. Group means only. Applying it to the comprehension check that closes a
teaching step — rated moments after the explanation — is this project's inference, not a tested result.

### ctd_delayed_answer_absent_jol_accurate

**Backs:** rule 10 — which confidence ratings count toward calibration

**Assertion:** Judgments of learning made after a short delay with the answer absent are far more
accurate than immediate ones, the delay needed is seconds to minutes rather than days, and the benefit
depends on the answer being absent when the judgment is made.

**Source:** Rhodes & Tauber 2011, *Psychological Bulletin* (meta-analysis, 112 effect sizes, 4,554
participants: delay raised accuracy by g ≈ 0.93); Dunlosky & Nelson 1992, *Memory & Cognition* (answer
absent: all 45 participants showed the effect; answer present: little or none); Nelson & Dunlosky 1991,
*Psychological Science* (gamma .38 immediate vs .90 delayed — figures verified secondhand only)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-10-10

**Notes:** High for existence and direction, medium for magnitude. Leading account: a delayed,
answer-absent judgment rests on the outcome of a covert retrieval attempt, which predicts the test far
better than the ease of having just read something. One caution for anyone reading a Brier score: Van
Overschelde & Nelson 2006 found delay improved resolution while worsening mean calibration, so a real
improvement can move the blended number the wrong way.

### ctd_underconfidence_with_practice

**Backs:** rule 10 — late-subject underconfidence is not corrected

**Assertion:** Across repeated study–test cycles, judgments of learning shift from overconfidence to
underconfidence while resolution improves, driven largely by memory of past test performance.

**Source:** Koriat, Sheffer & Ma'ayan 2002, *JEP: General*; Koriat & Bjork 2006, *Memory & Cognition*
(cycle 1 judgment 38.3 vs recall 27.7; cycle 4 judgment 78.7 vs recall 93.1); Finn & Metcalfe 2007, 2008
(memory-for-past-test heuristic)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-10-10

**Notes:** High for existence; boundary conditions exist (Scheck & Nelson 2005). Operational consequence:
underconfidence that appears once a subject has been reviewed several times is expected, often comes
with better resolution, and is not a monitoring failure to coach out of the learner.

### ctd_jol_reactivity_material_dependent

**Backs:** the quiz item format — a confidence rating on every item

**Assertion:** Making a judgment of learning changes memory for some materials (related word pairs
g ≈ 0.32, word lists g ≈ 0.38) but not others (unrelated pairs ≈ 0), and has minimal effect on
education-related material.

**Source:** Double, Birney & Walker 2018, *Memory* (meta-analysis; overall g = 0.054, nonsignificant);
Zhao et al. 2023, *Journal of Intelligence* (minimal reactivity on educational material after retrieval
practice)

**Confidence:** medium &nbsp;·&nbsp; **Verified:** 2026-10-10

**Notes:** Between-condition effects; no per-person distributions exist. The practical reading: asking
for a probability on every item costs close to nothing in learning terms on the kind of material this
tutor teaches, so the protocol asks for one every time.

---

## What the protocol deliberately does not do

Two null results, included because the absences they explain are otherwise easy to mistake for
oversights.

### ctd_no_cognitive_deload_evidence

**Backs:** rule 9 — spacing is not rest

**Assertion:** Scheduled "deload weeks," progressive-overload prescriptions, tapering and overtraining
syndrome have no direct evidentiary base in cognitive skill acquisition — a targeted search found no
randomized or controlled study testing a planned reduced-volume recovery week in cognitive or
educational training, and "cognitive overtraining syndrome" is not a validated clinical construct.

**Source:** Meeusen et al. 2013 ECSS/ACSM consensus (physical overtraining syndrome only);
Coleman/Schoenfeld et al. 2024 *PeerJ* RCT (a deload week harmed lower-body strength with no hypertrophy
benefit, in its own home domain)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** The real phenomena in the neighbourhood are transient mental fatigue and burnout (a chronic
stress syndrome, not a training-dose syndrome). Do not schedule a deload; use spacing and sleep. This is
why rule 9 insists spacing is a memory mechanism and not a rest mechanism.

### ctd_ego_depletion_null

**Backs:** the 20-item probe cap, and the absence of a session-length cap

**Assertion:** Ego depletion — the claim that self-control or effort draws down a limited within-session
resource — failed a 23-lab preregistered replication with an effect near zero, and must not be used to
justify session-length ceilings or recovery weeks.

**Source:** Hagger et al. 2016 (23 labs, N > 2,000, effect ≈ 0), overturning Hagger et al. 2010
meta-analysis (d = 0.62); Carter et al. 2015 bias-corrected meta-analysis (true effect near zero)

**Confidence:** high &nbsp;·&nbsp; **Verified:** 2026-08-17

**Notes:** The protocol therefore sets no session-length cap. The 20-item probe cap exists to stop the
tutor grinding, not because the learner is presumed to be running out of a resource.
