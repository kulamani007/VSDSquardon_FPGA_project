`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2025 21:37:18
// Design Name: 
// Module Name: VSD_project
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top (
  // Sensor Interface
  inout  SDA,        // P9 (GPIO0)
  output SCL,        // P10 (GPIO1)
  // UART Interface
  output UART_TX,    // P4 (GPIO2)
  // Clock
  input  hw_clk      // 12MHz external clock
);

  // Clock Generation
  wire clk_12mhz = hw_clk;  // Use external clock

  // Sensor Data
  wire [15:0] sensor_data;
  wire data_valid;
  
  // UART Packet
  wire [7:0] uart_byte;
  wire pkt_ready;

  // I2C Controller
  i2c_controller i2c(
    .clk(clk_12mhz),
    .reset(1'b0),
    .sda(SDA),
    .scl(SCL),
    .sensor_data(sensor_data),
    .data_valid(data_valid)
  );

  // Packet Formatter
  packetizer pkt(
    .clk(clk_12mhz),
    .reset(1'b0),
    .sensor_data(sensor_data),
    .data_valid(data_valid),
    .uart_data(uart_byte),
    .pkt_ready(pkt_ready)
  );

  // UART Transmitter
  uart_tx transmitter(
    .clk(clk_12mhz),
    .reset(1'b0),
    .data_in(uart_byte),
    .tx_start(pkt_ready),
    .tx_out(UART_TX)
  );

endmodule
