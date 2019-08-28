`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:14:00 08/28/2019 
// Design Name: 
// Module Name:    binaryMultiplier 
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
module binaryMultiplier(
    input clk_fast,
    input rst,
    input load,
    input [5:0] a,
    input [5:0] b,
    output [11:0] product,
    output reg clk
    );

    /* Clock */
    reg [31:0] count;
   
    always @(posedge clk_fast) begin
        
        count = count+1;
        
        if(rst) begin
            clk = 0;
        end begin
            if(count >= 4000000) begin
                count = 0;
                clk = ~clk;
            end
        end
        
    end
    
    /********************/
    
    
    
    /* Multiplier */
    
    reg [11:0] P;
    reg [5:0] X;
    reg [5:0] Y;
    reg [2:0] pow;
    
    assign product = P;
    
    wire [11:0] temp1;
    wire [5:0] temp2;
    wire [5:0] temp3;
    
    assign temp1 = X[0]? Y:0;
    assign temp2 = {0, X[5:1]};
    assign temp3 = 1 << pow;
    
    always @(posedge clk) begin
    
        if(rst) begin
            P <= 0;
            X <= 0;
            Y <= 0;
            pow <= 0;
        end else begin
        
            if(load) begin
                X <= a;
                Y <= b;
            end else begin
            
            /* Main Login */
            
                P <= P + temp3*temp1;
                X <= temp2;
                pow <= pow + 1;
                
            end
        
        end
    
    end
    
    /*************************/
    
endmodule
