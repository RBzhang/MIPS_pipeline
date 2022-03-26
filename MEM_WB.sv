`include "define.sv"

module MEM_WB(
    input clk, rst,
    input wire [1:0] i_WB,
    input wire [`DATA_WIDTH-1:0] i_dataread,
    input wire [`DATA_WIDTH-1:0] i_alures,
    input wire [4:0] i_we,
    output reg [1:0] o_WB,
    output reg [`DATA_WIDTH-1:0] o_dataread,
    output reg [`DATA_WIDTH-1:0] o_alures,
    output reg [4:0] o_we
);
always@(posedge clk)begin
    if(rst == `VALID_EN)begin
        o_WB <= '0;
        o_dataread <= '0;
        o_alures <= '0;
        o_we <= '0;
    end
    else begin
        o_WB <= i_WB;
        o_dataread <= i_dataread;
        o_alures <= i_alures;
        o_we <= i_we;
    end
end

endmodule