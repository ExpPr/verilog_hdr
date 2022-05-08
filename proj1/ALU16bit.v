module mux_16bit(a,b,c,d,sel,out);
    input[15:0]a,b,c,d;
    input [1:0]sel;
    output [15:0]out;

    assign out=sel[1] ? (sel[0] ? a:b) : (sel[0] ? c:d);
    
endmodule

module mux_1bit(a,b,c,d,sel,out);
    input a,b,c,d;
    input [1:0]sel;
    output out;

    assign out = sel[1] ? (sel[0] ? a:b) : (sel[0] ? c:d);
endmodule


module fa1(a,b,cin,cout,s);
    input a,b,cin;
    output cout,s;

    wire w1,w2,w3;

    xor a1(w1,a,b);
    and a2(w2,a,b);
    and a3(w3,cin,w1);
    xor a4(s,w1,cin);
    or a5(cout,w3,w2);

endmodule

module sp_mux2_1 (// 하나는 피승수 , 다른 하나는 0
    a,b,out
);

    input [15:0]a;
    input b;
    output [15:0] out;

    assign out = b?a:0;

endmodule


module fa4(a,b,cin,cout,s);

    input [3:0]a,b;
    input cin;
    output cout;
    output [3:0] s;

    wire c1,c2,c3;

    fa1 a1(a[0],b[0],cin,c1,s[0]);
    fa1 a2(a[1],b[1],c1,c2,s[1]);
    fa1 a3(a[2],b[2],c2,c3,s[2]);
    fa1 a4(a[3],b[3],c3,cout,s[3]);
endmodule


module fa16(a,b,cin,cout,s);
    input [15:0]a,b;
    input cin;
    output cout;
    output [15:0]s;
    //cout = overflow
    wire c1,c2,c3;

    fa4 a41(a[3:0],b[3:0],cin,c1,s[3:0]);
    fa4 a42(a[7:4],b[7:4],c1,c2,s[7:4]);
    fa4 a43(a[11:8],b[11:8],c2,c3,s[11:8]);
    fa4 a44(a[15:12],b[15:12],c3,cout,s[15:12]);

endmodule

module fa32(a,b,cin,cout,s);
    input [31:0]a,b;
    input cin;
    output cout;
    output [31:0]s;

    wire c1;

    fa16 a16_1(a[15:0],b[15:0],cin,c1,s[15:0]);
    fa16 a16_2(a[31:16],b[31:16],c1,cout,s[31:16]);
endmodule




module sub4(a,b,cin,sel,cout,ov,s);
    input [3:0]a,b;
    input cin,sel;
    output cout,ov;
    output [3:0] s;

    wire c1,c2,c3;

    fa1 sa1(a[0],b[0]^sel,cin,c1,s[0]);
    fa1 sa2(a[1],b[1]^sel,c1,c2,s[1]);
    fa1 sa3(a[2],b[2]^sel,c2,c3,s[2]);
    fa1 sa4(a[3],b[3]^sel,c3,cout,s[3]);

    xor ov2 (ov,cout,c3);

endmodule

module sub16(a,b,ov,s);
    input [15:0]a,b;
    output ov;
    output [15:0]s;

    wire c1,c2,c3;

    sub4 s1(a[3:0],b[3:0],1'b1,1'b1,c1,,s[3:0]);
    sub4 s2(a[7:4],b[7:4],c1,1'b1,c2,,s[7:4]);
    sub4 s3(a[11:8],b[11:8],c2,1'b1,c3,,s[11:8]);
    sub4 s4(a[15:12],b[15:12],c3,1'b1,,ov,s[15:12]);

endmodule


module multiplyer(a,b,cin,cout,s);
    input [15:0]a,b;
    input cin;
    output cout;
    output [15:0]s;

    wire [15:0] aug [15:0];
    wire [31:0] shift [15:0];
    wire [31:0] partial_add[14:0];
    wire [15:0]c32_out;


    //먼저 부분적을 전부 구함 (단 shift 고려 x)
    sp_mux2_1 sp1(a,b[0],aug[0]);
    sp_mux2_1 sp2(a,b[1],aug[1]);
    sp_mux2_1 sp3(a,b[2],aug[2]);
    sp_mux2_1 sp4(a,b[3],aug[3]);
    sp_mux2_1 sp5(a,b[4],aug[4]);
    sp_mux2_1 sp6(a,b[5],aug[5]);
    sp_mux2_1 sp7(a,b[6],aug[6]);
    sp_mux2_1 sp8(a,b[7],aug[7]);
    sp_mux2_1 sp9(a,b[8],aug[8]);
    sp_mux2_1 sp10(a,b[9],aug[9]);
    sp_mux2_1 sp11(a,b[10],aug[10]);
    sp_mux2_1 sp12(a,b[11],aug[11]);
    sp_mux2_1 sp13(a,b[12],aug[12]);
    sp_mux2_1 sp14(a,b[13],aug[13]);
    sp_mux2_1 sp15(a,b[14],aug[14]);
    sp_mux2_1 sp16(a,b[15],aug[15]);

    //전부 n칸씩 이동.
    assign shift[0]=aug[0];
    assign shift[1]=aug[1]<<1;
    assign shift[2]=aug[2]<<2;
    assign shift[3]=aug[3]<<3;
    assign shift[4]=aug[4]<<4;
    assign shift[5]=aug[5]<<5;
    assign shift[6]=aug[6]<<6;
    assign shift[7]=aug[7]<<7;
    assign shift[8]=aug[8]<<8;
    assign shift[9]=aug[9]<<9;
    assign shift[10]=aug[10]<<10;
    assign shift[11]=aug[11]<<11;
    assign shift[12]=aug[12]<<12;
    assign shift[13]=aug[13]<<13;
    assign shift[14]=aug[14]<<14;
    assign shift[15]=aug[15]<<15;

    
    //전부 그 n칸씩 이동한걸 다 더함
    fa32 f32_0(shift[0],shift[1],1'b0,,partial_add[0]);
    fa32 f32_1(partial_add[0],shift[2],1'b0,,partial_add[1]);
    fa32 f32_2(partial_add[1],shift[3],1'b0,,partial_add[2]);
    fa32 f32_3(partial_add[2],shift[4],1'b0,,partial_add[3]);
    fa32 f32_4(partial_add[3],shift[5],1'b0,,partial_add[4]);
    fa32 f32_5(partial_add[4],shift[6],1'b0,,partial_add[5]);
    fa32 f32_6(partial_add[5],shift[7],1'b0,,partial_add[6]);
    fa32 f32_7(partial_add[6],shift[8],1'b0,,partial_add[7]);
    fa32 f32_8(partial_add[7],shift[9],1'b0,,partial_add[8]);
    fa32 f32_9(partial_add[8],shift[10],1'b0,,partial_add[9]);
    fa32 f32_10(partial_add[9],shift[11],1'b0,,partial_add[10]);
    fa32 f32_11(partial_add[10],shift[12],1'b0,,partial_add[11]);
    fa32 f32_12(partial_add[11],shift[13],1'b0,,partial_add[12]);
    fa32 f32_13(partial_add[12],shift[14],1'b0,,partial_add[13]);
    fa32 f32_14(partial_add[13],shift[15],1'b0,,partial_add[14]);

    //하위 16bit가 출력값, 상위 16bit는 overflow 판정여부

    assign s=partial_add[14][15:0];
    assign cout=(partial_add[14][31:16]==0)?0:1;

endmodule

module divider(a,b,out,ov);
    input [15:0]a,b;
    output [15:0]out;
    output ov;

    reg [31:0] temp;
    reg [15:0] q;
    reg [15:0] dividor;

    always @(a,b) begin
        q=a;
        dividor=b;
        temp={16'b0,q};

        //pdf에 제시된 방식이용 , 16bit -> 16번반복
        
        repeat (16) begin
            if (temp[31:16] < dividor ) begin //상위 16bit가 dividor보다 작으면 <<1 적용
                temp=temp<<1;
                if (temp[31:16]>=dividor) begin //아닌경우 lsb =1 , 그리고 상위 16bit 값을 dividor만큼 제함
                    temp[0]=1;
                    temp[31:16]=temp[31:16]-dividor;
                end
        end
    end
end
//하위 16bit가 몫 , b==0 인 경우 , ov판정 on 
    assign out=temp[15:0];
    assign ov= (b==0)?1:0;
endmodule


module ALU16bit(a,b,sel,ov,out);
    input [15:0]a,b;
    input [1:0]sel;
    output ov;
    output [15:0]out;

    wire [15:0] add,sub,mul,div;
    wire ov1,ov2,ov3,ov4;

    fa16 alu_add(a,b,1'b0,ov1,add);
    sub16 alu_sub(a,b,ov2,sub);
    multiplyer alu_mul(a,b,1'b0,ov3,mul);
    divider alu_div(a,b,div,ov4);

    mux_16bit alu_mux16(div,mul,sub,add,sel,out);
    mux_1bit alu_mux1(ov4,ov3,ov2,ov1,sel,ov);



    
endmodule