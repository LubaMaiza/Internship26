`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.06.2026 16:35:58
// Design Name: 
// Module Name: top
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


module top(
    input [3:0] data,
    input rst,clk,
    output [7:1] hamming,
    input [7:1] ham,
    output [2:0] error,
    output ready
    );
    
    localparam 
    gen = 1'b0,
    check = 1'b1;
    
    reg state_reg, state_next;
    always @(posedge clk or posedge rst) begin
    if (rst) 
            state_reg <= gen; // default to generator mode
        else 
            state_reg <= state_next;
    end
    always @(*) begin
        state_next = state_reg; // Default: stay in current state
        case (state_reg)
            gen: begin
                if (ready)
                  state_next = check; 
                else
                  state_next = gen;
                end
            check: state_next = gen;  
        endcase
    end
    parity_gen uut (
        .clk(clk),
        .rst(rst),
        .data(data),
        .hamming(hamming),
        .ready(ready)
    );

    parity_checker dut (
        .clock(clk),
        .reset(rst),
        .ham(ham),
        .error(error)
    );

endmodule
