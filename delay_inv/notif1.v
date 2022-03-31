`timescale 10ns/10ns
module not1(
    in,out,cltr
);
    input in,cltr;
    output out;

    notif1 #(4,6,8)(out,in,cltr);
    //rise시간 : 0,x,z 에서 1로 바뀌는데 걸리는시간
    //fall시간 : 1,x,z 에서 0으로 바뀌는데 걸리는시간
    //turn-off : 0,1  ->  z로 바꾸는데 걸리는 시간
    // gate #(delay) : rise,fall 시간이 delay값과 같음
    // gate #(rise,fall) : rise 시간과 fall 시간결정, turn_off는 둘중 작은값
    // gate #(rise,fall,turn-off)

    // (최소시간:전형적인시간:최대시간) 으로 랜덤하게 적용가능, ex: not #(1:2:4, 3:6:10)
    
endmodule