`timescale 0.1ns / 1ps

module testbench;
    reg [3:0]   BA_A;   //4-bit Adder/Subtractor�� ���� 4-bit input A
    reg [3:0]   BA_B;   //4-bit Adder/Subtractor�� ���� 4-bit input B
    reg M;  //�̴� 4-bit Adder/Subtractor�� Adder�� ��������, Subtractor�� ������ �� �������ݴϴ�. M = 0�̸� Adder, M = 1�̸� Subtractor�� �����մϴ�.
    wire V; //�̴� overflow�� �Ǵ����ָ�, V = 1�̸� overflow�� �߻����� �� �� �ֽ��ϴ�.
    wire [3:0]   BA_S;  //����� ��Ÿ���ִ� 4-bit output S
    wire        BA_Co;  //�̴� Carry out�� ��Ÿ���ϴ�.
    integer m, i, j;    //m�� M�� 0�� ����, 1�� ���� �ݺ����� ���� �����ְ�,
                         //i�� �ݺ����� ���� A�� �����ְ�, j�� �ݺ����� ���� B�� �����ݴϴ�.
    
    initial begin
   
    M = 1'b0;//�켱 M�� 0���� �ʱ�ȭ���ݴϴ�.
    BA_A = 4'b0;
    BA_B = 4'b0;//input A�� B���� 0000���� �ʱ�ȭ���ݴϴ�.
    
    #50;
    for(m = 0; m < 2; m = m + 1)begin
        M = m;  //m�� 0�϶��� ������ �ؿ� �ݺ����� �����ϰ�, m�� 1�϶� �ѹ� �� �����ϰ�, �� �� m�� ���� M�� �־��ݴϴ�.
     for(i = 0; i < 16; i = i+1) begin
            for(j = 0; j < 16; j = j+1) begin
                BA_A = i;
                BA_B = j;//���� �Բ� 4-bit BA_A�� BA_B�� 0000���� 1111���� �������ݴϴ�.
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
                $display("BA : error");//�̴� ���� ������ �� ��, ������ �ִ��� ������ �Ǵ����ݴϴ�.
            #10;
        end
     end
     
     
     addsub U2_BA
     (
        .A  (BA_A   ),//BA_A�� addsub�� input�� A port�� �־��ݴϴ�. �Ʒ��� ���� �̿� �����մϴ�.
        .B  (BA_B   ),
        .M  (M),    
        .V  (V),
        .S  (BA_S   ),
        .Co (BA_Co  )
     );
    
endmodule