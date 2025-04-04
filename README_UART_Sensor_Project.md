
# UART Sensor Data Transmission Project for VSDSquadron FPGA Mini

**GitHub Repository**: [Your Repository Link]

---

## Table of Contents

1. [Project Objective](#project-objective)
2. [Design Documentation](#design-documentation)
   - [Block Diagram](#block-diagram)
   - [Circuit Diagram](#circuit-diagram)
3. [Implementation](#implementation)
   - [Hardware Setup](#hardware-setup)
   - [Synthesis & Programming](#synthesis--programming)
4. [Testing & Verification](#testing--verification)
5. [Code Walkthrough](#code-walkthrough)
6. [Results](#results)
7. [Troubleshooting](#troubleshooting)
8. [Documentation](#documentation)
9. [License](#license)

---

## Project Objective

Implement a system on the **VSDSquadron FPGA Mini** that acquires data from a sensor and transmits it via UART to a receiving device, such as a PC. This project validates the FPGA's capability to interface with sensors and perform serial communication.

---

## Design Documentation

### Block Diagram

![Block Diagram](docs/block_diagram.png)

**Components**:

- **Sensor Module**: Captures environmental data (e.g., temperature, light intensity).
- **FPGA**:
  - **Sensor Interface**: Reads data from the sensor.
  - **UART Transmitter**: Sends sensor data serially.
- **Receiving Device**: Displays received data (e.g., PC running a serial terminal).

### Circuit Diagram

![Circuit Diagram](docs/circuit_diagram.png)

**Connections**:

- **Sensor to FPGA**:
  - **Data Line**: Connect sensor's data output to FPGA's designated input pin.
  - **Power**: Ensure sensor operates at compatible voltage levels with the FPGA.
- **FPGA to Receiving Device**:
  - **TXD (FPGA Pin)** → **RXD (USB-UART Converter)**: Transmit data line.
  - **GND**: Common ground between FPGA and USB-UART converter.

---

## Implementation

### Hardware Setup

**Requirements**:

- **VSDSquadron FPGA Mini Board**.
- **Sensor Module** (e.g., temperature sensor).
- **USB-UART Converter** (e.g., FTDI FT232RL).
- **Connecting Wires**.

**Steps**:

1. **Sensor Connection**:
   - Connect the sensor's data output to the FPGA's designated input pin.
   - Provide appropriate power and ground connections to the sensor.

2. **UART Connection**:
   - Connect the FPGA's TXD pin to the USB-UART converter's RXD pin.
   - Connect ground between the FPGA and the USB-UART converter.

### Synthesis & Programming

1. **Obtain the Code**:
   - Clone the repository containing the Verilog code:
     ```bash
     git clone https://github.com/yourusername/your-repo.git
     cd your-repo
     ```

2. **Build the Project**:
   - Use the provided Makefile to synthesize the design:
     ```bash
     make build
     ```

3. **Program the FPGA**:
   - Flash the synthesized bitstream onto the FPGA:
     ```bash
     make flash
     ```

---

## Testing & Verification

1. **Set Up Serial Terminal**:
   - Use software like PuTTY or Tera Term.
   - Configure with the following settings:
     - **Baud Rate**: 9600 (or as defined in the code).
     - **Data Bits**: 8.
     - **Stop Bits**: 1.
     - **Parity**: None.

2. **Stimulate the Sensor**:
   - Expose the sensor to varying conditions to generate data changes.

3. **Observe Received Data**:
   - Monitor the serial terminal for incoming data corresponding to sensor readings.

**Expected Output**:

- Real-time sensor data displayed on the serial terminal, updating as sensor conditions change.

---

## Code Walkthrough

**Key Modules**:

1. **Sensor Interface Module**:
   - Handles communication with the sensor to retrieve data.
   - Converts sensor signals into digital data for processing.

2. **UART Transmitter Module**:
   - Manages the serial transmission of data.
   - Formats data according to UART protocol (start bit, data bits, optional parity, stop bit).

3. **Top-Level Module**:
   - Integrates the sensor interface and UART transmitter.
   - Coordinates data flow from the sensor to the UART transmitter.

**Top-Level Module Overview**:

```verilog
module top (
    input wire clk,        // System clock
    input wire sensor_data,// Data input from sensor
    output wire txd        // UART transmit data output
);
    // Instantiate sensor interface
    sensor_interface sensor_if (
        .clk(clk),
        .sensor_data(sensor_data),
        .data_out(data_to_uart)
    );

    // Instantiate UART transmitter
    uart_tx uart_transmitter (
        .clk(clk),
        .data_in(data_to_uart),
        .txd(txd)
    );
endmodule
```

---

## Results

- **Successful Data Transmission**: Sensor data is accurately transmitted via UART and displayed on the receiving device.
- **Real-Time Monitoring**: Changes in sensor conditions are promptly reflected in the received data.

---

## Troubleshooting

| Issue               | Possible Cause                               | Solution                                      |
|---------------------|----------------------------------------------|-----------------------------------------------|
| No data received    | Incorrect UART settings or connections       | Verify baud rate, data bits, and wiring       |
| Garbled data        | Mismatched baud rates                        | Ensure both devices use the same baud rate    |
| Sensor not responding| Improper power supply or connections        | Check sensor power requirements and wiring    |

---

## Documentation

1. **Block Diagram**:
   - Located in the `docs/` folder as `block_diagram.png`.

2. **Circuit Diagram**:
   - Located in the `docs/` folder as `circuit_diagram.png`.

3. **Detailed Report**:
   - Includes design rationale, implementation details, and testing outcomes.
   - Available as `report.pdf` in the `docs/` folder.

4. **Video Demonstration**:
   - Demonstrates the system in operation, showing sensor data transmission.
   - [Watch the Video Demonstration](https://youtu.be/your-video-link)

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
