`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:51:51 08/28/2019 
// Design Name: 
// Module Name:    multright 
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
module multright(
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
    
    assign X1 = X;
    assign Y1 = Y;
    
    assign product = P;
    
    wire [12:0] temp1;
    wire [12:0] temp2;
    wire [12:0] temp3;
    wire [12:0] temp4;
    
    assign temp2 = X[0]? {Y, 6'b000000}:0;
    assign temp1 = P + temp2;
    assign temp3 = {0, temp1[12:1]};
    assign temp4 = {0, X[5:1]};
    
    
    reg [2:0] c;
    
    always @(posedge clk) begin
    
        if(rst) begin
            P <= 0;
            X <= 0;
            Y <= 0;
            c <= 0;
        end else begin
            
            if(load) begin
                X <= a;
                Y <= b;
            end else begin
            
            /* Main Login */
                
                if(c <= 5) begin
                    c <= c+1;
                    P <= temp3;
                    X <= temp4;
                end else begin
                    P <= P;
                end
            end
            
        
        end
    
    end
    
    /*************************/
 endmodule
 
 