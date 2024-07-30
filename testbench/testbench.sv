`timescale 1ns/1ns

module new_top_tb();
  reg clk;
  reg reset; 
  
  
  new_top new_top1(
    .clk(clk),
    .reset(reset)
  );
  
  initial
    clk=1'b0;
  always
    begin
      #40;
      clk=~clk;
    end 
  

  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
  initial
begin
  reset=1'b1;
  #80;
  reset=1'b0;
end
  
 
      
    
  
  initial #1500 $finish;
  
endmodule