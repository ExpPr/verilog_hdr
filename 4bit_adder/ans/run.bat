del output*
iverilog -o output.vvp add41.v add41_tb.v
vvp output.vvp
gtkwave output.vcd