`timescale 1ns/1ns

module testb();

    integer i;

    reg [15:0]a,b;
    reg [1:0]sel;
    wire [15:0] out0451;
    wire ov;

    //reg[3:0]a,b;
    wire outs;
    //wire[3:0] out;
    //(a,b,cin,ov,s)

    ALU16bit t1(a,b,sel,ov,out0451);

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end

    initial begin
        sel=0;
        a=$urandom;
        b=$urandom;
        for (i=0;i<7;i=i+1) begin
            #10
            a=($urandom%32768);
            b=($urandom%32768);
        end
        //의도적인 overflow발생
        #10
        a=62000;
        b=12345;
        #10
        a=15493;
        b=61000;
        #10

        sel=1;
        a=$random;
        b=$random;
        for (i=0;i<7;i=i+1) begin
            #10
            a=($random%32768);
            b=($random%32768);
        end
        //의도적인 overflow발생
        #10
        a=-32760;
        b=10;
        #10
        a=32760;
        b=-280;
        #10

        sel=2;
        a=$urandom;
        b=$urandom;
        for (i=0;i<7;i=i+1) begin
            #10
            a=($urandom%256);
            b=($urandom%256);
        end
        //의도적인 overflow발생
        #10
        a=800;
        b=1000;
        #10
        a=32768;
        b=2;
        #10

        sel=3;
        a=$urandom;
        b=$urandom;
        for (i=0;i<7;i=i+1) begin
            #10
            a=($urandom%32768);
            b=($urandom%500);
        end
        //의도적인 overflow발생
        #10
        a=1234;
        b=0;
        #10
        a=5324;
        b=0;
        #10
        $finish;
    end

endmodule
