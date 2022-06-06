module pc_ctrl(
    input rst,clk,
    input [12:0] nextpc,
    output reg [12:0] pc
);

    always @(negedge rst,posedge clk) begin
        if (~rst) begin
            pc=0;
        end
        else begin
            pc=nextpc;
        end
    end
endmodule