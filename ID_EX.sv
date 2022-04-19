`include "define.sv"

module ID_EX(
    input wire clk, rst,
    input wire [`DATA_WIDTH-1:0] i_pc, i_data1, i_data2,
    input wire [`DATA_WIDTH-1:0] i_imme,
    input wire [4:0] i_rd, i_rt,i_rs,
    input wire [5:0] i_EX,
    input wire [2:0] i_M,
    input wire [1:0] i_WB,
    input wire jal_i,
    output reg [`DATA_WIDTH-1:0] o_pc, o_data1, o_data2,
    output reg [`DATA_WIDTH-1:0] o_imme,
    output reg [4:0] o_rd, o_rt,o_rs,
    output reg [5:0] o_EX,
    output reg [2:0] o_M,
    output reg [1:0] o_WB,
    output reg jal_o
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
        o_rs <= '0;
        jal_o <= '0;
    end
        else begin
        o_pc <= i_pc;
        o_data1 <= i_data1;
        o_data2 <= i_data2;
        o_imme <= i_imme;
        o_rd <= i_rd;
        o_rt <= i_rt;
        o_EX <= i_EX;
        o_M <= i_M;
        o_WB <= i_WB;
        o_rs <= i_rs;
        jal_o <= jal_i;
        end
end


endmodule