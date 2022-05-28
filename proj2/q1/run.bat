del output*
iverilog -o output.vvp proj2.v proj2_tb.v
vvp output.vvp
gtkwave output.vcd