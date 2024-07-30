`timescale 1ns/1ns

module data_memory#(parameter noal=8)(//number of address lines
  input memread,
  input memwrite,
  input[noal-1:0] address,
  input[31:0] write_data,
  output reg[31:0] read_data
);
  wire[31:0] fordisplay;
  reg[7:0] data_mem[(2**noal)-1:0];//data_mem refers to an 8 bit wide memory location.There are 256 locations.
  always@(*)
    begin
      if(memread)
        read_data={data_mem[address+3],data_mem[address+2],data_mem[address+1],data_mem[address]};//little endian
      else if(memwrite)
      {data_mem[address+3],data_mem[address+2],data_mem[address+1],data_mem[address]}=write_data;
    end
  
  initial
    begin
      
      {data_mem[3],data_mem[2],data_mem[1],data_mem[0]}=32'h0000_0001;
      {data_mem[7],data_mem[6],data_mem[5],data_mem[4]}=32'h0000_0002;
      {data_mem[11],data_mem[10],data_mem[9],data_mem[8]}=32'h0000_0003;
      {data_mem[15],data_mem[14],data_mem[13],data_mem[12]}=32'h0000_0004;
      {data_mem[19],data_mem[18],data_mem[17],data_mem[16]}=32'h0000_0005;
      {data_mem[23],data_mem[22],data_mem[21],data_mem[20]}=32'h0000_0006;
      {data_mem[27],data_mem[26],data_mem[25],data_mem[24]}=32'h0000_0007;
      {data_mem[31],data_mem[30],data_mem[29],data_mem[28]}=32'h0000_0008;      
    end  
  assign fordisplay={data_mem[7],data_mem[6],data_mem[5],data_mem[4]};
  initial begin
    //$display($time, " datamem4='h%0h", fordisplay);
    //$monitor($time, " datamem4='h%0h", fordisplay);
end
endmodule
  
  
        