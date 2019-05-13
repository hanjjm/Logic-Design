`timescale 0.1ns / 1ps

module addsub(
    A, B, M, V, S, Co
    );
    
    input [3:0] A;//4 bit input
    input [3:0] B;//4 bit input
    input M;    //M�� 1�� ��� subtractor�� �����ϰ�, 0�� ��쿡 Adder�� �����մϴ�.
    output V;   //�̴� overflow�� �Ǵ��ϴ� bit�� V�� 1�� ��쿡 �̴� overflow�� �߻����� �� �� �ֽ��ϴ�.
    output [3:0] S;//4 bit output
    output Co;  //Carry Out
    
    wire Mi [3:0];  //�̴� M�� ���� 1�϶��� 0�϶� input�� B�� xor������ �Ͽ� ������ full adder�� ���� input�� �˴ϴ�.
    wire C1, C2, C3;//C1�� LSB�� ���ϴ� M�� input���� �޴� full adder�� carry out�� ���� �����ϴ� wire�� C2, C3�� �� ���� ������ fulladder�� carry out ���� �����մϴ�.
    
    assign Mi[0] = B[0]^M;//�̴� ������� LSB ��, S[0]�� ���ϱ� ���� full adder�� ���� input���� B[0]�� M�� xor������ �� ��, full adder�� input���� ���ϴ�.
    assign Mi[1] = B[1]^M;
    assign Mi[2] = B[2]^M;
    assign Mi[3] = B[3]^M;
    assign V = Co^C3;//�̴� overflow bit�� MSB�� ���ϴ� full adder�� carry in�� carry out�� xor������ �ϰ�, �� ����� 1�̸� overflow�� �߻����� �� �� �ֽ��ϴ�.
                     //�̴� ���� assign V = (A[3] & B[3] & ~S[3] | ~A[3] & ~B[3] & S[3])���� �� ���� �ֽ��ϴ�.
   
    full_adder U0 (A[0], Mi[0], M, S[0], C1);//�̴� LSB�� ����� ���ϴ� full adder�� A[0]��, B[0]�� M�� xor�������� ���� ����� M�� carry in���� input���� �ް�,
                                             //������� LSB�� carry out�� output���� �����ϴ�.
    full_adder U1 (A[1], Mi[1], C1, S[1], C2);
    full_adder U2 (A[2], Mi[2], C2, S[2], C3);
    full_adder U3 (A[3], Mi[3], C3, S[3], Co);

endmodule