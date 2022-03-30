module inv (A,B);
//모듈 1번째 단계, 각 변수에 input, output 설정을 할 것.
    input A;
    output B;

//모듈 2번쨰단계, 변수과의 관계설정, 즉 함수설정
    assign B=~A;
    
endmodule

/*
주석 다는 또다른방법
*/

module buffer1(a,z);
    input a;
    output z;

    wire b;//중간연결 할때 이러한 선언이 필수는 아님. 그러나 선언이 가능.
    
    inv u1(a, b);
    inv u2(b, z);
//즉 a=z가 됨.

endmodule

