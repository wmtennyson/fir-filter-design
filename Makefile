IVERILOG ?= iverilog
VVP ?= vvp

.PHONY: sim clean
sim:
	@command -v $(IVERILOG) >/dev/null || { echo "Install Icarus Verilog (iverilog and vvp) first."; exit 1; }
	@mkdir -p build
	@set -e; for width in 1 4 16; do \
	  $(IVERILOG) -g2012 -s tb_fir4 -Ptb_fir4.W=$$width -o build/tb_$$width.vvp \
	    source_snapshot/rtl/fir4rca_u.sv rtl/fir4_csa.sv tb/tb_fir4.sv; \
	  $(VVP) build/tb_$$width.vvp; \
	done

clean:
	rm -rf build
