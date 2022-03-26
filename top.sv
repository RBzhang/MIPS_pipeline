`include "define.sv"

module top(
    input clk, rst,
    output wire [`DATA_WIDTH-1:0] result,
    output wire [`DATA_WIDTH-1:0] pc_out,
    output wire [`DATA_WIDTH-1:0]   code_out
);
wire PCSrc;
wire [`DATA_WIDTH-1:0]  i_jump;

wire [`DATA_WIDTH-1:0] code_if,  pc_i;
wire [`DATA_WIDTH-1:0] code, code_id;
wire  jump, read_error;
wire [`ADR_WIDTH-1:0]  pc;
wire [`ADR_WIDTH-1:0] pc_4_if , pc_4_id,pc_imme, pc_4_ex;
wire is_stop , memread_ex;
wire [4:0] rd_ex_id;
assign code_out = code;
assign pc_out = pc;
assign pc_4_if = (is_stop == 1'b1) ? pc : (pc + 4'H4);
pc_new pc_clk(.clk(clk),.rst(rst),.i_valid(PCSrc),.i_pc(pc_4_if),.jump(jump),.imme(pc_imme),.addr(i_jump),.o_pc(pc));
memory_read i_memory(.pc(pc), .code(code), .o_error(read_error));
IF_ID if_id(.clk(clk),.rst(rst),.is_stop(is_stop),.i_code(code),.i_pc(pc_4_if),.o_code(code_id),.o_pc(pc_4_id));

wire [5:0] op;
wire RegWrite_WB;
wire RegDst,RegWrite,ALUSrc,Branch,MemRead,MemWrite,MemtoReg,Jump;
wire [3:0] ALUOp;
wire [4:0] rs, rt, rd;
wire [4:0] we;   //尚未定义
wire [`DATA_WIDTH-1:0] w_data, r_data1, r_data2;  //w_data
wire zero_error;
wire [15:0] imme;
wire [`DATA_WIDTH-1:0] imme_id;
wire [5:0] EX_id;
wire [2:0] M_id;
wire [1:0] WB_id;
// assign is_stop = (regwritewb == 1'b1 && wb_rd_stop != 5'b0 && (wb_rd_stop == rt) && op != 6'b100010) ? 1'b1 : 1'b0;
assign is_stop = (memread_ex == 1'b1 && (rd_ex_id == rs || (rd_ex_id == rt)));
assign jump = Jump;
assign op = code_id[31:26];
assign rs = code_id[25:21];
assign rt = code_id[20:16];
assign rd = code_id[15:11];
assign imme = code_id[15:0];
assign imme_id = {{16{imme[15]}}, imme};
assign EX_id = {RegDst, ALUOp, ALUSrc};
assign M_id = {Branch, MemRead, MemWrite};
assign WB_id = {RegWrite, MemtoReg};
assign i_jump = {pc_4_id[31:28],{code_id[25:0],2'b00}};
control con(.op(op),.RegDst(RegDst),.RegWrite(RegWrite),.ALUSrc(ALUSrc),.Branch(Branch),.MemRead(MemRead),.MemWrite(MemWrite),.MemtoReg(MemtoReg),.Jump(Jump),.ALUOp(ALUOp));
register_file r(.clk(clk),.RegWrite(RegWrite_WB),.rs(rs),.rt(rt),.we(we),.w_data(w_data),.r_data1(r_data1),.r_data2(r_data2),.zero_error(zero_error));
wire [`DATA_WIDTH-1:0] r_data1_ex, r_data2_ex , imme_ex;
wire [4:0] rt_ex,  rd_ex, rs_ex;
wire [5:0] EX_ex;
wire [2:0] M_ex;
wire [1:0] WB_ex;
assign memread_ex = M_ex[1];
// assign rd_ex_id = rd_ex;
ID_EX id_ex(.clk(clk),.rst(rst | is_stop),.i_pc(pc_4_if),.i_data1(r_data1),.i_data2(r_data2),.i_imme(imme_id),.i_rt(rt),.i_rd(rd),.i_rs(rs),.i_EX(EX_id),.i_M(M_id),.i_WB(WB_id),.o_pc(pc_4_ex),
.o_data1(r_data1_ex),.o_data2(r_data2_ex),.o_imme(imme_ex),.o_rt(rt_ex),.o_rd(rd_ex),.o_EX(EX_ex),.o_M(M_ex),.o_WB(WB_ex),.o_rs(rs_ex));
wire [`DATA_WIDTH-1:0] alu1, alu2, aluout, result_mem, result_wb, rt_ex_in;
wire [4:0] we_ex;
wire alu_zero;
wire [3:0] aluctr;
wire signed [`ADR_WIDTH-1:0] pc_imme_ex;
wire [4:0] mem_rd, wb_rd;
wire [1:0] forwardA, forwardB;
wire [1:0] WB_mem;
wire [1:0] WB_wb;
wire [4:0] we_mem;
wire [4:0] we_wb;
assign rd_ex_id = we_ex;
three_to_one t1(.forward(forwardA),.data(r_data1_ex),.mem_data(result_mem),.wb_data(result_wb),.out(alu1));
three_to_one t2(.forward(forwardB),.data(r_data2_ex),.mem_data(result_mem),.wb_data(result_wb),.out(rt_ex_in));
assign mem_rd = we_mem;
assign wb_rd = we_wb;
//assign alu1 = r_data1_ex;
assign alu2 = (EX_ex[0] == 1'b1) ? imme_ex : rt_ex_in;
assign we_ex = (EX_ex[5] == 1'b1) ? rd_ex : rt_ex;
assign pc_imme_ex = pc_4_ex + (imme_ex << 2);
select_signal s(.rs(rs_ex), .rt(rt_ex),.RegWrite_mem(WB_mem[1]),.RegWrite_wb(WB_wb[1]),.ex_mem_rd(we_mem),.mem_wb_rd(we_wb),.forwardA(forwardA),.forwardB(forwardB));

alu ALUc(.aluctr(aluctr),.alu1(alu1),.alu2(alu2),.out(aluout),.zero(alu_zero));
assign result = aluout;
ALUcon aluc(.ALUOp(EX_ex[4:1]),.funct(imme_ex[5:0]),.aluctr(aluctr));
wire [2:0] M_m;

wire [`ADR_WIDTH-1:0] pc_imme_mem;
wire alu_zero_mem;
wire [`DATA_WIDTH-1:0] aluout_mem, r_data2_mem;

assign result_mem = aluout_mem;

EX_MEM ex_mem(.clk(clk),.rst(rst),.i_M(M_ex),.i_WB(WB_ex),.zero_valid(alu_zero),.i_result(aluout),.i_we(we_ex),.i_wdata(rt_ex_in),.i_imme(pc_imme_ex),
.o_M(M_m),.o_WB(WB_mem),.o_zero_valid(alu_zero_mem),.o_result(aluout_mem),.o_we(we_mem),.o_wdata(r_data2_mem),.o_imme(pc_imme_mem));
wire [`DATA_WIDTH-1:0] mem_read_mem;
assign PCSrc = M_m[2] & alu_zero_mem;
assign pc_imme = pc_imme_mem;
memory_data da_mem(.clk(clk),.MemRead(M_m[1]),.MemWrite(M_m[0]),.addr(aluout_mem),.data_write(r_data2_mem),.data_read(mem_read_mem));


wire [`DATA_WIDTH-1:0] mem_read_wb, aluout_wb;

assign result_wb = w_data;
MEM_WB mem_wb(.clk(clk),.rst(rst),.i_WB(WB_mem),.i_dataread(mem_read_mem),.i_alures(aluout_mem),.i_we(we_mem),
.o_WB(WB_wb),.o_dataread(mem_read_wb),.o_alures(aluout_wb),.o_we(we_wb));
// assign wb_rd_stop = we_wb;
assign we = we_wb;
assign w_data = (WB_wb[0] == 1'b1) ?  mem_read_wb  :aluout_wb;
assign RegWrite_WB = WB_wb[1];
// assign regwritewb = WB_wb[1];
endmodule