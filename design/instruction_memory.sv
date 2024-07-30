`timescale 1ns/1ns

module instruction_memory#(parameter noal=8)(//number of address lines
  input[noal-1:0] read_address,//256 memory locations
  output[31:0] instruction_out//each inst is 32 bits
);
  reg [7:0] inst_mem[(2**noal)-1:0];//each location is 1 byte wide
  
  initial
    begin
      
      
      
      
      /*{inst_mem[3],inst_mem[2],inst_mem[1],inst_mem[0]}=32'b000000000000_00000_011_00001_0000011;//lw x1,0(x0)-->x1=1
      {inst_mem[7],inst_mem[6],inst_mem[5],inst_mem[4]}=32'b0000000_00000_00001_000_00010_0110011;//add x2,x1,x0-->x2=1
      {inst_mem[11],inst_mem[10],inst_mem[9],inst_mem[8]}=32'b0000000_00010_00001_010_00011_0100011;//sw x2,3(x1)-->datamem[4]=1
      */
      
      
      //independent instructions to test pipelining
      /*
      {inst_mem[3],inst_mem[2],inst_mem[1],inst_mem[0]}=32'h0000_8133;//add x2,x1,x0
      {inst_mem[7],inst_mem[6],inst_mem[5],inst_mem[4]}=32'h0000_81b3;//add x3,x1,x0
      {inst_mem[11],inst_mem[10],inst_mem[9],inst_mem[8]}=32'h0000_8233;//add x4,x1,x0
      {inst_mem[15],inst_mem[14],inst_mem[13],inst_mem[12]}=32'h0000_82b3;//add x5,x1,x0
      {inst_mem[19],inst_mem[18],inst_mem[17],inst_mem[16]}=32'h0000_8333;//add x6,x1,x0
      */
      
      
      //dependent instructions to test forwarding
      /*
      {inst_mem[3],inst_mem[2],inst_mem[1],inst_mem[0]}=32'h0000_8133;//add x2,x1,x0
      {inst_mem[7],inst_mem[6],inst_mem[5],inst_mem[4]}=32'h0011_01b3;//add x3,x2,x1
      */
      
      
      //testing load use hazard
      /*
      {inst_mem[3],inst_mem[2],inst_mem[1],inst_mem[0]}=32'h0000_2083;//lw x1,0(x0)--> x1=1
      {inst_mem[7],inst_mem[6],inst_mem[5],inst_mem[4]}=32'h0000_8133;//add x2,x1,x0
      */
      
      
      //testing branching
      /*
      {inst_mem[3],inst_mem[2],inst_mem[1],inst_mem[0]}=32'h0200_0063;//beq x0,x0,16-->should branch to address 32
      {inst_mem[7],inst_mem[6],inst_mem[5],inst_mem[4]}=32'h0000_8133;//add x2,x1,x0
      {inst_mem[35],inst_mem[34],inst_mem[33],inst_mem[32]}=32'h0000_81b3;//add x3,x1,x0
      */
      
      
      
      //testing for branch to same inst(while(1))
      ///*
      {inst_mem[3],inst_mem[2],inst_mem[1],inst_mem[0]}=32'h0000_0063;//beq x0,x0,0
      //*/
      
      
      
      
    end
  assign instruction_out={inst_mem[read_address+3],inst_mem[read_address+2],inst_mem[read_address+1],inst_mem[read_address]};//little endian
endmodule
  