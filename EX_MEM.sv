`include "define.sv"

module EX_MEM(
    input wire clk, rst,
    input wire [2:0] i_M,
    input wire [1:0] i_WB,
    input wire zero_valid, 
    input wire [`DATA_WIDTH-1:0] i_result, i_rt,
    input wire [`DATA_WIDTH-1:0] i_wdata,
    output reg [`DATA_WIDTH-1:0] o_result, o_rt,
    output reg [`DATA_WIDTH-1:0] o_wdata,
    output reg o_zero_valid
);
always@(posedge clk)begin
    if(rst == `RST_VALID)begin
        o_zero_valid <= '0;
        o_result <= '0;
        o_rt <= '0;
        o_wdata <= '0;
    end
    else begin
        o_zero_valid <= zero_valid;
        o_result <= i_result;
        o_rt <= i_rt;
        o_wdata <= i_wdata;
    end
end


endmodule