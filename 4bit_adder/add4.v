module add_4(a,b,s,cout);
    input [3:0] a,b;
    output [3:0]s;
    output cout;
    
    assign {cout,s}=a+b;
endmodule