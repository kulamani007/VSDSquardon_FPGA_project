# UART Transmitter (uart_tx) Project Documentation

## Overview
This project implements a **UART (Universal Asynchronous Receiver-Transmitter) transmitter** on an FPGA, enabling serial communication with devices like PCs or microcontrollers. It features:
- **Configurable Baud Rate**
- **8-bit Data Transmission**
- **Optional Parity Bit Support**
- **1 Stop Bit**

This project is useful for embedded system developers and FPGA designers who need a reliable UART interface.

---

## Table of Contents
1. [Design Documentation](#design-documentation)  
   - [Block Diagram](#block-diagram)  
   - [Circuit Diagram](#circuit-diagram)  
2. [Implementation](#implementation)  
   - [Hardware Setup](#hardware-setup)  
   - [Synthesis & Programming](#synthesis--programming)  
3. [Testing & Verification](#testing--verification)  
4. [Code Walkthrough](#code-walkthrough)  
5. [Results](#results)  
6. [Troubleshooting](#troubleshooting)  
7. [Future Enhancements](#future-enhancements)  
8. [License](#license)  

---

## Design Documentation

### Block Diagram  
[![Block Diagram](images/block_diagram.png)  ](https://github.com/kulamani007/VSDSquardon_FPGA_project/issues/2)
The UART transmitter module consists of:
- **Baud Rate Generator**: Divides the system clock to produce the UART clock.
- **Finite State Machine (FSM)**: Manages transmission states (IDLE, START, DATA, PARITY, STOP).
- **Shift Register**: Shifts data bits serially onto the TX line.
- **Parity Generator**: Optional parity bit calculation (even/odd).

### Circuit Diagram  
[![Circuit Diagram](images/circuit_diagram.png)](https://github.com/kulamani007/VSDSquardon_FPGA_project/issues/2)  
FPGA connections:
- **FPGA TX Pin** → Connected to the RX pin of the receiving device (e.g., USB-UART converter).
- **Voltage Level Matching**: Use resistors or a level shifter if interfacing with 3.3V/5V devices.

---

## Implementation

### Hardware Setup  
#### Requirements  
- FPGA board (e.g., **VSDSquadron FPGA Mini**).  
- USB-UART converter (e.g., **FTDI FT232RL**).  
- Jumper wires and resistors (if voltage shifting is required).  

#### Steps  
1. Connect the FPGA’s TX pin to the USB-UART converter’s RX pin.
2. Connect ground (GND) between the FPGA and the converter.

### Synthesis & Programming  
1. **Synthesize Code**:
   ```bash
   # Using Xilinx Vivado/Intel Quartus  
   create_project uart_tx  
   add_files uart_tx.v  
   synthesize and generate bitstream  
   ```
2. **Program FPGA**:
   ```bash
   # Upload the generated bitstream to the FPGA
   make flash
   ```

---

## Testing & Verification

### 1. Connect FPGA to PC:
Use the USB-UART converter to link the FPGA’s TX to the PC’s USB port.

### 2. Serial Terminal Configuration:
| Parameter | Value |
|-----------|-------|
| **Baud Rate** | 9600 |
| **Data Bits** | 8 |
| **Stop Bits** | 1 |
| **Parity** | None |

### 3. Transmit Data:
The FPGA sends predefined data (e.g., "Hello World").
Verify received data using a terminal (e.g., **PuTTY, Tera Term**).

---

## Code Walkthrough

### Key Components of `uart_tx.v`:
#### **Parameters**:
```verilog
parameter CLK_FREQ = 100_000_000; // FPGA clock frequency  
parameter BAUD_RATE = 9600;  
```

#### **State Machine**:
```verilog
typedef enum {IDLE, START, DATA, PARITY, STOP} state_t;  
state_t current_state;  
```

#### **Baud Rate Counter**:
```verilog
always @(posedge clk) begin  
  if (count == CLK_FREQ / BAUD_RATE - 1) begin  
    baud_tick <= 1;  
    count <= 0;  
  end else begin  
    count <= count + 1;  
    baud_tick <= 0;  
  end  
end  
```

---

## Results

### **Successful Transmission:**
**Expected Serial Terminal Output:**
```
Sent: Hello World
Received: Hello World
```

### **Video Demo:**  
[Watch UART Transmission](#)

---

## Troubleshooting
| Issue | Solution |
|--------|----------|
| No data received | Check baud rate and TX/RX wiring |
| Garbled output | Verify clock synchronization |
| Voltage mismatch | Add level shifter/resistors |
| FPGA not programming | Check USB connection and try again |

---

## Future Enhancements
- **Add UART Receiver (`uart_rx`)** to implement full-duplex communication.
- **Support Higher Baud Rates** for increased data transfer speed.
- **Integrate Handshaking Signals** (RTS/CTS) for better control.

---

## License
This project is licensed under the **MIT License**. Feel free to modify and distribute!

---

## Contribute & Support
- Submit issues and feature requests via GitHub.
- Fork the repository and contribute improvements!

