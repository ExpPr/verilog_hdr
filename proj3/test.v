module pc_ctrl(//합성-확인됨
    input rst,clk,jump,branch,
    input [12:0] nextpc,
    output reg [12:0] pc
);

    always @(negedge rst,posedge clk) begin
        if (~rst) begin
            pc<=13'd0;
        end
        else begin
            pc<=nextpc;
            pc<=nextpc;

        end
    end

endmodule