`timescale 1ns/1ns
module test_bench ();
    reg [4:0] in1,in2;
    reg [5:0]out0451;

    initial begin
        //0
        in1=5'b1101;
        in2=5'bx1100;
        out0451=0;
        //1
        #1
        in1=5'bx;
        in2=-2;
        out0451 = in1 && in2;
        //2
        #1
        out0451 = in1||in2;
        //3
        #1
        out0451 = in1&in2;
        //4
        #1
        out0451 = in1|in2;
        //5
        #1
        in1=-10;
        in2=-2;
        out0451 = in1 && in2;
        //6
        #1
        out0451 = in1||in2;
        //7
        #1
        out0451 = in1&in2;
        //8
        #1
        out0451 = in1|in2;
        //9
        #1
        in1=5'b100z;
        in2=5'b1100;
        out0451=(in1<in2);
        //10
        #1
        in1=5'b1xxz;
        in2=5'b1xxx;
        out0451= (in1===in2);
        //11
        #1
        out0451= (in1==in2);
        //12
        #1
        in1=5'b1001x;
        out0451=&in1;
        //13
        #1
        in1=5'b1001x;
        out0451=^in1;
        //14
        #1
        in1=5'b10011;
        out0451=in1;
        out0451=out0451<<<1;
        //15
        #1
        in1=5'b10011;
        in2=0;
        out0451={1'b1,in1};
        //16
        #1 $finish;
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
    
endmodule
