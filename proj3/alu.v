module adder #(
    parameter inp1_size=16
) (
    input [inp1_size-1:0]rt,
    input [inp1_size-1:0]rd,
    output reg [inp1_size-1:0]out,
    output reg zeroflag
);
    always @(*) begin
        out = rt+rd;
        zeroflag=(out==0)?1:0;
    end
endmodule

module substractor  (
    input [15:0]rt,
    input [15:0]rd,
    output reg [15:0]out,
    output reg zeroflag
);
    always @(*) begin
        out = rt-rd;
        zeroflag=(out==0)?1:0;
    end
endmodule

module bitwise_and(
    input [15:0]rt,
    input [15:0]rd,
    output reg [15:0]out,
    output reg zeroflag
);
    always @(*) begin
        out = rt&rd;
        zeroflag=(out==0)?1:0;
    end

endmodule

module bitwise_or(
    input [15:0]rt,
    input [15:0]rd,
    output reg [15:0]out,
    output reg zeroflag
);
    always @(*) begin
        out = rt|rd;
        zeroflag=(out==0)?1:0;
    end

endmodule

module slt_operator(
    input [15:0]rt,
    input [15:0]rd,
    output reg [15:0]out,
    output reg zeroflag
    );

    always @(*) begin
        if (rt<rd) out=16'd1;
        else out=16'd0;

        zeroflag=(out==0)?1:0;
    end

endmodule

module multiply(
    input [15:0]rt,
    input [15:0]rd,
    output reg [15:0]out,
    output reg zeroflag
);
    always @(*) begin
        out = rt*rd;
        zeroflag=(out==0)?1:0;
    end

endmodule

module dividor(
    input [15:0]rt,
    input [15:0]rd,
    output reg [15:0]out,
    output reg zeroflag
);
    reg [31:0] temp;//임시저장소

    always @(*) begin
        temp={16'b0,rt};
        repeat(16) begin
            if (temp[31:16]<rd) temp=temp<<1;
            if (temp[31:16]>=rd) begin
                temp[0]=1;
                temp[31:16]=temp[31:16]-rd;
             end
        end
        out=temp[15:0];
        zeroflag=(out==0)?1:0;
    end;
endmodule

module mux_7out #(
    parameter bitsize=16
) ( input [bitsize-1:0]a0,a1,a2,a3,a4,a5,a6,
    input [2:0]sel,
    output reg [bitsize-1:0] out);

    always @(*) begin
        case(sel)
            0:out=a0;
            1:out=a1;
            2:out=a2;
            3:out=a3;
            4:out=a4;
            5:out=a5;
            6:out=a6;
        endcase
    end
endmodule

module alu (//합성가능 확인완료
    input [15:0]rt,
    input [15:0]rd,
    input [2:0]alu_ctrl,
    output [15:0]result,
    output zero
);
    wire zeroflag[6:0];
    wire [15:0]cr[6:0];

    adder #(16) c0(rt,rd,cr[0],zeroflag[0]);
    substractor c1(rt,rd,cr[1],zeroflag[1]);
    bitwise_and c2(rt,rd,cr[2],zeroflag[2]);
    bitwise_or c3(rt,rd,cr[3],zeroflag[3]);
    slt_operator c4(rt,rd,cr[4],zeroflag[4]);
    multiply c5(rt,rd,cr[5],zeroflag[5]);
    dividor c6(rt,rd,cr[6],zeroflag[6]);

    mux_7out #(16) cal_to_out(cr[0],cr[1],cr[2],cr[3],cr[4],cr[5],cr[6],alu_ctrl,result);
    mux_7out #(1) zero_to_out(zeroflag[0],zeroflag[1],zeroflag[2],zeroflag[3],zeroflag[4],zeroflag[5],zeroflag[6],alu_ctrl,zero);


endmodule