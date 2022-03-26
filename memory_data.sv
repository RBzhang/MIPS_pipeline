`include "define.sv"

module memory_data(
    input wire clk,
    input wire MemRead, MemWrite,
    input wire [`ADR_WIDTH-1:0] addr,
    input wire [`DATA_WIDTH-1:0] data_write,
    output wire [`DATA_WIDTH-1:0] data_read
);
reg [`DATA_WIDTH-1:0] mem[63:0];

assign data_read = (MemRead == 1'b1) ? mem[addr[7:2]] : 32'Hxxxxxxxx;

always@(posedge clk)begin
    if(MemWrite == 1'b1)begin
        mem[addr[7:2]] <= data_write;
    end
end

endmodule