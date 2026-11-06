`timescale 1ns/1ps
// BACKUP VERSION - reset folded into the equations (no if/else)
// DLCD Level-2 Problem 1 - Team 1
// Encoding: RED=00, GREEN=01, YELLOW=10, 11 unused

module traffic_fsm (
    input  wire clk,
    input  wire reset,   // synchronous, active high -> RED
    output wire red,
    output wire green,
    output wire yellow
);

reg [1:0] state;         // state[1] = S1, state[0] = S0
wire S1, S0;
wire D1, D0;

assign S1 = state[1];
assign S0 = state[0];

// D1 = S0 . reset'
assign D1 = S0 & ~reset;
// D0 = S1' . S0' . reset'
assign D0 = ~S1 & ~S0 & ~reset;

// red    = S1' . S0'
assign red    = ~S1 & ~S0;
// green  = S1' . S0
assign green  = ~S1 &  S0;
// yellow = S1 . S0'
assign yellow =  S1 & ~S0;

always @(posedge clk)
    state <= {D1, D0};

endmodule