`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:44:37 09/02/2019
// Design Name:   Booth_Multiplier
// Module Name:   C:/Users/student/Documents/coafiles2/Assignment8/booth_mult/test_booth.v
// Project Name:  booth_mult
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Booth_Multiplier
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_booth;

	// Inputs
	reg clk_fast;
	reg rst;
	reg load;
	reg [5:0] m;
	reg [5:0] r;

	// Outputs
	wire [11:0] product;

	// Instantiate the Unit Under Test (UUT)
	Booth_Multiplier uut (
		.clk_fast(clk_fast), 
		.rst(rst), 
		.load(load), 
		.m(m), 
		.r(r), 
		.product(product)
	);

	initial begin
		// Initialize Inputs
		clk_fast = 0;
		rst = 0;
		load = 0;
		m = 6'b000111;
		r = 6'b000011;

		// Wait 100 ns for global reset to finish
		#50;
        rst=1;
        clk_fast=1;
        
        #50;
        rst=0;
        clk_fast=0;
        load=1;
        
        #50;
        clk_fast=1;
        
        #50
        clk_fast=0;
        load=0;
        
        
        #50;
        clk_fast=1;
        
        #50;
        clk_fast=0;
        
         #50;
        clk_fast=1;
        
        #50;
        clk_fast=0;
        
         #50;
        clk_fast=1;
        
        #50;
        clk_fast=0;
        
         #50;
        clk_fast=1;
        
        #50;
        clk_fast=0;
        
         #50;
        clk_fast=1;
        
        #50;
        clk_fast=0;
        
         #50;
        clk_fast=1;
        
        #50;
        clk_fast=0;
        
          #50;
        clk_fast=1;
        
        #50;
        clk_fast=0;
        
        
        
		// Add stimulus here

	end
      
endmodule

