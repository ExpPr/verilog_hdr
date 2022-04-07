del output*
iverilog -o output.vvp alu_16.v alu_16_tb.v
vvp output.vvp
gtkwave output.vcd