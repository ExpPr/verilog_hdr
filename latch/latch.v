module latch(q, qbar , sbar ,rbar);
    output q, qbar;
    input sbar, rbar;

    //assgin 말고 관계식 쓰는 방법
    //and, or, nand, nor, xor, nxor,
    nand n1(q,sbar,qbar);
    nand n2(qbar,rbar,q);
     
endmodule