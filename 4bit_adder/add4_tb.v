`timescale 1ns/1ns
module add4_tb();
  reg [3:0]a,b;
  wire [3:0]s_0451;
  wire cout;

  add_4 test(a,b,s_0451,cout);
  
  initial begin
      a=$urandom%16;
      b=$urandom%16;
      #16 $finish;
  end

  always begin
    #1
      a=$urandom%16;
      b=$urandom%16;
  end

  initial begin
    $dumpfile("output.vcd");
	$dumpvars(0);
  end
endmodule