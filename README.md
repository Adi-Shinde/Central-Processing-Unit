# Simple Central Processing Unit (Lab 6)

This project implements a small, hand-built central processing unit (CPU) in VHDL. The design demonstrates
how registers, a control unit, a decoder, an arithmetic logic unit (ALU), and a 7-segment display driver
work together to form a simple general-purpose processor. All code, diagrams, and waveforms used in the
lab report are included in this repository.

## Reference

- Full lab report (PDF): `cpu_report.pdf` (add this file to the repository root for GitHub to render the link).

## Summary

- Two 8-bit latches act as inputs (A and B).
- A Moore finite state machine (FSM) generates a 4-bit state code.
- A 4-to-16 decoder translates the FSM state into a 16-bit microcode bus.
- The ALU performs arithmetic and logic operations selected by the microcode.
- A 7-segment display driver renders outputs and simple characters on physical displays.

---

## Top-level diagrams and waveforms

### FSM (VHDL and waveform)
![](https://raw.githubusercontent.com/Adi-Shinde/Central-Processing-Unit/main/All%20Code%20%2B%20Diagram%20%28Pictures%29/FSM/FSMvhd1.png)
![](https://raw.githubusercontent.com/Adi-Shinde/Central-Processing-Unit/main/All%20Code%20%2B%20Diagram%20%28Pictures%29/FSM/FSMvwf.png)

### Latches (VHDL and waveform)
![](https://raw.githubusercontent.com/Adi-Shinde/Central-Processing-Unit/main/All%20Code%20%2B%20Diagram%20%28Pictures%29/Latch/LatchVHD.png)
![](https://raw.githubusercontent.com/Adi-Shinde/Central-Processing-Unit/main/All%20Code%20%2B%20Diagram%20%28Pictures%29/Latch/Latch1VWF.png)

### ALU diagrams and waveforms
![](https://raw.githubusercontent.com/Adi-Shinde/Central-Processing-Unit/main/All%20Code%20%2B%20Diagram%20%28Pictures%29/ALU/ALU1.png)
![](https://raw.githubusercontent.com/Adi-Shinde/Central-Processing-Unit/main/All%20Code%20%2B%20Diagram%20%28Pictures%29/ALU/ALU2.png)

### Top-level block and waveform
![](https://raw.githubusercontent.com/Adi-Shinde/Central-Processing-Unit/main/All%20Code%20%2B%20Diagram%20%28Pictures%29/BDFdiagram.png)
![](https://raw.githubusercontent.com/Adi-Shinde/Central-Processing-Unit/main/All%20Code%20%2B%20Diagram%20%28Pictures%29/VWF_final.png)

---

## Project structure

- `Files/` — VHDL sources and design files used for synthesis and simulation. Key VHDL files are listed below.
- `All Code + Diagram (Pictures)/` — Diagrams and waveform screenshots used in the report.
- `Files/output_files/` — Generated reports and waveform files from synthesis and simulation runs.

---

## Code map: what each VHDL file does

The following files are included in `Files/`. Each entry lists the main ports and the role of the module.

### 1. `latch1.vhd`

- **Role:** 8-bit register/latch used to store input values (A and B).  
- **Notes:** Implements clocked storage. There are waveform files in `output_files/` showing the latch behaviour.

### 2. `3to8decoder.vhd`

- **Role:** 3-to-8 decoder used as a building block for the 4-to-16 decoder.  
- **Notes:** Used inside the larger decoder module.

### 3. `decode4to16.vhd`

- **Role:** 4-to-16 decoder that maps FSM state codes to a 16-bit microcode bus.  
- **Notes:** The microcode bus drives the ALU operation selection logic.

### 4. `FSM.vhd`

- **Role:** Moore finite state machine that cycles through nine states (S0..S8).  
- **Ports:** clock, reset, data_in, state_out (4 bits), student_id (output used for display).  
- **Notes:** When data_in = 1 the FSM advances one state per rising clock edge. The state_out is passed to the decoder.

### 5. `ALU.vhd`

- **Role:** Primary ALU implementation used in Problem 1 of the lab.  
- **Ports:** clock, A[7:0], B[7:0], OP (microcode inputs), student_id, R1[3:0], R2[3:0], Neg (sign flag).  
- **Notes:** On the rising clock edge, the ALU reads OP and performs the selected operation on A and B. The 8-bit
  result is split into R1 (high nibble) and R2 (low nibble) for the 7-segment displays. Neg signals negative outputs.

### 6. `ALU2.vhd`

- **Role:** ALU variant used for Problem 2 (alternative function set).  
- **Notes:** Implements a different set of microcode operations (shifts, rotates, min, bit reversals, etc.).

### 7. `sseg.vhd`

- **Role:** 7-segment display driver.  
- **Ports:** 4-bit BCD input, sign/neg flag, segment outputs (abcdefg).  
- **Notes:** Displays 0–F in hexadecimal and small characters ('Y'/'N' used in Problem 3). The driver handles a
  negative flag that toggles a segment for sign display.

---

## How the design works (high level)

1. Two 8-bit values are stored in the latches. In the lab example these were derived from the student number
   (A = 0x58, B = 0x19).
2. The FSM generates a 4-bit state. Each state forms part of a microcode sequence. The FSM advances when
   `data_in` is asserted.
3. The 4-bit state feeds the 4-to-16 decoder. The decoder asserts one microcode line among sixteen.
4. The ALU samples the microcode at the clock rising edge, performs the selected operation on A and
