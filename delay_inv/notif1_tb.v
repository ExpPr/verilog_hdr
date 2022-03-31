//https://blog.naver.com/beahey/90166877125
`timescale 10ns/10ns
module notif1_tb();
    reg inp;
    reg ctrl1;
    wire out;

    not1 a(inp,out,ctrl1);
// 
    initial begin
        #60 $finish;
    end
    initial begin
        //blocking
        //게이트의 지연시간보다 짧은 시간동안의 입력 펄스는 무시하여 출력에 영향x
        //오로지 게이트 지연시간보다 큰 pulse 입력에만 반응. 
        //assign #10 out = a&b 이것도 여기에 포함
        inp=0;
        ctrl1=1;
        #1 inp=1;
        #1 inp=0;
        #3 inp=1;
        #4 inp=0;
        #6 inp=1;
        #4 inp=0;
        #8 inp=1;
    end
    initial begin
        #30 ctrl1=0;
        #2 ctrl1=1;
        #2 ctrl1=0;
        #8 ctrl1=1;
        #8 ctrl1=0;
    end
    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
endmodule

