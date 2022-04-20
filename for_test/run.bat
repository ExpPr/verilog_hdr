del output*
iverilog -o output.vvp test_tb.v
vvp output.vvp
gtkwave output.vcd