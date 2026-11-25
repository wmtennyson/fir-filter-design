# 4-Tap FIR Filter Design

An ongoing digital design project by William Tennyson and Aydan Olaez for ECE 260A at UC San Diego. We are building and optimizing a registered, 16-bit, four-tap FIR datapath in SystemVerilog, with functional verification and a 65 nm synthesis flow.

**Team:** William Tennyson and Aydan Olaez.

## Overview

The datapath accepts one 16-bit sample per clock cycle, stores four consecutive samples, and registers their 18-bit sum. All four tap coefficients are one:

```math
S = a_r + b_r + c_r + d_r
```

Although the assignment describes an averaging filter, the supplied interface returns the full sum. No division by four is performed.

The project focuses on how carry propagation and adder topology affect timing, power, and area. The target synthesis flow uses Synopsys Design Compiler and a course-provided 65 nm standard-cell library at a 0.5 ns clock period (2 GHz).

## Datapath

At each rising clock edge, the input history advances and the output captures the sum computed from the previously stored samples:

```systemverilog
ar <= a;
br <= ar;
cr <= br;
dr <= cr;
s  <= sum;
```

Reset is synchronous and active high. All architectures must preserve the same interface, registers, and latency. The unsigned sum ranges from 0 to 262140, which fits in 18 bits.

## Development status

Our working implementation is `rtl/fir4_csa.sv`, an unsigned carry-save candidate. The self-checking testbench in `tb/tb_fir4.sv` compares it and the ripple-adder reference against an independent behavioral model.

Next milestones:

- Run functional simulation and review reset behavior and output latency.
- Synthesize the reference and candidate under identical 0.5 ns constraints.
- Compare timing, power, and area; refine the final adder if needed.
- Complete the architecture comparison and final project report.

See [our project checklist](docs/PROJECT_PLAN.md) for the full task list.

Install Icarus Verilog, then run:

```sh
make sim
```

The Makefile checks widths 1, 4, and 16. GitHub Actions is configured to run the same checks on pushes and pull requests. [The first GitHub Actions simulation run passed](https://github.com/wmtennyson/fir-filter-design/actions/runs/45711021919), checking widths 1, 4, and 16. Synthesis results are pending.

See [collaboration setup](GITHUB_SETUP.md) to clone the project and run the checks.

## Architectures in the source snapshot

| Architecture | Module | Structure |
| --- | --- | --- |
| Ripple-adder tree | `fir4rca_u` | Two parallel 16-bit ripple additions followed by a final addition |
| Cascaded ripple adders | `fir4rca_cas_u` | Three serial additions with increasing operand width |
| Carry-save reduction | `fir4c_fig11_42` | Two carry-save reduction stages and one final carry-propagate addition |
| Signed carry-save example | `fir4c_fig11_42_TC` | Supplied signed variant; correctness requires verification |
| Experimental carry-save/final-adder variant | `fir4csa` | Supplied work-in-progress source; see known issues |

Carry-save reduction postpones carry propagation until the final addition. Whether an architecture improves the synthesized implementation must be established from reports under identical constraints.

## Repository layout

| Path | Purpose |
| --- | --- |
| `rtl/fir4_csa.sv` | Editable unsigned carry-save candidate |
| `tb/tb_fir4.sv` | Automated comparison against the reference and behavioral model |
| `source_snapshot/` | Unchanged original FIR RTL and testbenches |
| `docs/` | Completion checklist, synthesis workflow, source notes, and report outline |
| `results/` | Pending metrics and space for actual reports |
| `Makefile` | Reproducible functional simulation command |
| `.github/workflows/` | Automated simulation workflow |

## Simulating the unsigned reference

For a Questa/ModelSim installation, run these commands from the repository root:

```sh
vlib work
vlog -sv source_snapshot/rtl/fir4rca_u.sv source_snapshot/tb/project_tb2_u.sv
vsim -c project_tb2_u -do 'run -all; quit -f'
```

The supplied testbench applies 25 random samples and prints the DUT output, behavioral reference output, and `dif1`. Check that `dif1` is zero after reset; the original testbench does not automatically fail on mismatches. Use an explicit simulator time unit and precision if required by your tool configuration.

To simulate another architecture, change the DUT instance in the corresponding testbench and compile the matching RTL. Do not compile every design and testbench into a single simulation by default.

Recommended additional checks include all-zero samples, maximum inputs, alternating zero/maximum values, reset during operation, and signed limits when evaluating signed designs.

## Synthesis and results

See [the synthesis workflow](docs/SYNTHESIS.md) for the report commands and metric table. The 65 nm library, official constraints, and course setup scripts are external dependencies and are not included.

**Verification:** the automated functional simulation passed for widths 1, 4, and 16. Synthesized netlists and measured timing, power, and area results are pending. The 2 GHz value is our synthesis target.

## Team and source attribution

**William Tennyson and Aydan Olaez** — ECE 260A project team.

Course-provided reference RTL and example testbenches are preserved under `source_snapshot/` with their original headers. Active implementation and verification work lives under `rtl/` and `tb/`. Actual member contributions are tracked in [the project checklist](docs/PROJECT_PLAN.md).

See [source notes](docs/SOURCE_NOTES.md) for reference-file details and known issues. Course-provided files retain their original attribution.
