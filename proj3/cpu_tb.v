`timescale 1ns/100ps

module cpu_tb_v();
    reg rst,clk;
    wire [15:0] instruction;

    cpu test (rst,clk,instruction);

    initial begin
        
        rst=0;
        clk=0;
        $monitor("$1 : %d , $2 : %d , $3 : %d , $4 : %d, $7 : %d , pc : %d",test.regist_oper.internal_reg[1],test.regist_oper.internal_reg[2],test.regist_oper.internal_reg[3],test.regist_oper.internal_reg[4],test.regist_oper.internal_reg[7],test.pc_current);
        forever begin
            #0.5
            //$display("$0 : %d , $1 : %d , $2 : %d , $3 : %d , $4 : %d, $5 : %d , $6 : %d  $7 : %d",test.regs.internal_reg[0],test.regs.internal_reg[1],test.regs.internal_reg[2],test.regs.internal_reg[3],test.regs.internal_reg[4],test.regs.internal_reg[5],test.regs.internal_reg[6],test.regs.internal_reg[7]);
            clk=~clk;
        end
    end


    initial begin
        #20
        $display("end");
        $display("$1 : %d , $2 : %d , $3 : %d , $4 : %d, $7 : %d , pc : %x",test.regist_oper.internal_reg[1],test.regist_oper.internal_reg[2],test.regist_oper.internal_reg[3],test.regist_oper.internal_reg[4],test.regist_oper.internal_reg[7],test.pc_current);
        $display("mem[4] : %d",test.dt_memory.memories[3]);
        $finish;
    end

    initial begin
        #2
        rst=1;
        $display("start mem[3] : %d",test.dt_memory.memories[3]);
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
endmodule
    
