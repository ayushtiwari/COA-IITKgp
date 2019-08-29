`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:38:32 08/21/2019 
// Design Name: 
// Module Name:    BARREL 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BARREL(
    input [7:0] I,
    input DIR,
    input [2:0] SHAMT,
    output [7:0] O
    );
    
    wire [7:0] W_1, W_2, W_3;
    
    assign W_1 = I >> 4;
    assign W_2 = I << 4;
    
    MUX M0(.I_0(W_1), .I_1(W_2), .SEL(DIR), .OUT(W_3));
    
    wire [7:0] W_4;
    
    MUX M1(.I_0(I), .I_1(W_3), .SEL(SHAMT[2]), .OUT(W_4));
    
    wire [7:0] W_5, W_6, W_7;
    
    assign W_5 = W_4 >> 2;
    assign W_6 = W_4 << 2;
    
    MUX M2(.I_0(W_5), .I_1(W_6), .SEL(DIR), .OUT(W_7));
    
    wire [7:0] W_8;
    
    MUX M3(.I_0(W_4), .I_1(W_7), .SEL(SHAMT[1]), .OUT(W_8));
    
    wire [7:0] W_9, W_10, W_11;
    
    assign W_9 = W_8 >> 1;
    assign W_10 = W_8 << 1;
    
    MUX M4(.I_0(W_9), .I_1(W_10), .SEL(DIR), .OUT(W_11));
    
    MUX M5(.I_0(W_8), .I_1(W_11), .SEL(SHAMT[0]), .OUT(O));

endmodule
