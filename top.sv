`include "define.sv"

module top(
    input clk, rst,
    output wire [`DATA_WIDTH-1:0] result
);
wire [`DATA_WIDTH-1:0] code_if, pc_imme, pc_i;
wire [`DATA_WIDTH-1:0] code, code_id;
wire PCSrc, jump, read_error;
wire [`ADR_WIDTH-1:0] i_jump, pc;
wire [`ADR_WIDTH-1:0] pc_4_if, pc_4_id;
assign pc_4_if = o_pc + 4'H4;
pc_new pc_clk(.clk(clk),.rst(rst),.i_valid(PCSrc),.jump(jump),.imme(pc_imme),.addr(i_jump),.o_pc(pc));
memory_read i_memory(.pc(pc), .i_code(code), .zero_error(read_error));
IF_ID if_id(.clk(clk),.rst(rst),.i_code(code),.i_pc(pc_4_if),.o_code(code_id),.o_pc(pc_4_id));

wire [5:0] op;
assign op = code_id[31:26];

endmodule