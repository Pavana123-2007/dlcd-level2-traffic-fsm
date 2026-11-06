\# Member 3 - Code Notes (traffic\_fsm.v)



1\. `timescale 1ns/1ps: time unit is 1 ns, simulation precision is 1 ps.

2\. wire vs reg: state is a reg because it stores a value and is assigned inside an always block. red, green, yellow, D1, D0, S1, S0 are wires because they are driven by assign statements.

3\. assign is continuous combinational logic; the output changes whenever the inputs change. always @(posedge clk) is sequential; it updates only on the rising clock edge.

4\. <= (non-blocking) is used in clocked blocks so all registers update together at the end of the time step. = (blocking) executes in order. We use assign outside the always block.

5\. {D1, D0} joins two 1-bit signals into a 2-bit value. state\[1] picks bit 1 of the register (S1).

6\. Reset is synchronous because it is checked inside always @(posedge clk). It is not in the sensitivity list. An asynchronous reset would be always @(posedge clk or posedge reset).

7\. Where the equations are in the code:

&#x20;  - D1 = S0 -> assign D1 = S0;

&#x20;  - D0 = S1'.S0' -> assign D0 = \~S1 \& \~S0;

&#x20;  - red = S1'.S0' -> assign red = \~S1 \& \~S0;

&#x20;  - green = S1'.S0 -> assign green = \~S1 \& S0;

&#x20;  - yellow = S1.S0' -> assign yellow = S1 \& \~S0;

8\. Unused state 11: D1 = 1, D0 = 0, so next state is 10 (YELLOW). It recovers in one clock.

9\. Why no case: the problem requires the next-state logic to come only from K-map equations. A case version would be a case on state with branches 00 -> 01, 01 -> 10, 10 -> 00, and a default.

