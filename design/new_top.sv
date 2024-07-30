`include "instruction_memory.sv"
`include "register_file.sv"
`include "mux2_1.sv"
`include "immediate_generator.sv"
`include "alu.sv"
`include "alu_control.sv"
`include "data_memory.sv"
`include "pc.sv"
`include "control_unit.sv"
`include "adder.sv"
`include "ifid.sv"
`include "idex.sv"
`include "exmem.sv"
`include "memwb.sv"
`include "forwarding_unit.sv"
`include "hazard_detection_unit.sv"
`include "mux2_1_7bit.sv"
`include "mux3_1.sv"
`include "branch_logic.sv"

`timescale 1ns/1ns

module new_top(
  input clk,
  input reset
);
  //fetch stage
  wire[31:0] mux2pc;
  wire pcwrite;
  wire[31:0] pc_out;
  wire[31:0] inst;
  wire[31:0] pc_adder_out;
  wire[31:0] constant_value_wire;  
  assign constant_value_wire=32'd4;
  //decode stage
  wire[31:0] ifid_pc;
  wire[31:0] ifid_inst;
  wire[31:0] immgen;
  wire[31:0] read_data_1;
  wire[31:0] read_data_2;
  wire ifidwrite;
  wire hazard_unit_mux_control;
  wire if_flush;
  wire pc_src;//determined by branch logic
  wire[6:0] control_unit2mux;//alusrc,aluop[1:0],memread,memwrite,regwrite,memtoreg
  wire[6:0] mux2idex;//need to combine the control signals
  wire[31:0] branch_adder_out;
  wire[6:0] zero_line;
  assign zero_line='0;
  wire branch;
  //execute stage
  wire idex_memread;
  wire idex_memwrite;
  wire idex_regwrite;
  wire idex_memtoreg;
  wire idex_alusrc;
  wire[1:0] idex_aluop;
  wire[4:0] idex_rs1;
  wire[4:0] idex_rs2;
  wire[4:0] idex_rd;
  wire[31:0] idex_read_data_1;
  wire[31:0] idex_read_data_2;
  wire[31:0] idex_immgen;
  wire[31:0] idex_inst;
  wire[31:0] mux1toalu;
  wire[31:0] mux2ato2b;
  wire[31:0] mux2btoalu;
  wire[1:0] forwarda;
  wire[1:0] forwardb;
  wire[31:0] aluresult;
  wire[31:0] alu_control;
  //mem stage
  wire[31:0] exmem_data_addr;
  wire[31:0] exmem_write_data;
  wire[4:0] exmem_rd;
  wire exmem_regwrite;
  wire exmem_memtoreg;
  wire exmem_memread;
  wire exmem_memwrite;
  wire[31:0] datamem_out;
  //wb stage
  wire[31:0] mux2writedata_regfile;
  wire[31:0] memwb_read_data_datamem;
  wire[31:0] memwb_aluresult;
  wire[4:0] memwb_rd;
  wire memwb_regwrite;
  wire memwb_memtoreg;
  
  mux2_1 pc_select_mux(
    .in1(branch_adder_out),
    .in2(pc_adder_out),
    .s(pc_src),
    .out(mux2pc)
);
  
  pc pc1(
    .clk(clk),
    .reset(reset),
    .pcwrite(pcwrite),
    .pc_in(mux2pc),
    .pc_out(pc_out)
);
    
  instruction_memory #(.noal(8))instmem1(
    .read_address(pc_out),
    .instruction_out(inst)
  );
  
  adder adder1(
    .in1(pc_out),
    .in2(constant_value_wire),
    .out(pc_adder_out)
);
  
  ifid ifid1(
    .clk(clk),
    .ifidwrite(ifidwrite),
    .if_flush(if_flush),//will be controlled by branching logic
    .pc(pc_out),
    .inst(inst),
    .ifid_inst(ifid_inst),
    .ifid_pc(ifid_pc)
);
  
  hazard_detection_unit hdu1(
    .idex_memread(idex_memread),
    .idex_rd(idex_rd),
    .ifid_rs1(ifid_inst[19:15]),
    .ifid_rs2(ifid_inst[24:20]),
    .pcwrite(pcwrite),
    .ifid_write(ifidwrite),
    .mux_control(hazard_unit_mux_control)
);
  
  control_unit cu1(
    .inst_slice(ifid_inst[6:0]),
    .alusrc(control_unit2mux[6]),
    .memtoreg(control_unit2mux[0]),
    .regwrite(control_unit2mux[1]),
    .memread(control_unit2mux[3]),
    .memwrite(control_unit2mux[2]),
    .branch(branch),
    .aluop(control_unit2mux[5:4])
);
  
  immediate_generator immgen1(
    .inst(ifid_inst),
    .out(immgen)
);
  
  register_file regfile1(
    .read_reg_1(ifid_inst[19:15]),
    .read_reg_2(ifid_inst[24:20]),
    .write_reg(ifid_inst[11:7]),
    .write_data(mux2writedata_regfile),
    .reg_write(memwb_regwrite),
    .read_data_1(read_data_1),
    .read_data_2(read_data_2)
);
  
  mux2_1_7bit control_unit_mux(
    .in1(control_unit2mux),
    .in2(zero_line),
    .s(hazard_unit_mux_control),//select line
    .out(mux2idex)
);
  
  branch_logic branch_logic1(
    .read_data_1(read_data_1),
    .read_data_2(read_data_2),
    .ifid_pc(ifid_pc), 
    .immgen(immgen),
    .branch(branch),
    .pc_src(pc_src),
    .branch_addr(branch_adder_out)
);
  
  idex idex1(
    .clk(clk),
    .read_data_1(read_data_1),
    .read_data_2(read_data_2),
    .ifid_inst(ifid_inst),//passing this for alu control unit
    .immgen(immgen),
    .ifid_rs1(ifid_inst[19:15]),
    .ifid_rs2(ifid_inst[24:20]),
    .ifid_rd(ifid_inst[11:7]),
    .alusrc(control_unit2mux[6]),
    .aluop(control_unit2mux[5:4]),
    .memread(control_unit2mux[3]),
    .memwrite(control_unit2mux[2]),
    .regwrite(control_unit2mux[1]),
    .memtoreg(control_unit2mux[0]),
    .idex_rs1(idex_rs1),
    .idex_rs2(idex_rs2),
    .idex_rd(idex_rd),
    .idex_read_data_1(idex_read_data_1),
    .idex_read_data_2(idex_read_data_2),
    .idex_immgen(idex_immgen),
    .idex_inst(idex_inst),
    .idex_memread(idex_memread),
    .idex_memwrite(idex_memwrite),
    .idex_regwrite(idex_regwrite),
    .idex_memtoreg(idex_memtoreg),
    .idex_alusrc(idex_alusrc),
    .idex_aluop(idex_aluop)
);
  
  forwarding_unit forwarding_unit1(
    .exmem_rd(exmem_rd),
    .memwb_rd(memwb_rd),
    .idex_rs1(idex_rs1),
    .idex_rs2(idex_rs2),
    .exmem_regwrite(exmem_regwrite),
    .memwb_regwrite(memwb_regwrite),
    .forwarda(forwarda),
    .forwardb(forwardb)
);
  
  mux3_1 mux3_1_for_aluinput1(
    .in1(idex_read_data_1),
    .in2(exmem_data_addr),
    .in3(mux2writedata_regfile),
    .select(forwarda),
    .out(mux1toalu)
);
  
  mux3_1 mux3_1_for_aluinput2(
    .in1(idex_read_data_2),
    .in2(exmem_data_addr),
    .in3(mux2writedata_regfile),
    .select(forwardb),
    .out(mux2ato2b)
);
  
  mux2_1 mux2b(
    .in1(mux2ato2b),
    .in2(idex_immgen),
    .s(idex_alusrc),//select line
    .out(mux2btoalu)
); 

  
  alu_control alu_control1(
    .aluop(idex_aluop),
    .func({idex_inst[30],idex_inst[14:12]}),//i[30],i[14-12]
    .alu_control(alu_control)
);
  
  alu alu1(
    .in1(mux1toalu),
    .in2(mux2btoalu),
    .alu_control(alu_control),
    .out(aluresult),
    .zero()
);
  
  exmem exmem1(
    .clk(clk),
    .aluresult(aluresult),
    .idex_read_data_2(idex_read_data_2),
    .idex_rd(idex_rd),
    .idex_memread(idex_memread),
    .idex_memwrite(idex_memwrite),
    .idex_regwrite(idex_regwrite),
    .idex_memtoreg(idex_memtoreg),
    .exmem_data_addr(exmem_data_addr),
    .exmem_write_data(exmem_write_data),
    .exmem_rd(exmem_rd),
    .exmem_regwrite(exmem_regwrite),
    .exmem_memtoreg(exmem_memtoreg),
    .exmem_memread(exmem_memread),
    .exmem_memwrite(exmem_memwrite)
);
  
  data_memory #(.noal(8))data_memory1(
    .memread(exmem_memread),
    .memwrite(exmem_memwrite),
    .address(exmem_data_addr),
    .write_data(exmem_write_data),
    .read_data(datamem_out)
);
  
  memwb memwb1(
    .clk(clk),
    .read_data_datamem(datamem_out),
    .exmem_aluresult(exmem_data_addr),
    .exmem_rd(exmem_rd),
    .exmem_regwrite(exmem_regwrite),
    .exmem_memtoreg(exmem_memtoreg),
    .memwb_read_data_datamem(memwb_read_data_datamem),
    .memwb_aluresult(memwb_aluresult),
    .memwb_rd(memwb_rd),
    .memwb_regwrite(memwb_regwrite),
    .memwb_memtoreg(memwb_memtoreg)
);
  
  mux2_1 mux_write_data(
    .in1(memwb_read_data_datamem),
    .in2(memwb_aluresult),
    .s(memwb_memtoreg),//select line
    .out(mux2writedata_regfile)
); 
    