`include "define.sv"

module three_to_one(
    input wire[1:0] forward,
    input wire [`DATA_WIDTH-1:0] data, mem_data, wb_data,
    output reg [`DATA_WIDTH-1:0] out
);
always@(*)begin
    case(forward)
    2'b00: out <= data;
    2'b10: out <= mem_data;
    2'b01: out <= wb_data;
    default: out <= 32'bx;
    endcase
end

endmodule