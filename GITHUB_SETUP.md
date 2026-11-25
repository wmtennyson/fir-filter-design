# Collaboration setup

Repository: https://github.com/wmtennyson/fir-filter-design

## Clone and run

```sh
git clone https://github.com/wmtennyson/fir-filter-design.git
cd fir-filter-design
make sim
```

Install Icarus Verilog (`iverilog` and `vvp`) and Make before running the simulation target.

## Working together

Use a separate branch for each implementation change:

```sh
git switch -c improve-final-adder
# Edit the design, then run make sim.
git add rtl/ tb/ docs/ results/
git commit -m "Describe the implementation change"
git push -u origin improve-final-adder
```

Open a pull request and review the automated simulation result before merging. Obtain the course's official Design Compiler setup separately for synthesis.

William can add Aydan as a collaborator in Settings > Collaborators using his confirmed GitHub handle. Both team members are credited in the README; no invitation has been sent automatically.
