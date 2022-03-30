del out*
iverilog -o output.vvp mux21_tb.v mux21.v
vvp output.vvp
gtkwave output.vcd