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


module VSD_project(
  input CLK12MHZ,
  input reset,
  inout SDA,
  output SCL,
  output UART_TX
);

  wire [15:0] sensor_data;
  wire data_valid;
  wire [7:0] uart_byte;
  wire pkt_ready;

  i2c_controller i2c(
    .clk(CLK12MHZ),
    .reset(reset),
    .sda(SDA),
    .scl(SCL),
    .sensor_data(sensor_data),
    .data_valid(data_valid)
  );

  packetizer pkt(
    .clk(CLK12MHZ),
    .reset(reset),
    .sensor_data(sensor_data),
    .data_valid(data_valid),
    .uart_data(uart_byte),
    .pkt_ready(pkt_ready)
  );

  uart_tx transmitter(
    .clk(CLK12MHZ),
    .reset(reset),
    .data_in(uart_byte),
    .tx_start(pkt_ready),
    .tx_out(UART_TX),
    .tx_done()
  );

endmodule
