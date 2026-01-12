---

# Half Adder in Verilog (Learning-Oriented Example)

## Overview

This repository contains a **Verilog implementation of a Half Adder** along with a **basic testbench** designed for **learning digital design fundamentals** using **Xilinx Vivado (XSim)**.

The goal of this project is **not only to implement a half adder**, but also to help beginners understand:

* How combinational logic is written in Verilog
* How simulation works in Vivado
* Common beginner mistakes and edge cases
* Why certain Verilog rules exist (e.g., wires vs registers)

---

## What is a Half Adder?

A half adder is a combinational circuit that adds two 1-bit inputs and produces:

* **Sum**
* **Carry**

### Logic Equations

* `Sum = a ⊕ b`
* `Carry = a · b`

| a | b | Sum | Carry |
| - | - | --- | ----- |
| 0 | 0 | 0   | 0     |
| 0 | 1 | 1   | 0     |
| 1 | 0 | 1   | 0     |
| 1 | 1 | 0   | 1     |

---

## Repository Structure

```
.
├── ha.v       # Half Adder RTL (DUT)
├── ha_tb.v    # Testbench for simulation
└── README.md
```

---

## Verilog Design (DUT)

The half adder is implemented using **continuous assignments**, which describe **pure combinational logic**.

```verilog
assign sum   = a ^ b;
assign carry = a & b;
```

### Why `assign`?

* `assign` creates continuous hardware connections
* Outputs are driven whenever inputs change
* This matches real combinational circuit behavior

---

## Testbench Explanation

The testbench:

* Drives **only the inputs**
* Observes outputs produced by the DUT
* Uses an `initial` block to apply test vectors

```verilog
initial begin
  x = 0; y = 0; #10;
  x = 0; y = 1; #10;
  x = 1; y = 0; #10;
  x = 1; y = 1; #10;
  $finish;
end
```

---

## IMPORTANT LEARNING POINTS & EDGE CASES

### 1. Procedural Assignment to Wires (Common Beginner Error)

**Wrong:**

```verilog
wire s;
initial s = 1'b0;   // ❌ Illegal
```

**Why?**

* `wire` represents a physical connection
* It **cannot store values**
* Procedural blocks (`initial`, `always`) require variables

**Correct:**

* Use `wire` for outputs driven by `assign`
* Use `reg` or `logic` for signals driven inside procedural blocks

---

### 2. Why Outputs in Testbench Must Be `wire`

In the testbench:

```verilog
wire s, c;
```

Reason:

* Outputs are driven by the DUT
* Driving them from the testbench causes **multiple drivers**
* Multiple drivers lead to `X` (unknown) values

---

### 3. Z and X Values in Simulation (Very Important)

| Value | Meaning                                  |
| ----- | ---------------------------------------- |
| `Z`   | Signal is floating (not driven)          |
| `X`   | Unknown (conflicting or undefined logic) |

If you see:

* `a = Z`, `b = Z` → Testbench not driving inputs
* `sum = X`, `carry = X` → DUT inputs are invalid

Most common cause:

> **Wrong top module selected in Vivado**

Always set **`ha_tb` as Top for Simulation**.

---

### 4. `initial` Blocks Are for Simulation Only

* `initial` blocks **do not represent hardware**
* They are used only for **testbenches**
* Real hardware requires clock/reset logic

This project intentionally uses `initial` for learning and verification.

---

### 5. Edge Case: Time 0 Behavior

At time `t = 0`:

* Signals may briefly appear as `X`
* This is normal until first assignments execute

---

## How to Run Simulation (Vivado)

1. Add `ha.v` to **Design Sources**
2. Add `ha_tb.v` to **Simulation Sources**
3. Right-click `ha_tb` → **Set as Top**
4. Run **Behavioral Simulation**
5. Observe waveform or console output

---

## Learning Objectives

By completing this project, you should understand:

* Difference between `wire` and `reg`
* Continuous vs procedural assignments
* How testbenches drive inputs
* How to debug `X` and `Z` values
* How Vivado simulation works internally

---

## Tool Compatibility

* Tested with **Vivado 2020+**
* Fully compatible with **Vivado 2025**
* Uses Verilog-2001 constructs

---

## Next Steps (Suggestions)

* Convert this half adder into a **full adder**
* Rewrite the design using **SystemVerilog**
* Add **self-checking assertions** to the testbench
* Implement the design on FPGA and test with LEDs

---

## Key Takeaway

> **HDLs describe hardware, not software.
> Understanding signal types and driving rules is more important than writing syntax.**

---
