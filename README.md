
# 📦 Synchronous FIFO Buffer in Verilog

A Verilog-based design of a **synchronous First-In First-Out (FIFO) buffer** that stores and retrieves 8-bit data in sequential order. This project demonstrates a 64-depth memory with control logic for read/write operations, status flags, and a 7-bit counter for tracking occupancy — ideal for buffering data between hardware modules.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 📌 Project Details

- **Title**: Synchronous FIFO Buffer  
- **Platform**: Verilog HDL (Simulated using ModelSim or any compatible tool)  
- **Developer**: Urmit Kikani  
- **Institution**: Nirma University  

---

## ⚙️ Module Overview

- **Depth**: 64 entries  
- **Data Width**: 8 bits  
- **Clocked Design**: Synchronous write and read  
- **Status Flags**:
  - `buf_full` – FIFO is full  
  - `buf_empty` – FIFO is empty  
- **Occupancy Counter**: 7-bit (`fifo_counter`) to track number of stored elements  

---

## 🧠 Key Features

- 📥 **Write Operation**: Enabled when `wr_en` is high and FIFO is not full  
- 📤 **Read Operation**: Enabled when `rd_en` is high and FIFO is not empty  
- 🧮 **Pointer-Based Memory**: Uses circular pointers (`wr_ptr`, `rd_ptr`)  
- 🚦 **Status Detection**: Real-time `buf_full` and `buf_empty` flags  
- ⏱️ **Synchronous Operation**: All logic triggered on rising edge of clock  

---

## 🧪 How to Simulate

1. Open **ModelSim** or another Verilog simulator.
2. Compile both `fifo.v` and `fifo_tb.v`.
3. Run the testbench to observe write/read behavior.
4. Check waveform for correct data order and status flag transitions.

---

## ✅ Expected Output

- FIFO correctly stores and retrieves data in the same order (FIFO principle).
- `buf_full` and `buf_empty` toggle as expected.
- `fifo_counter` reflects real-time data occupancy.
- Waveform shows accurate timing and pointer updates.

Example:


Write:  A → B → C
Read:   A → B → C



---

## 🚀 Future Improvements

- Support for **asynchronous FIFO**
- **Parametric** data width and depth using `parameters`
- Integrate with **UART** or other peripherals for real-time applications

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙏 Acknowledgments

- **Urmit Kikani** – [22bec137@nirmauni.ac.in](mailto:22bec137@nirmauni.ac.in)  

---
