`timescale 1ns/1ns
module nand_tb();
    wire out1;
    reg a, b;

    nand1 n1(out1, a, b);
    //매 1ns마다 a값 반전
    always begin
        #1 a=~a;
    end
    //매 2ns마다 b값 반전
    always begin
        #2 b=~b;
    end
    //초기값설정
    initial begin
        a=0;
        b=0;
        #8 $finish; //8ns에 종료
    end

    initial begin
        $display("Hello World!");
    end

    initial begin
        $dumpfile("output.vcd");
	    $dumpvars(0);
    end
endmodule