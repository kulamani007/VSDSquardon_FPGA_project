# VSDSquadron FPGA Mini Board: RGB LED Blink Project

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
10. [License](#license)  

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
```

---

## Repository Structure  
```
VSDSquadron_FPGA_Project/  
├── src/  
│   ├── top.v            # Verilog code for LED control  
│   └── constraints.pcf  # Pin constraint file  
├── Makefile             # Build and flash automation  
└── README.md            # This documentation
```

---

## Build & Flash Instructions  
### Step 1: Build the Project  
```bash
make clean    # Remove previous builds  
make build    # Synthesize and compile the design
```

### Process Explanation:  
- **Synthesis**: `yosys` converts Verilog to a netlist (build/top.json).  
- **Place-and-Route**: `nextpnr` maps the design to the FPGA’s physical resources.  
- **Bitstream Generation**: `icepack` creates a binary file (build/top.bin).  

### Step 2: Flash the FPGA  
```bash
make flash    # Program the FPGA board
```
**Expected Output:** Blue and green LEDs blink alternately at ~1 Hz.  

---

## Pin Mapping & Hardware Connections  
### FPGA Pinout  
| Signal            | FPGA Pin | Board Component  | Description  |
|------------------|---------|----------------|-------------|
| led_rel_id_blue | 40      | Blue LED       | RGB LED (Blue Channel) |
| led_green       | 41      | Green LED      | RGB LED (Green Channel) |
| hw_clk         | 20      | 12 MHz Oscillator | Clock Source |

### Hardware Setup  
1. Connect the board to your computer via USB-C.  
2. Ensure jumpers are set to FPGA programming mode (see datasheet).  

---

## Verilog Code Explanation (`src/top.v`)
### Full Code with Detailed Comments:
```verilog
/* 
 * RGB LED Controller for VSDSquadron FPGA Mini Board
 * Blinks blue/green LEDs alternately at ~1Hz using internal oscillator
 */
module top (
    output led_rel_id_blue,  // Output: Blue LED (Pin 40)
    output led_green,        // Output: Green LED (Pin 41)
    input hw_clk,            // Input: 12MHz reference clock (Pin 20)
    output testwire          // Output: Debug signal (Pin 17)
);

// Internal High-Frequency Oscillator (48MHz)
wire clk_out;
SB_HFOSC #(
    .CLKHF_DIV("0b10")  // Divide by 2 (48MHz/2 = 24MHz)
) OSC (
    .CLKHFEN(1'b1),
    .CLKHFPU(1'b1),
    .CLKHF(clk_out)
);

// Frequency Divider/Counter
reg [23:0] counter;
always @(posedge clk_out) begin
    counter <= counter + 1;
end

// Output Assignments
assign led_rel_id_blue = counter[23];  // Blue LED = MSB
assign led_green = ~counter[23];       // Green LED = inverted MSB
assign testwire = counter[23];         // Debug signal mirroring

endmodule
```

### Key Technical Details:  
- **Clock Management:** Uses FPGA's internal oscillator instead of an external clock.  
- **Frequency Division:** 24-bit counter generates a ~1 Hz blink frequency.  
- **LED Control Logic:** Alternates between blue and green LEDs.  
- **Debug Signal:** Outputs MSB to `testwire` for oscilloscope validation.  

---

## PCF File Details  
### Purpose  
The `constraints.pcf` file maps Verilog signals to physical FPGA pins.  

### Key Entries  
```
set_io led_rel_id_blue 40  # Blue LED  
set_io led_green       41  # Green LED  
set_io hw_clk          20  # Clock input  
```

---

## Makefile Breakdown  
### Key Variables  
```
PROJECT = top          # Verilog module name  
DEVICE = up5k          # FPGA device (iCE40UP5K)  
PACKAGE = sg48         # FPGA package  
```

### Build Targets  
```bash
build:
    yosys -p "synth_ice40 -top $(PROJECT) -json build/$(PROJECT).json" $(PROJECT).v  
    nextpnr-ice40 --$(DEVICE) --package $(PACKAGE) --json build/$(PROJECT).json --pcf constraints.pcf --asc build/$(PROJECT).asc  
    icepack build/$(PROJECT).asc build/$(PROJECT).bin
```

---

## Troubleshooting  
| Issue                       | Solution |
|-----------------------------|----------|
| Driver not found            | Install `libusb-1.0` and retry. |
| Yosys installation fails    | Check `build-essential` and retry. |
| LEDs not blinking           | Verify PCF pin assignments. |
| Programming error           | Ensure USB cable is connected. |

---

## License  
This project is licensed under the **MIT License**. See `LICENSE` for details.  

---
