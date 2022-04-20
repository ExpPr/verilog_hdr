`timescale 1ns/1ns

module task_tb();

    reg [3:0]a,b;
    wire [3:0]sum;
    wire cout;
    integer i;

    adder a1(a,b,sum,cout);

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
    end

    initial begin
        #30 $finish;
    end

    always
        dealy;

    task dealy;
    begin
        #5
        a=$random;
        b=$random;
    end
    endtask
endmodule