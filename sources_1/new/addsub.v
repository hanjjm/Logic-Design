`timescale 0.1ns / 1ps

module addsub(
    A, B, M, V, S, Co
    );
    
    input [3:0] A;//4 bit input
    input [3:0] B;//4 bit input
    input M;    //M이 1일 경우 subtractor로 동작하고, 0일 경우에 Adder로 동작합니다.
    output V;   //이는 overflow를 판단하는 bit로 V가 1일 경우에 이는 overflow가 발생함을 알 수 있습니다.
    output [3:0] S;//4 bit output
    output Co;  //Carry Out
    
    wire Mi [3:0];  //이는 M이 각각 1일때와 0일때 input인 B와 xor연산을 하여 각각의 full adder로 들어가는 input이 됩니다.
    wire C1, C2, C3;//C1은 LSB를 구하는 M을 input으로 받는 full adder의 carry out의 값을 저장하는 wire고 C2, C3은 그 다음 순서로 fulladder의 carry out 값을 저장합니다.
    
    assign Mi[0] = B[0]^M;//이는 결과값의 LSB 즉, S[0]을 구하기 위한 full adder에 들어가는 input으로 B[0]과 M를 xor연산을 한 후, full adder에 input으로 들어갑니다.
    assign Mi[1] = B[1]^M;
    assign Mi[2] = B[2]^M;
    assign Mi[3] = B[3]^M;
    assign V = Co^C3;//이는 overflow bit로 MSB를 구하는 full adder의 carry in과 carry out을 xor연산을 하고, 그 결과가 1이면 overflow가 발생함을 알 수 있습니다.
                     //이는 또한 assign V = (A[3] & B[3] & ~S[3] | ~A[3] & ~B[3] & S[3])으로 알 수도 있습니다.
   
    full_adder U0 (A[0], Mi[0], M, S[0], C1);//이는 LSB의 결과를 구하는 full adder로 A[0]과, B[0]과 M을 xor연산으로 구한 결과와 M을 carry in으로 input으로 받고,
                                             //결과값의 LSB와 carry out을 output으로 가집니다.
    full_adder U1 (A[1], Mi[1], C1, S[1], C2);
    full_adder U2 (A[2], Mi[2], C2, S[2], C3);
    full_adder U3 (A[3], Mi[3], C3, S[3], Co);

endmodule