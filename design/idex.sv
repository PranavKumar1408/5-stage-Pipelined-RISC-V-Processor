`timescale 1ns/1ns

module idex(
  input clk,
  input[31:0] read_data_1,
  input[31:0] read_data_2,
  input[31:0] ifid_inst,
  input[31:0] immgen,
  input[4:0] ifid_rs1,
  input[4:0] ifid_rs2,
  input[4:0] ifid_rd,
  input alusrc,
  input[1:0] aluop,
  input memread,
  input memwrite,
  input regwrite,
  input memtoreg,
  output reg[4:0] idex_rs1,
  output reg[4:0] idex_rs2,
  output reg[4:0] idex_rd,
  output reg[31:0] idex_read_data_1,
  output reg[31:0] idex_read_data_2,
  output reg[31:0] idex_immgen,
  output reg[31:0] idex_inst,
  output reg idex_memread,
  output reg idex_memwrite,
  output reg idex_regwrite,
  output reg idex_memtoreg,
  output reg idex_alusrc,
  output reg[1:0] idex_aluop
);
  always@(posedge clk)
    begin
      idex_rs1<=ifid_rs1;
      idex_rs2<=ifid_rs2;
      idex_rd<=ifid_rd;
      idex_read_data_1<=read_data_1;
      idex_read_data_2<=read_data_2;
      idex_inst<=ifid_inst;
      idex_immgen<=immgen;
      idex_memread<=memread;
      idex_memwrite<=memwrite;
      idex_regwrite<=regwrite;
      idex_memtoreg<=memtoreg;
      idex_alusrc<=alusrc;
      idex_aluop<=aluop;
    end
  initial
    begin
      idex_rs1<='0;
      idex_rs2<='0;
      idex_rd<='0;
      idex_read_data_1<='0;
      idex_read_data_2<='0;
      idex_inst<='0;
      idex_immgen<='0;
      idex_memread<='0;
      idex_memwrite<='0;
      idex_regwrite<='0;
      idex_memtoreg<='0;
      idex_alusrc<='0;
      idex_aluop<='0;
    end
endmodule
  