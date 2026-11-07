# Results - Team 1 Traffic Light FSM (Member 4)

The self-checking testbench `tb/traffic_fsm_tb.v` (instance `dut`, 10 ns clock, no `case`) was run with
Icarus Verilog against `rtl/traffic_fsm.v`. It checked: (1) reset held over a rising edge gives RED;
(2) three full RED-GREEN-YELLOW cycles in the correct order; (3) a synchronous-reset proof, where reset
rises mid-period and the lights stay GREEN until the next rising edge; (4) mid-run reset from GREEN and
from YELLOW, both giving RED on the next edge; (5) forcing `dut.state` to 11, where all three lights are 0
and one clock later the machine moves to YELLOW (10) and then rejoins the cycle. Every check also verifies
that the outputs are one-hot. All 22 checks passed; the log ends with `==== DONE: 0 error(s) ====`.
