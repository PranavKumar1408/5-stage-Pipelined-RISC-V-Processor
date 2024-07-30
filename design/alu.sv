`timescale 1ns/1ns

module alu(
  input [31:0] in1,
  input [31:0] in2,
  input [3:0] alu_control,
  output reg[31:0] out,
  output zero
);
  always@(*)
    begin
      case(alu_control)
        4'b0000:out=in1&in2;
        4'b0001:out=in1|in2;
        4'b0010:out=in1+in2;
        4'b0110:out=in1-in2;
        default:out='x;
      endcase
    end
  assign zero=(out=='0);
endmodule
      
        