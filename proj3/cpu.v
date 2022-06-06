`timescale 1ns/100ps

module alu (//합성가능 확인완료
    input [15:0]rt,
    input [15:0]rd,
    input [2:0]alu_ctrl,
    output reg [15:0]result,
    output zero,
    output reg ov
);
    reg [31:0] temp;//div 전용 임시 reg 

    always @(*) begin
        ov=0;
        case (alu_ctrl)
            0 : {ov,result}=rt+rd;//add
            1 : {ov,result}=rt-rd;//sub
            2 : result=rt&rd;//bitwise and
            3 : result=rt|rd;//bitwise or
            4 : begin
                if (rt<rd) result=16'd1;
                else result=16'd0;  
            end
            5 : {ov,result}=rt*rd;//mul
            6 : begin//div
                temp={16'b0,rt};
                repeat(16) begin
                    if (temp[31:16]<rd) temp=temp<<1;
                    if (temp[31:16]>=rd) begin
                        temp[0]=1;
                        temp[31:16]=temp[31:16]-rd;
                    end
                end
                result=temp[15:0];
                ov=(rd==0)?1:0;
            end
        endcase
    end

    assign zero=(result==0)?1:0;
endmodule

module data_memory(//메모리,합성성공
    input [15:0] data, addr,
    input clk, rst, we, re,
    output [15:0] strm
);   
    integer i;

    reg [15:0] memories[127:0];//실제 데이터 메모리

    always @(posedge clk,negedge rst) begin
        if (~rst) begin
            memories[0]<=16'b0000000000000000;
            memories[1]<=16'b0000000000100011;
            memories[2]<=16'b0000000000001001;
            memories[3]<=16'b0000000000110001;
            memories[4]<=16'b0000000011001001;
            memories[5]<=16'b0000000000111100;
            memories[6]<=16'b0000000011011011;
            memories[7]<=16'b0000000000000111;
            memories[8]<=16'b1110000100101000;
            memories[9]<=16'b0101001111000101;
            memories[10]<=16'b1001011110001001;
            memories[11]<=16'b1101001111011111;
            memories[12]<=16'b1011100110010001;
            memories[13]<=16'b0000010001100101;
            memories[14]<=16'b0001110001010110;
            memories[15]<=16'b0001001011100100;
            memories[16]<=16'b0110100000111001;
            memories[17]<=16'b1111100000101011;
            memories[18]<=16'b0011110101111001;
            memories[19]<=16'b1011000001110001;
            memories[20]<=16'b0010000111100110;
            memories[21]<=16'b1101000011001010;
            memories[22]<=16'b0111011100001110;
            memories[23]<=16'b1111110110111001;

            for (i=24;i<128;i=i+1) begin
                memories[i]<=0;
            end

        end
        else if (we) begin
            memories[addr]<=data;
        end
    end
    assign strm=(re)?memories[addr]:0;
endmodule


module register(//레지스터,합성성공
    input [2:0] rs_loc, rt_loc, write_reg_loc,
    input [15:0] write_reg_data,
    input rst,clk, reg_write,
    output [15:0] rs, rt
);
    reg [15:0] internal_reg [7:0];

    always @(posedge clk,negedge rst) begin
        if (~rst) begin
            internal_reg[0]<=0;
            internal_reg[1]<=0;
            internal_reg[2]<=0;
            internal_reg[3]<=0;
            internal_reg[4]<=0;
            internal_reg[5]<=0;
            internal_reg[6]<=0;
            internal_reg[7]<=0;
        end
        else if(reg_write) begin
            internal_reg[write_reg_loc]<=write_reg_data;
        end
    end
    
    assign rs=(rs_loc==0 || rs_loc==6)?0:internal_reg[rs_loc];//$0 , $6은 항상 0임을 고려
    assign rt=(rt_loc==0 || rt_loc==6)?0:internal_reg[rt_loc];//$0 , $6은 항상 0임을 고려


endmodule

module control (//합성성공
    input [2:0]instruction,//instruction[15:13]
    input rst,
    output reg [1:0] regDst,mem_to_reg,aluOp,
    output reg aluSrc,reg_write,mem_read,mem_write,branch,jump
);
    always @(*) begin
        if (~rst) begin
            regDst=0;
            aluSrc=0;
            mem_to_reg=0;
            reg_write=0;
            mem_read=0;
            mem_write=0;
            branch=0;
            aluOp=0;
            jump=0;
        end

        else begin
            case(instruction) 
                0:begin//R-type
                    regDst=1;
                    aluSrc=0;
                    mem_to_reg=0;
                    reg_write=1;
                    mem_read=0;
                    mem_write=0;
                    branch=0;
                    aluOp=0;
                    jump=0;
                end
                1:begin//slti
                    regDst=0;
                    aluSrc=1;
                    mem_to_reg=0;
                    reg_write=1;
                    mem_read=0;
                    mem_write=0;
                    branch=0;
                    aluOp=2;
                    jump=0;
                end
                2:begin//j - jump
                    regDst=0;
                    aluSrc=0;
                    mem_to_reg=0;
                    reg_write=0;
                    mem_read=0;
                    mem_write=0;
                    branch=0;
                    aluOp=0;
                    jump=1;
                end
                3:begin// jal - jump and link
                    regDst=2;
                    aluSrc=0;
                    mem_to_reg=2;
                    reg_write=1;
                    mem_read=0;
                    mem_write=0;
                    branch=0;
                    aluOp=0;
                    jump=1;
                end
                4:begin//lw
                    regDst=0;
                    aluSrc=1;
                    mem_to_reg=1;
                    reg_write=1;
                    mem_read=1;
                    mem_write=0;
                    branch=0;
                    aluOp=3;
                    jump=0;
                end
                5:begin//sw - store 
                    regDst=0;
                    aluSrc=1;
                    mem_to_reg=0;
                    reg_write=0;
                    mem_read=0;
                    mem_write=1;
                    branch=0;
                    aluOp=3;
                    jump=0;
                end
                6:begin//beq - equal -> jump+4+?
                    regDst=0;
                    aluSrc=0;
                    mem_to_reg=0;
                    reg_write=0;
                    mem_read=0;
                    mem_write=0;
                    branch=1;
                    aluOp=1;
                    jump=0;
                end
                7:begin//addi - 직접값을 이용한 addi
                    regDst=0;
                    aluSrc=1;
                    mem_to_reg=0;
                    reg_write=1;
                    mem_read=0;
                    mem_write=0;
                    branch=0;
                    aluOp=3;
                    jump=0;
                end
            endcase
        end
    end
endmodule

module alu_control(//합성성공
    input [3:0] instruction,//instrucion[3:0]영역
    input [1:0] aluop,//control의 aluop
    output reg [2:0] alu_sel
);

    always @(instruction,aluop) begin
        if (aluop==2'b11) begin
            alu_sel=3'b000;
        end
        else if (aluop==2'b01) begin
            alu_sel=3'b001;
        end
        else if (aluop==2'b00) begin
            case (instruction)
            0:alu_sel=3'b000;//add
            1:alu_sel=3'b001;//sub
            2:alu_sel=3'b010;//and
            3:alu_sel=3'b011;//or
            4:alu_sel=3'b100;//slt
            5:alu_sel=3'b101;//mul
            6:alu_sel=3'b110;//div
            endcase
        end
        else begin
            alu_sel=3'b100;
        end
    end
endmodule

module jr_ctrl(//instruction[3:0]=8 && aluop==0인 경우에 대한 처리, 합성가능
    input[3:0] instruction,//[3:0]
    input[1:0] aluop,//
    output jr_out
);
    assign jr_out=({aluop,instruction}==6'b001000) ?1:0;
endmodule

module sign_extend(//합성가능
    input [6:0]instruction,
    output [12:0] extended_instruction
);
    assign extended_instruction=instruction;
endmodule

module adder #(
    parameter inp1_size=16
) (
    input [inp1_size-1:0]a,
    input [inp1_size-1:0] b,
    output reg [inp1_size-1:0]out
);

    always @(*) begin
        out <= a+b;
    end
    
endmodule


module mux_3out #(//입력 - 출력 크기를 parameter로 조정. 2번 사용됨,합성성공
    parameter bitsize=16
) (
    input [bitsize-1:0] a1,a2,a3,
    input [1:0] sel,
    output [bitsize-1:0] out
);
    
   assign out = (sel==0) ? a1 : ( (sel==1) ? a2 : a3);
endmodule

module mux_2out #(//입력은 16bit이나 출력크기를 조정. 조정이 되는 경우는 최종 pc출력할 때,합성성공
    parameter out_bitsize=16
) (
    input [out_bitsize-1:0] a,b,
    input sel,
    output [out_bitsize-1:0] out
);
    assign out = (sel) ? b:a;
    
endmodule

module instruction_memory (//합성성공
    input [12:0]pc,j_or_branchpc,
    input rst,clk,jump,branch,jr_sel,
    output reg [15:0]instruct
);
    reg [15:0] saved_instruct [23:0];
    reg [12:0] select_pc;

    always @(negedge rst,posedge clk) begin
        if (~rst) begin
            saved_instruct[0]=16'b1001100100000001;
            saved_instruct[1]=16'b1001100110000010;
            saved_instruct[2]=16'b0000100111000000;
            saved_instruct[3]=16'b0000100110010100;
            saved_instruct[4]=16'b1100010000000010;
            saved_instruct[5]=16'b0000100111000010; 
            saved_instruct[6]=16'b0100000000001000;
            saved_instruct[7]=16'b0000100111000001;
            saved_instruct[8]=16'b0000100111000011;
            saved_instruct[9]=16'b0110000000001101;
            saved_instruct[10]=16'b1111001000000010;
            saved_instruct[11]=16'b1011101000000011;
            saved_instruct[12]=16'b0100000000001111;
            saved_instruct[13]=16'b0000100111000110;
            saved_instruct[14]=16'b0001110000001000;
            saved_instruct[15]=16'b0000000000000000;
            saved_instruct[16]=16'b0000000000000000;
            saved_instruct[17]=16'b0000000000000000;
            saved_instruct[18]=16'b0000000000000000;
            saved_instruct[19]=16'b0000000000000000;
            saved_instruct[20]=16'b0000000000000000;
            saved_instruct[21]=16'b0000000000000000;
            saved_instruct[22]=16'b0000000000000000;
            saved_instruct[23]=16'b0000000000000000;

            instruct=0;
        end

        else begin
            if (jump||branch||jr_sel) begin
                select_pc=j_or_branchpc;
            end
            else begin
                select_pc=pc;
            end
            instruct=saved_instruct[select_pc];
        end
    end
endmodule

module pc_ctrl(//합성가능
    input rst,clk,jump,branch,
    input [12:0] nextpc,
    output reg [12:0] pc
);

    always @(negedge rst,posedge clk) begin
        if (~rst) begin
            pc<=13'd0;
        end
        else begin
            pc<=nextpc;
            pc<=nextpc;

        end
    end

endmodule


module cpu(
    input rst,clk,
    output [15:0] act_instruction
);

    wire [12:0]pc_current,pc_next,pc_add1;
    wire [15:0]instruction;

    //control 출력wire들
    wire [1:0] regdst,mem_to_reg,aluop;
    wire alusrc,reg_write,mem_read,mem_write,branch,jump;

    //register write 전용
    wire [2:0]sel_reg_write_loc_output;
    wire [15:0]reg_write_data;
    //register output
    wire [15:0] rs,rt;

    //extend
    wire [12:0] sign_extendion;

    //alu_ctrl출력
    wire [2:0]alu_sel;
    //jr_ctrl결과
    wire jr_sel;

    wire [15:0]sel_imm_result;

    wire [15:0] alu_result;
    wire zeroflag; 

    //
    wire [12:0] beq_cal_result;
    wire [12:0] beqpc1,selected_j_or_beqpc1;


    wire [15:0] write_data_mid;


    //pc값 설정
    pc_ctrl pc_to_instruct(rst,clk,jump,branch,pc_next,pc_current);

    //pc값 1추가되는 연산 하기
    adder #(13) pc_1_adder(pc_current,13'd1,pc_add1);

    //instruciton 호출
    instruction_memory inst(pc_current,pc_next,rst,clk,jump,branch,jr_sel,instruction);
    assign act_instruction=instruction;

    //control 시행
    control ctrl(instruction[15:13],rst,regdst,mem_to_reg,aluop,alusrc,reg_write,mem_read,mem_write,branch,jump);
    //register_write주소 결정
    mux_3out #(3) sel_reg_write_loc (instruction[9:7],instruction[6:4],3'b111,regdst,sel_reg_write_loc_output);
    //register 연산처리
    register regist_oper(instruction[12:10],instruction[9:7],sel_reg_write_loc_output,reg_write_data,rst,clk,reg_write,rs,rt);

    //신호 extend 
    sign_extend to_13bit_extend(instruction[6:0],sign_extendion);

    //alucontrol
    alu_control aluctrl (instruction[3:0],aluop,alu_sel);

    //jrcontrol
    jr_ctrl jrctrl(instruction[3:0],aluop,jr_sel);

    //직접값 (alusrc) 선택
    mux_2out #(16) sel_imm(rt,{3'b0,sign_extendion},alusrc,sel_imm_result);

    //alu연산
    alu alu_oper(rs,sel_imm_result,alu_sel,alu_result,zeroflag,);

    //pc처리들
    adder #(13) beq_calcu(pc_current,sign_extendion,beq_cal_result);
    //pc+1 혹은 beq값 결정
    mux_2out #(13) sel_pcadd1_or_beq(pc_add1,beq_cal_result,branch&zeroflag,beqpc1);
    //jump이냐 아니면 beqpc1이냐
    mux_2out #(13) sel_jump_or_beqpc1(beqpc1,instruction[12:0],jump,selected_j_or_beqpc1);

    //beq이냐 아니면 jr이냐
    mux_2out #(13) sel_jr_or_jbeqpc1(selected_j_or_beqpc1,rs[12:0],jr_sel,pc_next);


    //메모리처리
    data_memory dt_memory(rt,alu_result,clk,rst,mem_write,mem_read,write_data_mid);

    //reg_write값 저장
    mux_3out #(16) sel_reg_write_data(alu_result,write_data_mid,{3'b000,pc_add1},mem_to_reg,reg_write_data);

endmodule