`timescale 1ns/1ns
module mux21_tb();
    reg a,b,s;
    wire z1,z2,z3,z4,z5,z6,z7;

    //모듈 이름을 (객체이름) 안넣어도 되지만, 넣는게 이득
    mux21_1 u1(a,b,s,z1);
    mux21_2 u2(a,b,s,z2);
    mux21_3 u3(a,b,s,z3);
    mux21_4 u4(a,b,s,z4);
    mux21_5 u5(a,b,s,z5);
    mux21_6 u6(a,b,s,z6);
    mux21_6 u7(a,b,s,z7);

    initial begin
        a=0;b=0;s=0;
        #10 $finish;
    end

    always begin
        #1 a=~a;
    end

    always begin
        #2 b=~b;
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end


endmodule