`timescale 1ns/1ns

module alu_control(
  input[1:0] aluop,
  input[3:0] func,//i[30],i[14-12]
  output[3:0] alu_control
);
  assign alu_control[3]=0;
  assign alu_control[2]=(func[1]&aluop[1])|aluop[0];
  assign alu_control[1]=(~func[2])|(~aluop[1]);
  assign alu_control[0]=(func[0]|func[3])&aluop[1];
endmodule
  
        