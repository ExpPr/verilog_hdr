del output*
iverilog -o output.vvp operators.v test_tb.v
vvp output.vvp
gtkwave output.vcd