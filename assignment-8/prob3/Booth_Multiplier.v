`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:19:55 09/02/2019 
// Design Name: 
// Module Name:    Booth_Multiplier 
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
module Booth_Multiplier(
    input clk_fast,
    input rst,
    input load,
    input [5:0] m,
    input [5:0] r,
    output [11:0] product,
    output reg clk_slow
    );
    
    reg [31:0] count = 0;
   
    
    always @(posedge clk_fast) begin
        count <= count + 1;
        
            if(count > 4000000) begin
                count <= 0;
                clk_slow <= ~clk_slow;
            end
       
    end
    
    
    reg [5:0] A;
    reg [6:0] Q;
    reg [2:0] C;
    
    assign product = {A[5:0], Q[6:1]};
    
    wire [5:0] t1;
    wire [5:0] t2;
    wire [6:0] t3;
    wire [5:0] t4;
    wire [6:0] t5;
    wire [5:0] t6;
    wire [6:0] t7;
    wire [5:0] t8;
    
    assign t1 = A + r;
    assign t2 = A - r;
    
    assign t3 = {t1[0], Q[6:1]};
    assign t4 = {t1[5], t1[5:1]};
    
    assign t5 = {t2[0], Q[6:1]};
    assign t6 = {t2[5], t2[5:1]};
    
    assign t7 = {A[0], Q[6:1]};
    assign t8 = {A[5], A[5:1]};
    
    always @(posedge clk_slow) begin
        
        if(rst) begin
            A <= 0;
            Q <= 0;
            C <= 0;
        end else begin
            
            if(load) begin
                A <= 0;
                Q <= {m[5:0], 1'b0};
                
            end else begin
                
                if (C > 5) begin
                   A <= A;
                   Q <= Q;
                
                end else begin
                    
                            if(Q[1:0] == 2'b01) begin
                            
                                Q <= t3;
                                A <= t4;
                                C <= C+1;
                                
                            end else begin
                            
                                if(Q[1:0] == 2'b10) begin
                                
                                    Q <= t5;
                                    A <= t6;
                                    C <= C+1;
                                    
                                end else begin
                            
                                    if(Q[0] == Q[1]) begin
                                        
                                        Q <= t7;
                                        A <= t8;
                                        C <= C+1;
                                        
                                    end
                                    
                                end
                            end
                  end
            end
            
        end
        
    end
    
    
endmodule
