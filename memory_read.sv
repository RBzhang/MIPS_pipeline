`include "define.sv"

module memory_read #(
    parameter DATA_DEPTH = 100
)(
    input wire [`DATA_WIDTH-1:0] pc,
    output wire [`DATA_WIDTH-1:0] code,
    output wire o_error
);
reg [`DATA_WIDTH-1:0] data[DATA_DEPTH-1:0];
initial $readmemh("data.txt",data);
assign o_error = (pc > DATA_DEPTH);
assign code[7:0] = (!o_error) ? data[pc] : 8'bxxxxxxxx;
assign code[15:8] = (!o_error) ? data[pc + 1] : 8'bxxxxxxxx;
assign code[23:16] = (!o_error) ? data[pc + 2] : 8'bxxxxxxxx;
assign code[31:24] = (!o_error) ? data[pc + 3] : 8'bxxxxxxxx;
endmodule