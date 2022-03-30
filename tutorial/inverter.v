module inv(a,z);
  input a;
  output z;

  assign z = ~a;
endmodule