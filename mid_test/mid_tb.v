module bitfa4 (
    a,b,cin,sum,cout
);
    input [3:0]a,b;
    input cin;
    output [3:0]sum;
    output cout;

    assign {cout,sum}=a+b+cin;
    
endmodule

`timescale 1ns/1ns
module adder4_tb();
 reg [3:0] a, b;
 reg cin;
 wire [3:0] sum;
 wire cout;
 integer i=0;
 
 bitfa4 u1(a,b,cin, sum, cout);
 
 initial begin
 cin = 0;
 while (i<10) begin
#5 a = $random; b = $random; cin = ~cin;
 i=i+1;
end
 end

 initial begin
     $dumpfile("output.vcd");
     $dumpvars(0);
 end
 
endmodule
