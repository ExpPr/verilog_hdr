`timescale 1ns/100ps

module proj2_tb();
    parameter test1_size = 84;
    reg clk,in,reset;
    reg [test1_size-1:0]stream;
    wire on;
    wire [6:0] out_0451;
    reg [7:0] count;
    integer i;

    //bit7_to_ascii tst(reset,clk,stream[i],out);
    b7_to_ascii tst(reset,clk,stream[i],out_0451,on,);

    initial begin
        stream=84'b100100011001011101100110110011011111011111101011111011111110010110110011001000101011;
        reset=0;
        clk=0;
    end

    always #0.5 clk=~clk;

    always @(posedge on) begin
        $display("%c",out_0451);
    end

    initial begin
        #4
        reset=1;

        for (i=test1_size-1;i>=0;i=i-1) begin
            #1;
        end
        #1
        $finish;
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
        
    end
endmodule