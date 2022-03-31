del output*
iverilog -o output.vvp mux41.v mux41_tb.v
vvp output.vvp
gtkwave output.vcd
