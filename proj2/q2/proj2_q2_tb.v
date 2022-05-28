`timescale 1ns/100ps

module proj2_tb();
    parameter test1_size = 98;

    reg clk,in,reset;
    reg [test1_size-1:0]stream;
    reg inp;
    integer i;
    wire [6:0] out_0451;//최종출력 (base64를 문자로 출력)
    wire [2:0] ct;//이중출력을 판별하기 위한 판단
    wire [6:0] ascii;//중간 아스키코드 출력용(cmd 출력용)
    wire ascii_on;//아스키코드가 정상적으로 출력이 되었음을 판별하는 용 (중복출력에 대한 대응)
    wire [5:0] base64;//6bit base64 출력
    reg over;

    top_module tp(reset,clk,inp,out_0451,over,ct,ascii,ascii_on,base64);
 
    initial begin
        stream=98'b10000111001111100110110100000110011011000101100011011111110100111100111011111110011011101011101110;
        reset=0;
        clk=0;
        over=0;
        inp=0;
    end

    always #0.5 clk=~clk;

    initial begin
        #4
        reset=1;

        for (i=test1_size-1;i>=0;i=i-1) begin
            inp=stream[i];
            #1;
        end
        inp=0;
        #2
        over=1;
        #2
        $finish;
    end

    always @(posedge ascii_on) begin
        $display("%c",ascii);
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(0);
        
    end
endmodule