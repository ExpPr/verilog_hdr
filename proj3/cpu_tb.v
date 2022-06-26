`timescale 1ns/100ps

module cpu_tb_v();
    reg rst,clk;
    wire [15:0] instruction;
    integer i;
    cpu test (rst,clk,instruction);

    initial begin
        
        rst=0;
        clk=0;
       
        forever begin
            #0.5
            clk=~clk;
        end
    end


    initial begin

        for (i=0;i<20;i++) begin
            #1;
            $display("at time : %d ns, PC = %d, RF[0, 1, 2 3, 4, 7] is : %d,   %d, %d, %d, %d, %d",i+1,test.pc_current,test.regist_oper.internal_reg[0],test.regist_oper.internal_reg[1],test.regist_oper.internal_reg[2],test.regist_oper.internal_reg[3],test.regist_oper.internal_reg[4],test.regist_oper.internal_reg[7]);
        end   

    end

    initial begin
        #2
        rst=1;
    end

    initial begin
        #20
        $strobe("The final result of $s3 in memory is: %d", test.dt_memory.memories[3]);
        $strobe("End : PC = %d, RF[0, 1, 2 3, 4, 7] is : %d,   %d, %d, %d, %d, %d",test.pc_current,test.regist_oper.internal_reg[0],test.regist_oper.internal_reg[1],test.regist_oper.internal_reg[2],test.regist_oper.internal_reg[3],test.regist_oper.internal_reg[4],test.regist_oper.internal_reg[7]);
        $finish;
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end
endmodule
    
