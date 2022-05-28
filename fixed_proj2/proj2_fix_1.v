module b7_to_ascii (
    rst,clk,in,out,on
);
    output reg [6:0] out;
    output reg on;
    input rst,clk,in;
    reg [2:0]count;

    always @(negedge rst, posedge clk) begin
        if (rst==0) begin
            out=0;
            on=0;
            count=0;
        end
        else begin
            if (count <= 6) begin
                if (count==0) begin
                    on=0;
                end
            out=out<<1;
            out[0]=in;
                if (count==6) begin
                on=1;
                end
            count=count+1;
            end

            else if (count==7) begin
                on=0;
                count=1;
                out=out<<1;
                out[0]=in;
            end
        end
    end
endmodule