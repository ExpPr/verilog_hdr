`timescale 1ns/1ns

module hi (
);

real i;
reg [9:0] ot;

initial begin
    for (i =0.28 ;i<8.5 ; i=i+1) begin
        #1 ot=i;
        $display("hello %f",i);
    end
end

initial begin
    #30 $finish;
end

initial begin
    $dumpfile("output.vcd");
    $dumpvars(0);
end
    
endmodule
