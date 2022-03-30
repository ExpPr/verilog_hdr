module XOR(a,z);
  input [1:0]a;
  output z;

  assign z = a[0]^a[1];
endmodule