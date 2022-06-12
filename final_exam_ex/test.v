`timescale 1ns/1ns

module xorgate (out1, in1, in2);
input in1, in2;
output out1;

specify
(in1,in2 *>out)=3;
endspecify

assign out1 = in1 ^ in2;

endmodule
module andgate (out1, in1, in2);
input in1, in2;
output out1;
assign out1 = in1 & in2;
specify
(in1 *> out1) = 3;
(in2 *> out1) = 3;
endspecify
endmodule
module orgate (out1, in1, in2);
input in1, in2;
output out1;
assign out1 = in1 | in2;
specify
(in1 *> out1) = 1;
(in2 *> out1) = 1;
endspecify
endmodule

module notgate(out1,in1);
    input in1;
    output out1;


    specify
        (in1 *> out1)=4;
    endspecify

    assign out1=(~in1);

endmodule



module testb();

 reg a, b, c, d;
 wire x, y, z;
 
 xorgate u1 (z, x, y);
 andgate u2 (x, a, b);
 orgate u3 (y, c, d);


 initial begin
 a=0; b=0; c=0; d=0;
 #20 $finish;
 end

 always
 #4 a = ~a;
 always
 #5 b = ~b;
 always
 #6 c = ~c;
 always
 #7 d = ~d;

 initial begin
    $dumpfile("output.vcd");
    $dumpvars(0);
end

endmodule
