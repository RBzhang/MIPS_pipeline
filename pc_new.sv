`include "define.sv"

module pc_new(
    input wire clk, rst,
    input wire i_valid,
    input wire jump,
    input wire [`ADR_WIDTH-1:0] i_pc,
    input wire [`ADR_WIDTH-1:0] imme,
    input wire [`ADR_WIDTH-1:0] addr,
    output reg [`ADR_WIDTH-1:0] o_pc
);
wire [`ADR_WIDTH-1:0] pc_mid , pc_out;
assign pc_mid = (i_valid == `VALID_EN) ? imme : i_pc;
assign pc_out = (jump == 1'b1) ? pc_mid : addr;
always @(posedge clk) begin
    if(rst == `RST_VALID)begin
        o_pc <= '0;
    end
    else begin
        o_pc <= pc_out;
    end
end

endmodule