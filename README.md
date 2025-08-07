# Async_FIFO

Verilog implementation of an **Asynchronous FIFO** using Gray coding and two-flop synchronizers.



## Description

This project implements an **Asynchronous FIFO** with the following specifications:

- **Depth:** 64 (Address width = 6 bits)
- **Data width:** 16 bits
- **Write/Read Pointer Synchronization:**  
  - Gray-coded pointers for reliable clock-domain crossing  
  - Two-flop synchronizers for metastability protection
- **Addressing:** Binary-coded pointer for memory access

The design is inspired by and follows guidelines from:  
*"Simulation and Synthesis Techniques for Asynchronous FIFO Design"* by **Clifford E. Cummings**, Sunburst Design, Inc.  
*Highly recommended reading for deeper understanding.*

- Verilog HDL
- Simulation: ModelSim or any Verilog simulator
- Synthesis: Quartus / Vivado (compatible)

