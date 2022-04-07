module demux41 (
    in,sel,out1,out2,out3,out4
);

input [3:0]in;
input [1:0]sel;

output reg [3:0]out1,out2,out3,out4;

always @(*) begin
    case (sel)
    0:begin out1=in;
        out2=0;
        out3=0;
        out4=0;
    end
    1:begin
        out1=0;
        out2=in;
        out3=0;
        out4=0;
    end
    2:begin 
        out1=0;
        out2=0;
        out4=0;
        out3=in;
    end
    3:begin 
        out4=in;
        out1=0;
        out2=0;
        out3=0;
    end
    endcase
end
    
endmodule