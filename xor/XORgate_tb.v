`timescale 1ns/1ns
module XORgate_tb();
  reg [1:0]clock;
  wire out;
  
  XOR xr1(clock,out);
  
  initial begin
    clock=2'b00;
    #4 $finish;
  end
  
  always begin
    #1 clock=clock+1;
  end
  
  initial begin
  $dumpfile("output.vcd");
	$dumpvars(0);
  end
endmodule