`timescale 1ns/1ns

module control_unit(
  input[6:0] inst_slice,
  output reg alusrc,
  output reg memtoreg,
  output reg regwrite,
  output reg memread,
  output reg memwrite,
  output reg branch,
  output reg[1:0] aluop
);
  always@(*)
    begin
      case(inst_slice)
        7'b0110011:{alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop}=8'b00100010;
        7'b0000011:{alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop}=8'b11110000;
        7'b0100011:{alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop}=8'b1x001000;
        7'b1100011:{alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop}=8'b0x000101;
        //7'b0000000:{alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop}=8'b00000100;
        default:{alusrc,memtoreg,regwrite,memread,memwrite,branch,aluop}='x;
      endcase
    end
endmodule