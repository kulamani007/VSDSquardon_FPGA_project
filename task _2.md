# UART Loopback Project for VSDSquadron FPGA Mini  


---

## Table of Contents  
1. [Project Objective](#project-objective)  
2. [Repository Structure](#repository-structure)  
3. [Prerequisites](#prerequisites)  
4. [Implementation Steps](#implementation-steps)  
5. [Testing & Verification](#testing--verification)  
6. [Documentation](#documentation)  
7. [License](#license)  

---

## Project Objective  
Implement a **UART loopback mechanism** where data transmitted by the FPGA is immediately received back. This validates the UART functionality and ensures correct serial communication.  

---

## Repository Structure  
```plaintext
UART_Loopback_FPGA/  
├── src/  
│   ├── uart_tx.v        # UART transmitter  
│   ├── uart_rx.v        # UART receiver  
│   └── top.v            # Top-level loopback module  
├── docs/  
│   ├── block_diagram.png  # UART loopback architecture  
│   ├── circuit_diagram.png# FPGA-UART connections  
│   └── report.pdf       # Detailed project report  
├── Makefile             # Build and flash automation  
└── README.md            # This documentation  
```

---

## Prerequisites  
### Tools  
- **Yosys** (Verilog synthesis)  
- **nextpnr** (Place-and-route)  
- **openFPGALoader** (FPGA programming)  

### Installation (Ubuntu)  
```bash
sudo apt install build-essential git  
git clone https://github.com/YosysHQ/yosys && cd yosys && make && sudo make install  
git clone https://github.com/YosysHQ/nextpnr && cd nextpnr && cmake . && make && sudo make install  
sudo apt install openfpgaloader  
```

---

## Implementation Steps  
### 1. Study the Code  
Clone the repository and analyze the loopback logic:
```bash
git clone https://github.com/thesourcerep/VSDSquadron_FM.git  
cd VSDSquadron_FM/uart_loopback  
```

#### Key Code Snippets  
**top.v (Loopback Logic):**  
```verilog
module top (
    input clk,          // FPGA clock (12 MHz)  
    input rxd,          // UART receive pin  
    output txd          // UART transmit pin  
);  

// Instantiate UART transmitter and receiver  
uart_tx transmitter(.clk(clk), .data_in(rx_data), .txd(txd));  
uart_rx receiver(.clk(clk), .rxd(txd), .data_out(rx_data)); // Loopback: txd → rxd  
endmodule  
```

### 2. Hardware Setup  

#### Connections  
| FPGA Pin  | Peripheral    | Description       |
|-----------|--------------|-------------------|
| txd       | USB-UART RX  | Transmit data    |
| rxd       | USB-UART TX  | Receive data     |
| GND       | USB-UART GND | Common ground    |

### 3. Build & Flash  
```bash
make clean    # Remove previous builds  
make build    # Synthesize and compile  
make flash    # Program the FPGA  
```

---

## Testing & Verification  
### 1. Serial Terminal Setup  
Use a terminal like **PuTTY** or **screen**:
```bash
screen /dev/ttyUSB0 115200  # Linux (115200 baud rate)  
```

### 2. Test Loopback  
Send a character (e.g., `A`) from the terminal.
Verify the same character is echoed back.

#### Expected Output  
```plaintext
Sent: A  
Received: A  
```

### 3. Troubleshooting  
| Issue               | Solution                        |
|---------------------|--------------------------------|
| No echo            | Check baud rate and pin mappings |
| Garbage data       | Verify clock frequency (12 MHz) |
| Programming failure | Reconnect USB cable           |

---

## Documentation  
### 1. Block Diagram  https://github.com/kulamani007/VSDSquardon_FPGA_project/issues/1

### 2. Report Contents  
- **Introduction:** Purpose of UART loopback.  
- **Design:** Block/circuit diagrams.  
- **Code Explanation:** Key modules (`uart_tx`, `uart_rx`, `top.v`).  
- **Testing:** Screenshots of terminal output.  
- **Challenges:** Baud rate calibration, signal integrity.  

### 3. Video Demonstration  
**Content:**  
- Hardware connections.  
- Terminal sending/receiving data.  
- FPGA programming process.  

**Upload:** Share via **YouTube** or **Google Drive**.  

---

## License  
This project is licensed under the **MIT License**. See `LICENSE` for details.  

---

## Submit Your Work  
- **Submit via Google Form**: [Submission Link]  
- **Join the Discussion**: [VSDSquadron WhatsApp Group]  

---

### How to Use This README  
1. Replace `[Your Repo Link]` with your **GitHub repository URL**.  
2. Add actual screenshots of **block/circuit diagrams** to the `docs/` folder.  
3. Update the **Testing** section with your **results**.  
4. Upload the **video demonstration** and include its **link** in the report.  

Let me know if you need help refining diagrams or debugging! 🚀

