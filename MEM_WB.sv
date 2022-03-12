`include "define.sv"

module MEM_WB(
    input clk, rst,
    input wire [1:0] i_WB,
    input wire [`DATA_WIDTH-1:0] i_dataread,
    input wire [`DATA_WIDTH-1:0] i_alures,
    output reg [1:0] o_WB,
    output reg [`DATA_WIDTH-1:0] o_dataread,
    output reg [`DATA_WIDTH-1:0] o_alures
);
always@(posedge clk)begin
    if(rst == `VALID_EN)begin
        o_WB <= '0;
        o_dataread <= '0;
        o_alures <= '0;
    end
    else begin
        o_WB <= i_WB;
        o_dataread <= i_dataread;
        o_alures <= i_alures;
    end
end

endmodule