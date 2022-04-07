`timescale 1ns/1ns
module alu_16_tb();
    reg [15:0]in1,in2;
    reg [1:0]sel;
    wire [15:0] out;
    integer i;

//2^16 = 65536
    alu_16 total(in1,in2,sel,out);
    initial begin
        in1=400;
        in2=$urandom%250;
        sel=0;
        #4 $finish;
    end

    always @(*) begin
        for (i=0;i<4;i=i+1) begin
            #1
            sel=sel+1;
        end
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
endmodule