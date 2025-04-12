`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2025 21:47:53
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
  input clk,
  input reset,
  input [7:0] data_in,
  input tx_start,
  output reg tx_out,
  output tx_done
);

  parameter CLK_FREQ = 12_000_000;  // VSDSquadron clock
  parameter BAUD = 9600;
  parameter DIVISOR = CLK_FREQ / BAUD;

  reg [12:0] baud_counter;
  reg [3:0] bit_index;
  reg tx_active;

  parameter IDLE = 2'd0, START_BIT = 2'd1, DATA_BITS = 2'd2, STOP_BIT = 2'd3;
  reg [1:0]current_state;

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      current_state <= IDLE;
      tx_out <= 1'b1;
      baud_counter <= 0;
    end else begin
      case(current_state)
        IDLE: begin
          if(tx_start) begin
            tx_out <= 1'b0;  // Start bit
            current_state <= START_BIT;
            baud_counter <= 0;
          end
        end
        START_BIT: begin
          if(baud_counter == DIVISOR-1) begin
            tx_out <= data_in[0];
            bit_index <= 1;
            current_state <= DATA_BITS;
          end else baud_counter <= baud_counter + 1;
        end
        // Complete implementation for 8 data bits
        STOP_BIT: begin
          tx_out <= 1'b1;
          if(baud_counter == DIVISOR-1) current_state <= IDLE;
          else baud_counter <= baud_counter + 1;
        end
      endcase
    end
  end

  assign tx_done = (current_state == IDLE);

endmodule
