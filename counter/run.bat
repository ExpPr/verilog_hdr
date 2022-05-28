del output*
iverilog -o output.vvp counter.v counter_tb.v
vvp output.vvp
gtkwave output.vcd


