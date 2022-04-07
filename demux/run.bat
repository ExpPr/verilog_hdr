del output*
iverilog -o output.vvp demux41.v demux41_tb.v
vvp output.vvp
gtkwave output.vcd
