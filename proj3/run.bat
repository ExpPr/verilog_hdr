del output*
iverilog -o output.vvp cpu.v cpu_tb.v
vvp output.vvp
gtkwave output.vcd