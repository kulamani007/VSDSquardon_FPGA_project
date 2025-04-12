`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2025 21:45:30
// Design Name: 
// Module Name: packetizer
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


module packetizer(
  input clk,
  input reset,
  input [15:0] sensor_data,
  input data_valid,
  output [7:0] uart_data,
  output reg pkt_ready
);

  parameter HEADER = 8'hAA;
  parameter SENSOR_ID = 8'h01;
  
  reg [2:0] byte_counter;
  reg [31:0] shift_reg;

  always @(posedge clk) begin
    if(reset) begin
      byte_counter <= 0;
      pkt_ready <= 0;
    end else if(data_valid) begin
      shift_reg <= {HEADER, SENSOR_ID, sensor_data[15:8], sensor_data[7:0]};
      byte_counter <= 5;  // Total packet bytes
      pkt_ready <= 1;
    end else if(byte_counter > 0) begin
      shift_reg <= shift_reg >> 8;
      byte_counter <= byte_counter - 1;
      pkt_ready <= (byte_counter == 1) ? 0 : 1;
    end
  end

  assign uart_data = shift_reg[7:0];

endmodule
