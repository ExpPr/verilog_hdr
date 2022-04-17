`timescale 1ns/1ns
module comp_tb (
);

    reg [7:0] in1,in2;
    output[1:0] out;

    top tb(in1,in2,out);

    initial begin
        in1=10;
        in2=23;
        #1
        in1=3;
        in2=1;
        #1
        in1=234;
        in2=234;
        #1 $finish;
    end

    initial begin
        $dumpfile("output.vcr");
        $dumpvars(0);
    end
    
endmodule
