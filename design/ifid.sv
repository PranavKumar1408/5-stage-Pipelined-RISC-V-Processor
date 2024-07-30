`timescale 1ns/1ns

module ifid(
  input clk,
  input ifidwrite,
  input if_flush,//will be controlled by branching logic
  input[31:0] pc,
  input[31:0] inst,
  output reg [31:0] ifid_inst,
  output reg[31:0] ifid_pc
);
  always@(posedge clk)
    begin
      if(if_flush)
        begin
          ifid_inst<='0;
          ifid_pc<='0;
        end
      else if(ifidwrite)
        begin
          ifid_pc<=ifid_pc;
      	  ifid_inst<=ifid_inst;
        end
      else
        begin
          ifid_pc<=pc;
          ifid_inst<=inst;
        end
    end
  
  initial
    begin
      ifid_inst<='0;
      ifid_pc<='0;
    end
endmodule