`timescale 1ns/1ns
//actually 4:1 mux but only 3 inputs

module mux3_1(
  input[31:0] in1,
  input[31:0] in2,
  input[31:0] in3,
  input[1:0] select,
  output reg[31:0] out
);
  
  always@(*)
    begin
      case(select)
        2'b00:out<=in1;
        2'b10:out<=in2;
        2'b01:out<=in3;
        2'b11:out<='z;//impossible case
      endcase
    end
endmodule