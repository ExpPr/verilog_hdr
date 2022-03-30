del output*
iverilog -o output.vvp rtl/*.v
vvp output.vvp
gtkwave output.vcd