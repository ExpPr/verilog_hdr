del output*
iverilog -o output.vvp mid_tb.v
vvp output.vvp
gtkwave output.vcd