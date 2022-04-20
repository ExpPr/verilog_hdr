`timescale 1ns/1ns

module d_ff_tb ();
    reg d,reset,preset,load,clk;
    wire out;


    flipflop4 f4(d,clk,preset,q);
    initial begin
        d=0;
        reset=1;
        preset=0;
        load=0;
        clk=0;

        #30 $finish;
    end

    initial begin
        fork
        #5 preset=1;
    join

    end


    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end

endmodule