PERSON 2 → PERSON 3 HANDOFF
DLCD Level-2 | Team 1 | Section F

1. MODULE INTERFACE
Module name: traffic_fsm
Inputs: clk, reset
Outputs: red, green, yellow
State register: state [1:0]
Reset: synchronous, active-high, resets state to RED (00)

2. STATE ENCODING
RED    = 00
GREEN  = 01
YELLOW = 10
UNUSED = 11

3. NEXT-STATE EQUATIONS
S1 = state[1]
S0 = state[0]

D1 = S0
D0 = ~S1 & ~S0

Next state = {D1, D0}

4. MOORE OUTPUT EQUATIONS
red    = ~S1 & ~S0
green  = ~S1 & S0
yellow = S1 & ~S0

5. TRANSITION TABLE
RED (00)    -> GREEN (01)
GREEN (01)  -> YELLOW (10)
YELLOW (10) -> RED (00)
UNUSED (11) -> YELLOW (10)

6. UNUSED STATE RECOVERY
For state 11:
D1 = 1
D0 = 0
Next state = 10 (YELLOW)
All outputs = 0 while state is 11.

7. IMPLEMENTATION REQUIREMENTS
- No case statements.
- Use K-map-derived equations directly.
- Use synchronous active-high reset.
- Reset state to 2'b00.
- Use module name traffic_fsm.
- Use register name state.
- Testbench instance name must be dut.

Person 2 verified:
D1 = S0
D0 = ~S1 & ~S0
