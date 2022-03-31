del output*
iverilog -o output.vvp notif1.v notif1_tb.v
vvp output.vvp
gtkwave output.vcd