`timescale 1ns/1ns
//implements branch not taken prediction
//happens in decode stage
module branch_logic(
  input[31:0] read_data_1,
  input[31:0] read_data_2,
  input[31:0] ifid_pc, 
  input[31:0] immgen,
  input branch,
  output reg pc_src,
  output reg[31:0] branch_addr,
  output reg if_flush
);
  
  always@(*)
    begin
      if((read_data_1==read_data_2) && (branch))
        begin
          branch_addr<=ifid_pc+(immgen);
          pc_src<=0;
          if_flush<=1;
        end
      else
        begin
        pc_src<=1;
        if_flush<=0;
        end
      
    end
endmodule