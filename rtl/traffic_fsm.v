`timescale 1ns/1ps
// DLCD Level-2 Problem 1 - Team 1
// Traffic light FSM built only from K-map equations.
// Encoding: RED=00, GREEN=01, YELLOW=10, 11 unused

// ---- Part 1: header and ports ----
module traffic_fsm (
    input  wire clk,
    input  wire reset,   // synchronous, active high -> RED
    output wire red,
    output wire green,
    output wire yellow
);

// ---- Part 2: plain 2-bit state register ----
reg [1:0] state;         // state[1] = S1, state[0] = S0
wire S1, S0;
wire D1, D0;

assign S1 = state[1];
assign S0 = state[0];

// ---- Part 3: next-state logic (K-map equations) ----
// D1 = S0
assign D1 = S0;
// D0 = S1' . S0'
assign D0 = ~S1 & ~S0;

// ---- Part 3: Moore output logic (minterms) ----
// red    = S1' . S0'
assign red    = ~S1 & ~S0;
// green  = S1' . S0
assign green  = ~S1 &  S0;
// yellow = S1 . S0'
assign yellow =  S1 & ~S0;

// ---- Part 4: clocked register with synchronous reset ----
always @(posedge clk) begin
    if (reset)
        state <= 2'b00;      // RED
    else
        state <= {D1, D0};   // load next state
end

endmodule