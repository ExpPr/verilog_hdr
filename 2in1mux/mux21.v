//모듈 선언 내부연산에서 input은 무조건 net, output은 reg or net 임
//모듈에 연결하는 input은 reg 아니면 net형, output은 무조건 wire(net)임 - 주로 모듈내에서 또다른 모듈 혹은 testbench
module mux21_1(i0,i1,s,y);
    input i0,i1,s;
    output y;

    //특별히 지시하지 않은 port는 wire로 자동으로 컴파일됨
    //밑 방식은 맨 처음 port는 반드시 output, 나머지 두번째부턴 전부 in임
    not(sn,s);
    and(a0,i0,sn);
    and(a1,i1,s);
    or (y,a0,a1);

endmodule

module mux21_2(i0,i1,s,y);
    input i0,i1,s;
    output y;

    //내부에 또 연산자 대입가능
    // ~ : not, &: and, |:or
    and u1(a0,i0,~s);
    and u2(a1,i1,s);
    or u3(y,a0,a1);
endmodule

module mux21_3(i0,i1,s,y);
    input i0,i1,s;
    output y;

    //내부에 또 연산자 대입가능
    // ~ : not, &: and, |:or
    //콤마로 연속해서 모듈이름  지어 사용가능
    and u1(a0,i0,~s),
    u2(a1,i1,s);
    or u3(y,a0,a1);
endmodule

module mux21_4(i0,i1,s,y);
    input i0,i1,s;
    output y;

    assign y=(i0&(~s))|(i1&s);
endmodule

//삼향연산자
module mux21_5(i0,i1,s,y);
    input i0,i1,s;
    output y;

    assign y=(s==0)?i0:i1;
endmodule

//if구문
module mux21_6(i0,i1,s,y);
    input i0,i1,s;
    output reg y;//reg선언 필수 - if

//주의 : always , initial 를 모듈 선언 내부 사용시, 항상 always @(*) begin ~ end
//주의 : if else 구문은 이 always안에서만 사용가능
//주의 : if else 사용시 출력은 반드시 reg로 해야함
//always문안에 assign 선언 x

//alwyas @() 에서 원래는 괄호안에 있는 input port중 변하는 것이 있을때 always문이실행되는 방식

//always @(이벤트 트리거) 안에선 대입문 사용
    always @(*) begin
        if(s==0)
            y=i0;
        else
            y=i1;
    end
endmodule

module mux21_7(i0,i1,s,y);
    input i0,i1,s;
    output reg y;
    //case문 경우에도 동일

    always @(*) begin
        case(s)
            0:y=i0;
            1:y=i1;
        endcase
    end
endmodule