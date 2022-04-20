del output*
iverilog -o output.vvp task.v task_tb.v
vvp output.vvp
gtkwave output.vcd