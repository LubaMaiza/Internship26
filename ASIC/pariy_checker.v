`timescale 1ns/ 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 16:34:41
// Design Name: 
// Module Name: pariy_checker
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module parity_checker(
    input [7:1] ham,
    input reset, clock,
    output reg [2:0] error
    );
    reg [3:1] E;
always @(posedge clock)begin
    if(reset)begin
        error <= 3'b000;
        end
    else begin
        E[1] = ham[1]^ham[3]^ham[5]^ham[7];
        E[2] = ham[2]^ham[3]^ham[6]^ham[7];
        E[3] = ham[4]^ham[5]^ham[6]^ham[7];
        error = E;
            end
       end                      
endmodule
