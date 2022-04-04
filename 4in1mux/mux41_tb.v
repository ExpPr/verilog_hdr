`timescale 1ns/1ns
module mux41_tb ();
    reg [3:0]in1,in2,in3,in4;
    reg [1:0]sel;
    wire [3:0]z_0451;
    integer i;
    mux41_4 main_mux_set(in1,in2,in3,in4,sel,z_0451);

    initial begin
        sel=0;
        in1=$random;
        in2=$random;
        in3=$random;
        in4=$random;
        #4 $finish;
    end

    always @(*) begin
        for (i=0;i<4;i=i+1)
        begin
            #1
            sel=sel+1;
        end

    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
    
endmodule