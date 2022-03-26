`include "define.sv"

module EX_MEM(
    input wire clk, rst,
    input wire [2:0] i_M,
    input wire [1:0] i_WB,
    input wire zero_valid, 
    input wire [`DATA_WIDTH-1:0] i_result,
    input wire [4:0] i_we,
    input wire [`DATA_WIDTH-1:0] i_wdata,
    input wire [`DATA_WIDTH-1:0] i_imme,
    output reg [`DATA_WIDTH-1:0] o_result,
    output reg [4:0] o_we,
    output reg [`DATA_WIDTH-1:0] o_wdata,
    output reg [2:0] o_M,
    output reg [1:0] o_WB,
    output reg [`DATA_WIDTH-1:0] o_imme,
    output reg o_zero_valid
);
always@(posedge clk)begin
    if(rst == `RST_VALID)begin
        o_M <= '0;
        o_WB <= '0;
        o_zero_valid <= '0;
        o_result <= '0;
        o_we <= '0;
        o_wdata <= '0;
        o_imme <= '0;
    end
    else begin
        o_M <= i_M;
        o_WB <= i_WB;
        o_zero_valid <= zero_valid;
        o_result <= i_result;
        o_we <= i_we;
        o_wdata <= i_wdata;
        o_imme <= i_imme;
    end
end


endmodule