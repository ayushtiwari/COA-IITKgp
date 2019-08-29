`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:06:31 08/21/2019 
// Design Name: 
// Module Name:    IS_MULTIPLE_OF_3 
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
module IS_MULTIPLE_OF_3(
    input CLK_FAST,
    input RST,
    input IN1,
    output reg OUT1,
    output reg CLK
    );
    
    reg [1:0] STATE;
    reg [31:0] COUNT=0;
    reg CLK_1;
    
    always @(posedge CLK_FAST or posedge RST ) begin
    
         if(RST)begin
         
         COUNT <=0;
         CLK_1 <=0;
         end
         
         else begin
         if(COUNT > 4000000) begin
             COUNT <= 0;
             CLK_1 <= ~CLK_1;
         end else begin
             CLK_1 <= 0;
             COUNT <= COUNT + 1;
         end
     end
    end
    always @(posedge CLK_1 or posedge RST) begin
                  
            if(RST) begin
                STATE <= 2'b00;
                OUT1 <= 1;
            end else begin
               CLK <= CLK_1;
                    case(STATE)
                        
                        2'b00: begin
                            if(IN1==1) begin
                                STATE <= 2'b01;
                                OUT1 <= 0;
                            end else begin
                                STATE <= 2'b00;
                                OUT1 <= 1;
                            end
                        end
                        
                        2'b01: begin
                            if(IN1==1) begin
                                STATE <= 2'b00;
                                OUT1 <= 1;
                            end else begin
                                STATE <= 2'b10;
                                OUT1 <= 0;
                            end
                        end
                        
                        2'b10: begin
                            if(IN1==1) begin
                                STATE <= 2'b10;
                                OUT1 <= 0;
                            end else begin
                                STATE <= 2'b01;
                                OUT1 <=0;
                            end
                        end
                    
                    endcase
                
            end
            
        end
    
endmodule
