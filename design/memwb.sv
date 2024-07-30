`timescale 1ns/1ns

module memwb(
  input clk,
  input[31:0] read_data_datamem,
  input[31:0] exmem_aluresult,
  input[4:0] exmem_rd,
  input exmem_regwrite,
  input exmem_memtoreg,
  output reg[31:0] memwb_read_data_datamem,
  output reg[31:0] memwb_aluresult,
  output reg [4:0] memwb_rd,
  output reg memwb_regwrite,
  output reg memwb_memtoreg
);
  always@(posedge clk)
    begin
      memwb_read_data_datamem<=read_data_datamem;
      memwb_aluresult<=exmem_aluresult;
      memwb_rd<=exmem_rd;
      memwb_regwrite<=exmem_regwrite;
      memwb_memtoreg<=exmem_memtoreg;
    end
  initial 
    begin
      memwb_read_data_datamem<='0;
      memwb_aluresult<='0;
      memwb_rd<='0;
      memwb_regwrite<='0;
      memwb_memtoreg<='0;
    end
endmodule
  