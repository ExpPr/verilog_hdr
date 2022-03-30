//파일 하나에다가 모든거 집어넣어도 되지만, 가능하면 나눠서 하는걸 추천 - 테스트벤치 파일 나누기

`timescale 1us/1us// 기본단위 설정 / 해상도 설정 - 컴퓨터가 시행할 최소 시간단위
module inverter_tb();
  reg clock1;
  wire output1;

  buffer1 u1(clock1,output1);

  always begin 
    #1 clock1=~clock1;
  end

  initial begin
    clock1=0;
    #100 $finish;
  end
  

  initial begin
    $display("Hello world");//이거는 그냥 출력용
  end


  //이건 그냥 무조건 넣어야하는것.
  initial begin
  $dumpfile("output.vcd");
	$dumpvars(0);
  end
endmodule