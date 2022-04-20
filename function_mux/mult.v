module mult( input[3:0]a,b, output[7:0] out);
    assign out=mult(a,b);

    function [7:0] mult;
    input [3:0]a,b;
    begin
        mult=a*b;
    end
    endfunction
endmodule


`timescale 1ns/1ns

module mult_tb (
);
    reg [3:0]a,b;
    wire [7:0] out;

    mult a2(a,b,out);

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end

    initial begin
        #100 $finish;
    end

    always 
        set;

    task set;
    begin
        #10 a<=$random;
        b<=$random;
    end
    endtask
    
endmodule