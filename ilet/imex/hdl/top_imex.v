`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TAYF ARGEM
// Engineer: mustafa
// 
// Create Date: 07/29/2023 06:13:57 PM
// Design Name: 
// Module Name: top_imex
// Project Name: import and export data example
// Target Devices: 
// Tool Versions: 
// Description: Just assign input data to output, which add 1 clock delay
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_imex #(
    parameter DW = 8
) (
    input           clk,
    input           rst,
    input           i_valid,
    input  [DW-1:0] i_data,
    output          o_valid,
    output [DW-1:0] o_data,
    output          o_error
);
    localparam CW = DW / 3;
    
    reg             valid;
    reg [CW-1:0]    px_r;
    reg [CW-1:0]    px_g;
    reg [CW-1:0]    px_b;
    
    assign o_valid = valid;
    assign o_data = {px_r, px_g, px_b};

    always @(posedge clk) begin
        valid <= i_valid;
        {px_r, px_g, px_b} <= i_data;
    end
    

    
endmodule
