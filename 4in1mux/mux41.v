module mux41 (in,out,sel);
    input [3:0]in;
    input [1:0]sel;
    output reg out;
    always @(*) begin
        case (sel)
            0:out=in[0];
            1:out=in[1];
            2:out=in[2];
            3:out=in[3]; 
        endcase
    end
endmodule

module mux41_4 (
    in1,in2,in3,in4,sel,out
);
    input [3:0]in1,in2,in3,in4;
    input [1:0]sel;
    output [3:0]out;

    mux41 m1(in1,out[0],sel);
    mux41 m2(in2,out[1],sel);
    mux41 m3(in3,out[2],sel);
    mux41 m4(in4,out[3],sel);
    
endmodule