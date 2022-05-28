module b7_to_ascii (
    rst,clk,in,r_out,on,out
);
    output reg [6:0]r_out;
    output reg on;
    input rst,clk,in;
    reg [2:0]count;
    output reg [6:0]out;

    always @(negedge rst, posedge clk) begin
        if (rst==0) begin
            out=0;
            r_out=0;
            on=0;
            count=0;
        end
        else begin
            if (count <= 6) begin
                if (count==0) begin
                    on=0;
                end
            out=out<<1;
            out[0]=in;
                if (count==6) begin
                on=1;
                end
            count=count+1;

            if (count==7) begin
                r_out=out;
                count=0;
            end
            end
        end
    end
endmodule



module b7_to_base64 (
    in,out,active,rst,over,count
);
    input [6:0] in;
    output reg [5:0] out;
    input rst,active,over;
    output reg [2:0] count;//몇 번째


    reg [5:0] remind; //임시저장소

    always @(rst,in,active,over) begin
        if (rst==0) begin
            count=0;
            remind=0;
            out=0;
        end
        else if (active==1 && over==0) begin
            if (count==0) begin
                out=remind;
                {out,remind[5]}=in;
                count=count+1;
            end
            else if (count==1) begin
                out=remind;
                {out[4:0],remind[5:4]}=in;
                count=count+1;
            end
            else if (count==2) begin
                out=remind;
                {out[3:0],remind[5:3]}=in;
                count=count+1;
            end
            else if (count==3) begin
                out=remind;
                {out[2:0],remind[5:2]}=in;
                count=count+1;
            end
            else if (count==4) begin
                out=remind;
                {out[1:0],remind[5:1]}=in;
                count=count+1;
            end
            else if (count==5) begin
                out=remind;
                {out[0],remind[5:0]}=in;
                count=count+1;
            end
        end
        else if (count==6 && over==0) begin
            out=remind;
            remind=0;
            count=0;
        end
        else if (over==1 && count!=0) begin
            out=remind;
        end
    end
endmodule

module print_out (
    in,out
);
    input [5:0] in;
    output reg [6:0] out;

    always @(in) begin
        if (in<=6'b011001) begin//대문자 알파벳 처리
            out=in+65;
        end
        else if (in<= 6'b110011) begin//소문자 알파벳 처리
            out=in+71;
        end
        else if (in<= 6'b111101) begin//숫자처리
            out = in-4;
        end
        else if (in==6'b111110) begin//'+'문자처리
            out = 7'b0101011;
        end
        else begin// '/'문자처리
            out = 7'b0101111;
        end
    end
    
endmodule

module top_module (
    rst,clk,in,out,over,count,ascii,ascii_on,base64
);
    input rst,clk,in,over;
    output [6:0]out;
    output [2:0] count;
    output [6:0] ascii;
    output ascii_on;
    output [5:0]base64;
    wire [6:0] mid_ascii;
    wire [5:0] mid_contact;
    wire on;


    b7_to_ascii tst(rst,clk,in,,on,mid_ascii);
    assign ascii=mid_ascii;
    assign ascii_on=on;
    b7_to_base64 rl(mid_ascii,mid_contact,on,rst,over,count);
    assign base64=mid_contact;
    print_out final(mid_contact,out);



    
endmodule