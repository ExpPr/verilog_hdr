module counter15 (
    input rst,on,clk,
    output reg [3:0]cout
);
    always @(negedge rst , posedge clk) begin
        if (rst==0) begin
            cout=0;
        end
        else if (on) begin
            cout=cout+1;
        end
    end
    
endmodule

module counter9 (
    input rst,on,clk,
    output reg [3:0]cout
);
    always @(negedge rst , posedge clk) begin
        if (rst==0) begin
            cout=0;
        end
        else if (on) begin
            if (cout==9) 
                cout=0;
            else
                cout=cout+1;
        end
    end
    
endmodule
