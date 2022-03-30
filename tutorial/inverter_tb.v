`timescale 1us/1us
module inverter_tb();
  reg a;
  wire z;
  
  inv u1(a,z);
  
  initial begin
    a = 0;
	#100 $finish;
  end
  
  always begin
    #10 a = ~a;
  end
  
  initial begin
    $dumpfile("output.vcd");
	$dumpvars(0);
  end
endmodule