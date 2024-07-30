`timescale 1ns/1ns
//branch not taken implementing 1st
//how does flushing work?who controls it?how long to stall for?how to implement dynmaic branch prediction?
  
  //for load use hazard stall next 2 instructions by 1 cycle
  //keep pc and ifid same,all idex control signals=0
module hazard_detection_unit(
  input idex_memread,
  input[4:0] idex_rd,
  input[4:0] ifid_rs1,
  input[4:0] ifid_rs2,
  output reg pcwrite,
  output reg ifid_write,
  output reg mux_control
);
  
  always@(*)
    begin
      if(idex_memread && ((idex_rd==ifid_rs1)||(idex_rd==ifid_rs2)))
        begin
          pcwrite<=1;
          ifid_write<=1;
          mux_control<=1;//chooses 0 as input
        end
      end
endmodule
  