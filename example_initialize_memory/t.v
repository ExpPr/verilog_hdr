module file_readmemh (
);

    reg [19:0] data[0:3];

    initial $readmemh("vectors.txt",data);
//h -> hex
    integer i;

    initial begin
        $display("rdata:");
        for (i=0;i<4;i=i+1) begin
            $display("%d:%b",i,data[i]);
        end
    end 
    
endmodule