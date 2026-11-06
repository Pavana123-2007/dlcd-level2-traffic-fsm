# Person 2 – K-map Derivation and Equation Sheet
## DLCD Level-2 | Team 1 | Section F

### 1. State Encoding

| State | S1 | S0 |
|---|---:|---:|
| RED | 0 | 0 |
| GREEN | 0 | 1 |
| YELLOW | 1 | 0 |
| UNUSED | 1 | 1 |

### 2. Verified D1 Equation

D1 K-map:

| S1 \ S0 | 0 | 1 |
|---|---:|---:|
| 0 | 0 | 1 |
| 1 | 0 | X |

Group GREEN (01) with UNUSED (11).
S1 changes; S0 remains 1.

**D1 = S0**

### 3. D0 K-map

| S1 \ S0 | 0 | 1 |
|---|---:|---:|
| 0 | 1 | 0 |
| 1 | 0 | X |

Take unused-state X as 0.
The only 1 is at RED (00).

**D0 = NOT(S1) AND NOT(S0)**

### 4. Final Next-State Equations

- **D1 = S0**
- **D0 = NOT(S1) AND NOT(S0)**

### 5. Moore Output Equations

- **red = NOT(S1) AND NOT(S0)**
- **green = NOT(S1) AND S0**
- **yellow = S1 AND NOT(S0)**

Outputs are one-hot for all valid states.

### 6. Unused State Analysis

For S1S0 = 11:

- D1 = 1
- D0 = 0
- Next state = 10 (YELLOW)
- red = 0
- green = 0
- yellow = 0

**Conclusion:** The unused state transitions to YELLOW on the next clock edge.
The FSM does not remain stuck in the unused state.

### 7. Valid State Transition Verification

| Current State | D1D0 | Next State |
|---|---|---|
| RED (00) | 01 | GREEN |
| GREEN (01) | 10 | YELLOW |
| YELLOW (10) | 00 | RED |
| UNUSED (11) | 10 | YELLOW |
