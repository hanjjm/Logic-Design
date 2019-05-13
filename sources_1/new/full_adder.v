`timescale 0.1ns / 1ps

module full_adder(
    A, B, Ci, S, Co
    );
    
    input A, B, Ci;
    output S, Co;
    
    wire C0, C1, S0;
    
    half_adder U0(A, B, S0, C0);
    half_adder U1(S0, Ci, S, C1);
    
    assign Co = C0 | C1;
    
endmodule
