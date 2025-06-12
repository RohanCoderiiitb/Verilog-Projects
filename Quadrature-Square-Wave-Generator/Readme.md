# 🔧 Description
The square wave generator is a Verilog module that generates two 1 MHz square waves, 90 degrees out of phase with each other. The outputs are derived from a 2-bit counter
running off a 4MHz clock input, ensuring precisely timed waveform generation.

# 🎯 Key Features
1. Generates:
  1. sq_a: 1 MHz square wave
  2. sq_b: 1 MHz square wave phase-shifted by 90° from sq_a
2. Driven by a 4 MHz input clock
3. Includes active-high reset to reinitialize output and counter
4. All logic is synchronous with the clock.

# 🧠 How It Works
A 2-bit counter increments on every rising edge of the 4 MHz clock. The counter cycles through four states (00, 01, 10, 11), taking four clock cycles = 1 μs to complete one 
full cycle, resulting in a 1 MHz frequency.

Inputs:
   1. clk: 4MHz clock signal
   2. reset: synchronous reset

Outputs:
   1. sq_a = ~counter[1]: Toggles every 2 cycles → 1 MHz
   2. sq_b = counter[0] ^ counter[1]: Also toggles every 2 cycles but phase-shifted by 90°.

# 🧮 Frequency & Timing
Clock Frequency: 4 MHz → Period = 250 ns
2-bit counter completes 1 full cycle every 4 clock cycles → 1 MHz output
Phase shift between sq_a and sq_b: ¼ of 1 MHz period = 250 ns

# 🧪 Testbench Overview
The testbench for the sq_wave_generator module verifies its behavior by simulating a 4 MHz clock (generated using #125 toggling for a 250 ns period) and controlling the reset 
signal at specific intervals. The module under test (uut) is instantiated with its inputs (clk, reset) and outputs (sq_a, sq_b) connected. The clock starts at logic low (0) 
and toggles every 125 ns, simulating a 4 MHz square wave. The reset signal is initially held high for 500 ns, then deasserted to allow the counter to begin incrementing. 
Midway through the simulation, reset is pulsed high again to verify reinitialization behavior. Additionally, waveform data is dumped to a .vcd file using $dumpfile and $dumpvars, 
allowing visualization in tools like GTKWave. The simulation ends after 11 µs using $finish.

# 📂 Files
1. sq_wave_generator.v - Main Verilog module
2. sq_wave_generator_tb.v	- Testbench for simulation

# 🧪 Waveforms
<img width="959" alt="image" src="https://github.com/user-attachments/assets/b3ea340f-e162-4cd1-ac50-55962a6bfeb5" />

# ▶️ How to Run (Using Icarus Verilog + GTKWave

## iverilog -o wavegen.vvp sq_wave_generator.v sq_wave_generator_tb.v
Compiles your Verilog files using Icarus Verilog.
iverilog: The Verilog compiler.
-o sqwavegen.vvp: output the compiled simulation to a file named sqwavegen.vvp.
sq_wave_generator.v: your design module (DUT).
sq_wave_generator_tb.v: your testbench module.
This generates a simulation executable file called sqwavegen.vvp.

## vvp wavegen.vvp
Runs the simulation.
vvp: Icarus Verilog's simulation runtime engine.
sqwavegen.vvp: the compiled simulation file from step 1.
Executes your testbench and produces a sqwavegen.vcd waveform file (due to $dumpfile in your testbench).

## gtkwave dump.vcd
Opens GTKWave to view the simulation waveforms.
gtkwave: GUI tool to view .vcd (Value Change Dump) files.
sqwavegen.vcd: the waveform file generated during simulation.
Let's you visually inspect how clk, reset, sq_a, and sq_b change over time.
