`include "define.sv"

module ID_EX(
    input wire clk, rst,
    input wire ALUSrc,RegDst, 
    input wire [3:0] ALUOp,
    input wire Branch, MemRead, MemWrite,
    input wire RegWrite, MemtoReg,
    input wire [`DATA_WIDTH-1:0] i_pc, i_data1, i_data2,
    input wire [`DATA_WIDTH-1:0] i_imme,
    input wire [4:0] i_rd, i_rt,
    output reg [5:0] i_EX,
    output reg [2:0] i_M,
    output reg [1:0] i_WB
    output reg [`DATA_WIDTH-1:0] o_pc, o_data1, o_data2,
    output reg [`DATA_WIDTH-1:0] o_imme,
    output reg [4:0] o_rd, o_rt,
    output reg [5:0] o_EX,
    output reg [2:0] o_M,
    output reg [1:0] o_WB
);

always@(posedge clk)begin
    if(rst == `RST_VALID) begin
        o_pc <= '0;
        o_data1 <= '0;
        o_data2 <= '0;
        o_imme <= '0;
        o_rd <= '0;
        o_rt <= '0;
        o_EX <= '0;
        o_M <= '0;
        o_WB <= '0;
    end
    else begin
        o_pc <= i_pc;
        o_data1 <= i_data1;
        o_data2 <= i_data2;
        o_imme <= i_imme;
        o_rd <= i_rd;
        o_rt <= i_rt;
        o_EX <= i_Ex;
        o_M <= i_M;
        o_WB <= i_WB;
    end
end


endmodule