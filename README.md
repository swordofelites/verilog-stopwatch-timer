# verilog-stopwatch-timer
A programmable digital stopwatch and timer the Digilent Basys 3 Artix-7 FPGA written in Verilog. Originally made for my digital logic design final lab (Spring 2026) but revised during Summer 2026 after TA's feedback. Outputs via the Basys 3's four 7-segment displays with a resolution of 10 miliseconds. System features hardware debouncing, clock division for multiplexed displays, and 4 operating modes. 

# Features and Modes
The stopwatch/timer supports four modes seleted via hardware switches V16 and V17:
* Mode 00 (Count Up): Functions as a standard stopwatch, counting up from 00.00 to 99.99.
* Mode 01 (Count Down): Functions as a timer, counting down from 99.99 to 00.00.
* Mode 10 (Preset Count Up): Counts up from an externally loaded value defined by the 8 preset switches.
* Mode 11 (Preset Count Down): Counts down from an externally loaded value defined by the 8 preset switches.

# Hardware Configuration
This RTL project is mapped to the Artix-7 FPGA on the Digilent Basys 3 board with the I/O mapping to the following:
* Clock (W5): 100 MHz system clock.
* Start/Stop Button (T18): Pauses and resumes the counting process.
* Reset Button (U18): Resets the timer to 00.00, 99.99, or the defined preset value depending on the active mode.
* Mode Switches (V16, V17): Selects the active operational mode (Modes 0-3).
* Preset Switches (T3 to W16): Defines the two most significant digits (seconds) when operating in preset modes (modes 2 and 3).
* 7-Segment Display: Multiplexed output mapping to segments A-G and Anodes 0-3.

# Architecture and Design
The system was designed using a High-Level State Machine (HLSM) mapped to a custom datapath and controller FSM.  
### HLSM
<img width="1157" height="701" alt="hlsm_lab5" src="https://github.com/user-attachments/assets/56604923-cd95-4287-af80-a71c995652e8" />

### Datapath
<img width="890" height="1404" alt="Datapath_lab5" src="https://github.com/user-attachments/assets/54b39ec9-8528-4f8a-9cbb-ad10e17ec609" />

### Controller FSM
<img width="721" height="771" alt="fsm_lab5" src="https://github.com/user-attachments/assets/edcd72cb-ab3e-4785-a9b4-ea24ee8d7521" />

### Simulations and Waveform
The core logic and peripheral modules have been thoroughly verified via behavioral simulation. The following testbenches were used to validate the design prior to synthesis:
* Debouncer Verification (tb_debouncer.v): Simulates mechanical button bounce by asserting rapid high/low transitions for press and release events, verifying that the 1,000,000-cycle delay correctly filters out the noise to produce a single, clean pulse. 
* Core Logic Verification (tb_stopwatch.v): Directly tests the stopwatch.v FSM and datapath. It validates the BCD counting logic, state transitions, and preset loading by cycling through all four operational modes (00, 01, 10, 11) using simulated button pulses. 
* Top-Level Integration (tb_top.v): Validates the entire system wrapper, ensuring that the debounced inputs correctly drive the stopwatch core, and that the resulting 16-bit time values are properly multiplexed to the 7-segment display outputs (seg, an, and dp).

# Input Hardware Debouncing (tb_debouncer)
<img width="662" height="551" alt="Screenshot 2026-06-30 033207" src="https://github.com/user-attachments/assets/60824553-f971-49f2-9a3b-1b8fe1d3c300" />

# Core Logic Loading States (tb_stopwatch)
<img width="1279" height="799" alt="Screenshot 2026-07-05 053514" src="https://github.com/user-attachments/assets/6604040b-978e-4f5a-ab7d-44f20c699e22" />

# Top-level Dispaly Multiplexing (tb_top)
<img width="1080" height="683" alt="Screenshot 2026-06-30 034323" src="https://github.com/user-attachments/assets/b62f7c4c-4631-48a4-9e62-4032c4a0a109" />

# Project Structure
### Source Files
* top.v: The top-level wrapper connecting the debouncers, core logic, and display drivers.
* stopwatch.v: The core behavioral logic managing the timer states, BCD counting, and preset loading.
* debouncer.v: A 1,000,000-cycle hardware debouncer to stabilize mechanical button inputs.
* clkdiv.v: A custom clock divider to slow the 100 MHz system clock for display multiplexing.
* hexto7segment.v: A combinational decoder translating 4-bit hex values to 7-segment cathode signals.
* Basys3_Master.xdc: The physical constraints file mapping Verilog ports to the FPGA pins.
### Simulation Files
* tb_top.v: Top-level system testbench.
* tb_stopwatch.v: Core stopwatch logic testbench.
* tb_debouncer.v: Button debouncer testbench.  

# Development Enviroment
* Synthesis & Simulation: Xilinx Vivado 2026.1
* Diagramming: Draw.io
* Target Device: Digilent Basys 3 (Artix-7 XC7A35TCPG236-1)
* Hardware Provisions and Lending: Department of Electrical and Computer Engineering at the Universty of Texas at Austin
