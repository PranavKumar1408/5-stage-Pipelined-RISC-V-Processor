`timescale 1ns/1ns

module pc(
  input clk,
  input reset,
  input pcwrite,
  input[31:0] pc_in,
  output reg[31:0] pc_out
);
  always@(posedge clk)
    begin
      if(reset)
        pc_out<=0;
      else if(pcwrite)
        pc_out<=pc_out;
      else
        pc_out<=pc_in;
    end
endmodule