del output*
iverilog -o output.vvp proj2_q2.v proj2_q2_tb.v
vvp output.vvp
gtkwave output.vcd