`timescale 1ns/1ns
module add41_tb();
    reg [3:0]a,b;
    wire[3:0]sum;
    wire cout;

    add4b1 a12(sum,cout,a,b);

    initial begin
        a=0;
        b=0;
        #16 $finish;
    end

    always begin
        #1
        a=$random;
        b=$random;
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
endmodule