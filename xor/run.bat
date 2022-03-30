del out*
iverilog -o output.vvp XORgate.v XORgate_tb.v
vvp output.vvp
gtkwave output.vcd

