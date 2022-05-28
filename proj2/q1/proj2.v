module b7_to_ascii (
    rst,clk,in,r_out,on,out
);
    output reg [6:0]r_out;
    output reg on;
    input rst,clk,in;
    reg [2:0]count;
    output reg [6:0]out;

    always @(negedge rst, posedge clk) begin
        if (rst==0) begin
            out=0;
            r_out=0;
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

            if (count==7) begin
                r_out=out;
                count=0;
            end
            end
        end
    end
endmodule