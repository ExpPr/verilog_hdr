
module comparator (
    in1,in2,g,e,l
);

    input [7:0]in1,in2;
    output g,e,l;
    assign {g,e,l} = (in1>in2) ? 3'b100 : ( (in1==in2) ? 3'b010 : 3'b001);
    
endmodule

module encoder (g,e,l,out);
    input g,e,l;
    output reg [1:0] out;

    always @(g,e,l) begin
        if (g==1) 
            out=2'b01;
        else if (e==0)
            out=2'b00;
        else
            out=2'b10;
    end

endmodule


module top(in1,in2,out);
    input [7:0]in1,in2;
    output [1:0]out;
    wire g,e,l;

    comparator cp1(in1,in2,g,e,l);
    encoder ec1(g,e,l,out);

endmodule