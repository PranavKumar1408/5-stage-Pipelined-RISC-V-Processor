`timescale 1ns/1ns

module exmem(
  input clk,
  input[31:0] aluresult,
  input[31:0] idex_read_data_2,//this is actually the output of the second mux.it contains the value of the second argument rs2.it is fed to write data of data memory
  input[4:0] idex_rd,
  input idex_memread,
  input idex_memwrite,
  input idex_regwrite,
  input idex_memtoreg,
  output reg[31:0] exmem_data_addr,
  output reg[31:0] exmem_write_data,
  output reg[4:0] exmem_rd,
  output reg exmem_regwrite,
  output reg exmem_memtoreg,
  output reg exmem_memread,
  output reg exmem_memwrite
);
  
  always@(posedge clk)
    begin
      exmem_data_addr<=aluresult;
      exmem_write_data<=idex_read_data_2;
      exmem_rd<=idex_rd;
      exmem_regwrite<=idex_regwrite;
      exmem_memtoreg<=idex_memtoreg;
      exmem_memread<=idex_memread;
      exmem_memwrite<=idex_memwrite;
    end
  initial
    begin
      exmem_data_addr<='0;
      exmem_write_data<='0;
      exmem_rd<='0;
      exmem_regwrite<='0;
      exmem_memtoreg<='0;
      exmem_memread<='0;
      exmem_memwrite<='0;
    end
endmodule