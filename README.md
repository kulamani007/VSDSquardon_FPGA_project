# VSDSquadron FPGA Mini Board: RGB LED Blink Project
---

## Table of Contents  
1. [Project Overview](#project-overview)  
2. [Dependencies & Setup](#dependencies--setup)  
3. [Repository Structure](#repository-structure)  
4. [Build & Flash Instructions](#build--flash-instructions)  
5. [Pin Mapping & Hardware Connections](#pin-mapping--hardware-connections)  
6. [Verilog Code Explanation](#verilog-code-explanation)  
7. [PCF File Details](#pcf-file-details)  
8. [Makefile Breakdown](#makefile-breakdown)  
9. [Troubleshooting](#troubleshooting)  
10. [Documentation & Reporting](#documentation--reporting)  
11. [License](#license)  

---

## Project Overview  
This project demonstrates how to program the **VSDSquadron FPGA Mini Board** to blink blue and green LEDs alternately using Verilog. The design utilizes:  
- **Internal Oscillator**: Generates a 48 MHz clock signal.  
- **Frequency Counter**: Divides the clock to create a visible blink effect (~1 Hz).  
- **RGB LED Driver**: Maps the counter output to the onboard LEDs.  

---

## Dependencies & Setup  
### Tools Required  
1. **Yosys**: Open-source synthesis tool for Verilog.  
2. **nextpnr**: Place-and-route tool for FPGAs.  
3. **openFPGALoader**: Programmer for flashing the FPGA.  

### Installation (Ubuntu)  
```bash
# Install dependencies  
sudo apt install build-essential clang bison flex libreadline-dev gawk tcl-dev libffi-dev git  

# Install Yosys  
git clone https://github.com/YosysHQ/yosys.git  
cd yosys && make && sudo make install  

# Install nextpnr  
git clone https://github.com/YosysHQ/nextpnr.git  
cd nextpnr && cmake . && make && sudo make install  

# Install openFPGALoader  
sudo apt install openfpgaloader
