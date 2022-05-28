`timescale 1ns/1ns

module counter_tb (
);

    reg rst,on,clk;
    wire [3:0]out1,out2;

    counter15 t1(rst,on,clk,out1);
    counter9 t2(rst,on,clk,out2);

    initial begin
        rst=0;on=0;clk=0;
        #4 rst=1;
        #2 on=1;
        #50 $finish;
    end

    always #1 clk=~clk;

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
    
endmodule