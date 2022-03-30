`timescale 1ns/1ns
module add41_tb();
    reg [3:0]a,b;
    wire[3:0]sum1,sum2;
    wire cout1,cout2;

    add4b1 a12(sum1,cout1,a,b);
    //모듈내 매개변수들을 재배열할수 있고, 이때 일부 포트를 뺄 수도 있다.

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