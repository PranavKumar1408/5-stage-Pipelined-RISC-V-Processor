`timescale 1ns/1ns

module immediate_generator(
  input[31:0]inst,
  output reg[31:0] out//sign extended immediate field
);
  always@(*)
    begin
      case(inst[6:0])
        7'b0000011:out={{20{inst[31]}},inst[31:20]};//I-type instructions
        7'b0100011:out={{20{inst[31]}},inst[31:25],inst[11:7]};//S-type instructions
        7'b1100011:out={{19{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8],1'b0};//SB-type instructions
        default:out='x;//only R-type remaining(in this case)
      endcase
    end
endmodule
        