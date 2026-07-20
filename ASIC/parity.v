`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2026 10:05:25
// Design Name: 
// Module Name: parity_gen
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


module parity_gen(
    input [3:0] data,
    input rst,clk,
    output reg ready,
    output reg [7:1] hamming
    );
    always @(posedge clk) begin
        if(rst)begin
            hamming <=7'b0000000;
            ready = 1'b0;
            end
        else begin
            hamming[1] <= data[0]^data[2]^data[3];
            hamming[2] <= data[0]^data[1]^data[3];
            hamming[3] <= data[3];
            hamming[4] <= data[0]^data[1]^data[2];
            hamming[5] <= data[2];
            hamming[6] <= data[1];
            hamming[7] <= data[0];
            ready <= 1'b1;
            end
end
endmodule
