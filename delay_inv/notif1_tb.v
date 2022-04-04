//https://blog.naver.com/beahey/90166877125
`timescale 10ns/10ns
module notif1_tb();
    reg inp;
    reg ctrl1;
    wire out_0451;

    not1 a(inp,out_0451,ctrl1);
// 
    initial begin
        #40 $finish;
    end
    initial begin

        inp=0;
        ctrl1=1;
        #1 inp=1;
        #1 inp=0;
        #1 inp=1;
        #6 inp=0;
        #10 ctrl1=0;
        #8 ctrl1=1;
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
endmodule

