`timescale 0.1ns / 1ps

module half_adder(
    A, B, S, Co
    );
   input A, B;
   output S, Co;
   
   assign S = A^B;
   assign Co = A&B;    
    
endmodule
