`timescale 1ns/1ns
//refer fig 4.59 for additional mux usage
module forwarding_unit(
  input[4:0] exmem_rd,
  input[4:0] memwb_rd,
  input[4:0] idex_rs1,
  input[4:0] idex_rs2,
  input exmem_regwrite,
  input memwb_regwrite,
  output reg[1:0] forwarda,
  output reg[1:0] forwardb
);
  
  always@(*)
    begin
      if( (exmem_regwrite==1) && (exmem_rd!=0) && (exmem_rd==idex_rs1) )
        forwarda=2'b10;
      else if( (memwb_regwrite==1) && (memwb_rd!=0) && (~((exmem_regwrite==1) && (exmem_rd!=0) && (exmem_rd==idex_rs1))) && (memwb_rd==idex_rs1))
        forwarda=2'b01;
      else
        forwarda=2'b00;
    end
  
  always@(*)
    begin
      if( (exmem_regwrite==1) && (exmem_rd!=0) && (exmem_rd==idex_rs2) )
        forwardb=2'b10;
      else if( (memwb_regwrite==1) && (memwb_rd!=0) && (~((exmem_regwrite==1) && (exmem_rd!=0) && (exmem_rd==idex_rs2))) && (memwb_rd==idex_rs2))
        forwardb=2'b01;
      else
        forwardb=2'b00;
    end
  
endmodule
      
      