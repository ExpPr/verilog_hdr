`timescale 1ns/1ns
module demux41_tb(
);

wire [3:0]out1,out2,out3,out4;
reg [1:0] sel;
reg [3:0]in;
integer i;

demux41 test(in,sel,out1,out2,out3,out4);

initial begin
    in=$random;
    sel=0;
    #4 $finish;
end

always @(*) begin
    for (i=0;i<4;i++) begin
        #1
        sel=sel+1;
    end
end

initial begin
    $dumpfile("output.vcd");
    $dumpvars(0);
end
   

endmodule