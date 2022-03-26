`include "define.sv"

module IF_ID(
    input wire clk,rst,is_stop,
    input wire [`DATA_WIDTH-1:0] i_code, i_pc,
    output reg [`DATA_WIDTH-1:0] o_code, o_pc
);
always@(posedge clk)begin
    if(rst == `RST_VALID)begin
        o_code <= '0;
        o_pc <= '0;
    end
    else begin
        if(is_stop == 1'b1)begin
            o_code <= o_code;
            o_pc <= o_pc;
        end
        else begin
            o_code <= i_code;
            o_pc <= i_pc;

        end
    end
end

endmodule