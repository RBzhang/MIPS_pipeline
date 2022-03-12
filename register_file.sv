`include "define.sv"

module register_file(
    input wire clk, 
    input wire RegWrite,
    input wire [4:0] rs, rt,rd,
    input wire [4:0] we,
    input wire [`DATA_WIDTH-1:0] w_data,
    output wire [`DATA_WIDTH-1:0] r_data1, r_data2,
    output wire zero_error
);
integer i;
reg [`DATA_WIDTH-1:0] register[31:0];

initial begin
    for(i=0;i < 32;i = i+1)begin
        register[i] <= '0;
    end
end
assign zero_error = (we == 5'b0);
always@(posedge clk)begin
    if(RegWrite == `REG_WRITE && !zero_error)begin
        register[we] <= w_data;
    end
end
assign r_data1 = data[rs];
assign r_data2 = data[rt];


endmodule