module add4b1(output [3:0]sum, output  c_out, input [3:0]a,b);
    wire [4:0] sum1;

    assign sum1=a+b;
    assign c_out=sum1[4];
    assign sum=sum1[3:0];
endmodule