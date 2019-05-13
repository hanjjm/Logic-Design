`timescale 0.1ns / 1ps

module testbench;
    reg [3:0]   BA_A;   //4-bit Adder/Subtractor로 들어가는 4-bit input A
    reg [3:0]   BA_B;   //4-bit Adder/Subtractor로 들어가는 4-bit input B
    reg M;  //이는 4-bit Adder/Subtractor가 Adder로 동작할지, Subtractor로 동작할 지 결정해줍니다. M = 0이면 Adder, M = 1이면 Subtractor로 동작합니다.
    wire V; //이는 overflow를 판단해주며, V = 1이면 overflow가 발생함을 알 수 있습니다.
    wire [3:0]   BA_S;  //결과를 나타내주는 4-bit output S
    wire        BA_Co;  //이는 Carry out를 나타냅니다.
    integer m, i, j;    //m은 M이 0일 때와, 1일 때를 반복문을 통해 보여주고,
                         //i는 반복문을 통해 A를 정해주고, j는 반복문을 통해 B를 정해줍니다.
    
    initial begin
   
    M = 1'b0;//우선 M을 0으로 초기화해줍니다.
    BA_A = 4'b0;
    BA_B = 4'b0;//input A와 B또한 0000으로 초기화해줍니다.
    
    #50;
    for(m = 0; m < 2; m = m + 1)begin
        M = m;  //m이 0일때에 시작해 밑에 반복문을 수행하고, m이 1일때 한번 더 수행하고, 이 때 m의 값을 M에 넣어줍니다.
     for(i = 0; i < 16; i = i+1) begin
            for(j = 0; j < 16; j = j+1) begin
                BA_A = i;
                BA_B = j;//위와 함께 4-bit BA_A와 BA_B를 0000부터 1111까지 설정해줍니다.
                #10;
                end
            end
            #50;
        end
        $finish;
     end
     
     
     initial begin
        #55;
        forever begin
            if({BA_Co, BA_S} != BA_A + BA_B)
                $display("BA : error");//이는 위에 설정해 줄 때, 오류가 있는지 없는지 판단해줍니다.
            #10;
        end
     end
     
     
     addsub U2_BA
     (
        .A  (BA_A   ),//BA_A를 addsub의 input인 A port에 넣어줍니다. 아래도 전부 이와 동일합니다.
        .B  (BA_B   ),
        .M  (M),    
        .V  (V),
        .S  (BA_S   ),
        .Co (BA_Co  )
     );
    
endmodule