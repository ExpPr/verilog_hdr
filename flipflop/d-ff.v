
//always @() 에서 ()안 구문들은 전부다 or구문, 즉 어느것이든 하나만이라도 만족하다면 적용됨, 이게 즉 async
//positive-edge-trigg d-ff
module flipflop1 (d,clk,q);
input d,clk;
output reg q;

    always @(posedge clk) begin //posedge : clk -> clk가 0->1될때그 순간저장
        q<=d;
    end
    
endmodule

//positive-edge ff with sync reset at 0
module flipflop2 (d,clk,reset,q);
input d,clk,reset;
output reg q;

    always @(posedge clk) begin //posedge : clk -> clk가 1->0될때그 순간저장
        if (reset==0) begin
            q=0;
        end
        else begin
            q<=d;
        end
    end
    //이때 reset 순서는 절때 바뀌면 안됨 (if -end 구문), 항상 reset은 최우선순위인것을 고려
endmodule

//positive edge ff with async reset at 0
module flipflop3 (d,clk,reset,q);
input d,clk,reset;
output reg q;

    always @(posedge clk,negedge reset) begin //둘다 엣지로 받아야지만 작동됨, 
        if (reset==0) begin
            q=0;
        end
        else begin
            q<=d;
        end
    end
    
endmodule

//positive edge with sync pre_set
module flipflop4 (d,clk,pre_set,q);
input d,clk,pre_set;
output reg q;

    always @(posedge clk,posedge pre_set) begin //둘중 하나만 맞아도 작동
        if (pre_set) begin
            q=1;
        end
        else begin
            q<=d;
        end
    end
    
endmodule


module d_ff_final (d,clk,rst,preset,ld,q);
input d,clk,rst,preset,ld;
output reg q;

    always @(posedge clk,negedge rst) begin //둘중 하나만 맞아도 작동
        if (rst==0) begin
            q=0;
        end
        else if (preset==0) begin
            q=1;
        end
        else if (ld==1) begin
            q=d;
        end
    end
    
endmodule