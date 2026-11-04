# DLCD Level-2 — Team 1 (Section F)

**Problem 1: Traffic Light Controller built from K-map-derived flip-flop equations**

3-state Moore FSM cycling RED → GREEN → YELLOW → RED, one clock tick per state.
Next-state logic comes only from K-map equations; no `case` statement anywhere.

## Interface
- Inputs: `clk`, `reset` (synchronous, active high → RED)
- Outputs: `red`, `green`, `yellow` (one-hot)

## State encoding (S1 S0)
| State | Code |
|---|---|
| RED | 00 |
| GREEN | 01 |
| YELLOW | 10 |
| unused | 11 (don't care) |

## Fixed names
`clk`, `reset`, `S1`, `S0`, `D1`, `D0`, `red`, `green`, `yellow` · module `traffic_fsm` · register `state` · testbench instance `dut`

## Folders
- `docs/` — report (truth table, K-maps, equations, state diagram)
- `rtl/` — `traffic_fsm.v` (design)
- `tb/` — `traffic_fsm_tb.v` (testbench)
- `output/` — console log and waveform screenshots

## Relay tags
`v0.0-setup` → `v0.1-theory` → `v0.2-rtl` → `v0.3-tb` → `v1.0-final`
