`include "define.sv"

module select_signal(
    input wire [4:0] rs, rt, ex_mem_rd, mem_wb_rd,
    input wire RegWrite_mem, RegWrite_wb,
    output reg [1:0] forwardA, forwardB
);
always@(*)begin
    if(RegWrite_mem == 1'b1 && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs))begin
        forwardA <= 2'b10;
    end
    else if (RegWrite_wb == 1'b1 && (mem_wb_rd != 5'b0) && (mem_wb_rd == rs))begin
        forwardA <= 2'b01;
    end
    else begin
        forwardA <= 2'b00;
    end
    if(RegWrite_mem == 1'b1 && (ex_mem_rd != 5'b0) && (ex_mem_rd == rt))begin
        forwardB <= 2'b10;
    end
    else if (RegWrite_wb == 1'b1 && (mem_wb_rd != 5'b0) && (mem_wb_rd == rt))begin
        forwardB <= 2'b01;
    end
    else begin
        forwardB <= 2'b00;
    end
end

endmodule