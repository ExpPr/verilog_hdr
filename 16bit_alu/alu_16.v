
module add(in1,in2,out);
    input [15:0]in1,in2;
    output [15:0]out;

    assign out=in1+in2;
endmodule

module sub(in1,in2,out);
    input [15:0]in1,in2;
    output [15:0]out;

    assign out=in1-in2;
endmodule

module mul(in1,in2,out);
    input [15:0]in1,in2;
    output [15:0]out;

    assign out=in1*in2;
endmodule

module div(in1,in2,out);
    input [15:0]in1,in2;
    output [15:0]out;

    assign out=in1/in2;
endmodule

module mux41(in1,in2,in3,in4,sel,out);
    input [15:0]in1,in2,in3,in4;
    input [1:0]sel;
    output [15:0]out;

    assign out= sel[1]? (sel[0] ? in4:in3) : (sel[0]? in2:in1);
endmodule

module alu_16 (
    inp1,inp2,sel,out
);
    input [15:0]inp1,inp2;
    input [1:0]sel;
    output [15:0]out;

    wire [15:0]out1,out2,out3,out4;

    add n1(inp1,inp2,out1);
    sub n2(inp1,inp2,out2);
    mul n3(inp1,inp2,out3);
    div n4(inp1,inp2,out4);

    mux41 n5(out1,out2,out3,out4,sel,out);

endmodule