`timescale 1ns/1ns

module mux2_1_7bit(
  input[6:0] in1,
  input[6:0] in2,
  input s,//select line
  output[6:0] out
);
  assign out=s?in2:in1;
  //s=0,out=in1
  //s=1,out=in2
endmodule