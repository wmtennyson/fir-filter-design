# Synthesis workflow

## Environment

Use a course installation of Synopsys Design Compiler with the official 65 nm library and setup files. The assignment's server paths and environment setup command refer to earlier course years; use the current course-provided paths.

Required target: 0.5 ns clock period (2 GHz). Keep the official constraints, input/output registers, and latency identical between designs.

## Procedure

1. Copy the official reference setup into a reference run directory.
2. Inspect the RTL, library paths, top module, setup script, and SDC constraints. Apply only necessary path corrections allowed by the assignment.
3. From that run directory, invoke:

   ```sh
   dc_shell -f run_dc.tcl
   ```

4. At the `dc_shell` prompt, generate:

   ```tcl
   report_power > power.rpt
   report_qor > qor.rpt
   report_timing > timing.rpt
   ```

5. Copy the setup to a separate proposed-design directory. Replace only the permitted combinational implementation and update the RTL path. Preserve the top-level naming expected by the setup.
6. Run the same flow and report commands. Save each architecture's reports separately.
7. Compare setup slack, power, and area using the same library, constraints, and power activity assumptions. Record whether power uses default/vectorless activity or supplied switching activity.

`report_timing` reports the worst path by default. Check report units before converting timing values to picoseconds. Nonnegative setup slack indicates that the reported path meets its setup constraint.

## Comparison table

Fill this table from actual reports. A dash means no result is available.

| Metric | Reference | Proposed |
| --- | ---: | ---: |
| Worst setup slack (ps) | — | — |
| Total power (report units) | — | — |
| Leakage power (report units) | — | — |
| Combinational area (report units) | — | — |
| Combinational cell count | — | — |
| Total area (report units) | — | — |

Attach or link the final reports and record the tool/library versions, final architecture, clock period, and any remaining violations. Do not check in proprietary libraries or technology data.
