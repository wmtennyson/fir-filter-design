# Project completion checklist

Team: William Tennyson and Aydan Olaez.

## 1. Confirm the specification

- [ ] Confirm unsigned versus signed operation with the current assignment.
- [ ] Confirm the current deadline, required flow, and reference design on the course server.
- [ ] Identify which original archive files the team modified, preserving course attribution.
- [ ] Agree on each member's responsibilities and record actual contributions below.

The included candidate and automated testbench implement unsigned operation. A signed implementation requires explicit sign extension and matching signed tests.

## 2. Establish correctness

- [ ] Run `make sim` with Icarus Verilog installed.
- [ ] Confirm all widths (1, 4, and 16) pass; save the simulator version and log.
- [ ] Review a waveform for tap history, reset, and output latency if helpful.
- [ ] Repeat verification after every RTL architecture change.

The new testbench checks the supplied unsigned reference and the new carry-save candidate independently against a behavioral model. It covers zeros, maximum values, alternating extremes, an impulse, random data, and reset during operation. It exits with a failure on a mismatch or timeout.

## 3. Measure the baseline

- [ ] Obtain the official Design Compiler setup, SDC constraints, and 65 nm library access.
- [ ] Synthesize the official reference at 0.5 ns.
- [ ] Save power, timing, and QoR reports in `results/reference/`.
- [ ] Record tool/library versions, power activity assumptions, and baseline values in `results/metrics.csv`.

The supplied `fir4rca_u` is used for functional comparison. Check that it matches the official synthesis reference before attributing PPA differences to architecture.

## 4. Evaluate candidates

- [ ] Synthesize `fir4_csa` in a separate run directory using the same constraints.
- [ ] Adapt the candidate module name or setup only as permitted by the official flow.
- [ ] Save candidate reports in `results/csa/` and fill in `results/metrics.csv`.
- [ ] Inspect the critical path and infer whether the final carry-propagate adder dominates.
- [ ] If necessary, try a grouped carry-lookahead/prefix final adder or another topology; verify and measure again.
- [ ] Select a final architecture using actual timing, power, and area results.

## 5. Complete the report and project page

- [ ] Add actual contributions below and final architecture details to the README.
- [ ] Replace pending results with measured values and report paths.
- [ ] Complete the report outline in `docs/REPORT_OUTLINE.md` (maximum five pages).
- [ ] Have one partner submit the report; retain the final RTL and reports on the course server.

## Actual contributions

| Member | Contribution |
| --- | --- |
| William Tennyson | To be recorded as work is completed |
| Aydan Olaez | To be recorded as work is completed |
