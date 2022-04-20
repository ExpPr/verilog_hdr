del output*
iverilog -o output.vvp d-ff_tb.v d-ff.v
vvp output.vvp
gtkwave output.vcd