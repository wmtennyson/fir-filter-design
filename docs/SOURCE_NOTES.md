# Source notes

The SystemVerilog files under `source_snapshot/` were copied byte-for-byte from the supplied `labs_export.zip`. They have been organized into RTL and testbench directories without altering their contents.

The assignment document, EDA Playground screenshot document, and unrelated median-filter example were omitted from this project package.

## Authorship

Team: William Tennyson and Aydan Olaez.

The supplied source files contain course/example headers spanning multiple years. Preserve those headers. The archive alone does not establish which lines were written or modified by the team. Confirm that mapping before adding individual contribution claims or describing the examples as original implementations.

## Known issues and scope

- The handout mixes unsigned and two's-complement specifications. The unsigned reference and unsigned testbench agree on an unsigned sum; confirm the intended signedness for the final project.
- Despite the averaging terminology, the expected result is the full four-sample sum.
- `fir4c_fig11_42_u.sv` declares its tap registers signed despite an unsigned interface. Its reduction uses individual bits; signed declarations alone do not establish signed arithmetic correctness.
- `fir4c_fig11_42_TC.sv` uses a bit-level reduction without explicit sign extension for the extra result bits. Verify negative inputs before relying on it as a signed implementation.
- `csa_with_cla.sv` accesses `csa4_s[w]` and `dr[w]` beyond their declared ranges, and does not assign all bits of `sum`. Its carry recurrence also expresses serial propagation rather than expanded lookahead. Treat this file as an experimental source, not a validated optimized design.
- The original testbenches print a difference but contain no automatic pass/fail assertion.
- Simulation, synthesis, and performance claims require actual runs. No such result is included in the supplied archive.
