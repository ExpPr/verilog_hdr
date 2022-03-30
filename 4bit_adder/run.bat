del output*
iverilog -o output.vvp add4.v add4_tb.v
vvp output.vvp
gtkwave output.vcd