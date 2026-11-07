`timescale 1ns/1ps
// DLCD Level-2 Problem 1 - Team 1
// Self-checking testbench for traffic_fsm (plain Verilog-2001).
// Expected: RED(00) -> GREEN(01) -> YELLOW(10) -> RED(00), one state per clock.
// Unused state 11: all lights 0, next state = 10 (YELLOW).
// Run from the project root:
//   iverilog -o sim rtl/traffic_fsm.v tb/traffic_fsm_tb.v
//   vvp sim > output/console_log.txt

module traffic_fsm_tb;

reg clk, reset;
wire red, green, yellow;
integer errors, i;

// ---- Device under test ----
traffic_fsm dut (
    .clk(clk), .reset(reset),
    .red(red), .green(green), .yellow(yellow)
);

// ---- 10 ns clock (5 ns high, 5 ns low) ----
initial clk = 1'b0;
always #5 clk = ~clk;

// ---- Compare outputs with expected values and check one-hot ----
task check;
    input er, eg, ey;
    begin
        if (red !== er || green !== eg || yellow !== ey) begin
            $display("FAIL t=%0t state=%b got r%b g%b y%b expected r%b g%b y%b",
                     $time, dut.state, red, green, yellow, er, eg, ey);
            errors = errors + 1;
        end else
            $display("PASS t=%0t state=%b r%b g%b y%b",
                     $time, dut.state, red, green, yellow);

        if ((red + green + yellow) != 1) begin
            $display("FAIL t=%0t one-hot violated", $time);
            errors = errors + 1;
        end
    end
endtask

initial begin
    $dumpfile("output/traffic_fsm.vcd");
    $dumpvars(0, traffic_fsm_tb);
    errors = 0;
    $timeformat(-9, 0, " ns", 8);

    // ------------------------------------------------------------
    // 1. Reset held across one rising edge -> RED
    // ------------------------------------------------------------
    $display("---- Test 1: reset -> RED ----");
    reset = 1'b1;
    @(posedge clk); #1; check(1,0,0);
    reset = 1'b0;

    // ------------------------------------------------------------
    // 2. Three full RED-GREEN-YELLOW cycles
    // ------------------------------------------------------------
    $display("---- Test 2: three full cycles ----");
    for (i = 0; i < 3; i = i + 1) begin
        @(posedge clk); #1; check(0,1,0);   // GREEN
        @(posedge clk); #1; check(0,0,1);   // YELLOW
        @(posedge clk); #1; check(1,0,0);   // RED
    end

    // ------------------------------------------------------------
    // 3. Synchronous reset proof: reset rises mid-period, lights
    //    must NOT change until the next rising edge
    // ------------------------------------------------------------
    $display("---- Test 3: synchronous reset proof ----");
    @(posedge clk); #1; check(0,1,0);       // move to GREEN first
    #2; reset = 1'b1;                       // 3 ns after the edge, mid-period
    #1; check(0,1,0);                       // still GREEN: reset has not acted yet
    @(posedge clk); #1; check(1,0,0);       // RED only after the edge
    reset = 1'b0;

    // ------------------------------------------------------------
    // 4. Mid-run reset from GREEN and from YELLOW
    // ------------------------------------------------------------
    $display("---- Test 4: mid-run reset ----");
    @(posedge clk); #1; check(0,1,0);       // GREEN
    reset = 1'b1;
    @(posedge clk); #1; check(1,0,0);       // reset from GREEN -> RED
    reset = 1'b0;
    @(posedge clk); #1; check(0,1,0);       // GREEN
    @(posedge clk); #1; check(0,0,1);       // YELLOW
    reset = 1'b1;
    @(posedge clk); #1; check(1,0,0);       // reset from YELLOW -> RED
    reset = 1'b0;

    // ------------------------------------------------------------
    // 5. Unused state 11: lights all 0, recovers to YELLOW in one clock
    // ------------------------------------------------------------
    $display("---- Test 5: unused state 11 ----");
    @(negedge clk);
    force dut.state = 2'b11;
    #1;
    $display("INFO t=%0t state=%b r%b g%b y%b (all lights expected 0 in 11)",
             $time, dut.state, red, green, yellow);
    if (red !== 1'b0 || green !== 1'b0 || yellow !== 1'b0) begin
        $display("FAIL t=%0t lights not all 0 in unused state", $time);
        errors = errors + 1;
    end else
        $display("PASS t=%0t unused state 11 shows all lights off", $time);
    release dut.state;
    @(posedge clk); #1; check(0,0,1);       // 11 -> YELLOW
    @(posedge clk); #1; check(1,0,0);       // YELLOW -> RED (back in the cycle)
    @(posedge clk); #1; check(0,1,0);       // RED -> GREEN

    $display("==== DONE: %0d error(s) ====", errors);
    $finish;
end

endmodule
