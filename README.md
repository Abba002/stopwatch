# ⏱️ FPGA Stopwatch – Verilog Project

## 📌 Project Overview

The **FPGA Stopwatch** is a digital stopwatch implemented using **Verilog** on an **FPGA board**. It displays **tenths of a second, seconds, and tens of seconds** on a **7-segment display** and supports **start/stop toggle and reset functionality**.

This project covers **hardware debouncing, clock division, and seven-segment display control**.

---

## 🚀 Features

- ▶️ **Start/Stop Toggle** – Press a button to start or stop the stopwatch.
- 🔄 **Reset** – A dedicated reset button resets the time to `00.0` seconds.
- ⏲️ **Seven-Segment Display Output** – Shows time with a decimal point.
- 🔧 **Button Debouncing** – Ensures stable button inputs.
- ⏳ **Clock Divider** – Generates `1Hz` and `10Hz` clocks from the FPGA’s `100MHz` clock.

---

## 🛠️ Tech Stack

| Component            | Technology Used |
|----------------------|----------------|
| **Programming Language** | Verilog |
| **FPGA Board**       | *Varies* |
| **Clock Speed**      | 100 MHz |
| **Constraints File** | `.xdc` for pin mapping |
| **Development Tool** | Xilinx Vivado |

---

## 📂 Installation & Setup

### 1️⃣ **Clone the Repository**
```sh
git clone https://github.com/YOUR_GITHUB_USERNAME/FPGA-Stopwatch.git
cd FPGA-Stopwatch
```
### 2️⃣ Navigate to the Project Directory
``` sh
cd FPGA-Stopwatch
```
### 3️⃣ Open in Vivado
- Open Vivado and create a new project.
- Add the Verilog source files:
  clock_divider.v,
  debouncer.v,
  stopwatch.v,
  seven_seg_display.v,
  stopwatch_topmodule.v
- Add the FPGA constraints file (.xdc) for proper pin mapping.

### 4️⃣ Run Synthesis, Implementation, and Bitstream Generation
- Synthesize the design – Run Synthesis.
- Implement the design – Run Implementation.
- Generate the Bitstream – Generate Bitstream.
- Program the FPGA using Vivado Hardware Manager.

## 📜 Usage

### 1️⃣ Start and Stop the Stopwatch
- Press Start/Stop Button – Toggles counting.
- Press Reset Button – Resets the stopwatch to 00.0.
- Seven-Segment Display – Shows elapsed time with decimal point.
