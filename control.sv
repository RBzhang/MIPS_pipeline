`include "define.sv"

module control(
    input wire [5:0] op,
    output wire RegDst,RegWrite,ALUSrc,Branch,MemRead,MemWrite,MemtoReg,Jump,
    output wire [3:0] ALUOp
);
reg [11:0] controls;
assign {RegDst,RegWrite,ALUSrc,Branch,MemRead,MemWrite,MemtoReg,Jump,ALUOp} = controls;
always@(*)begin
    case(op)
    6'b000000: controls <= 12'b110000000010;
    6'b000010: controls <= 12'b000000010000;
    6'b000100: controls <= 12'b000100000001;
    6'b000101: controls <= 12'b000100000011;
    6'b001000: controls <= 12'b011000000100;
    6'b001100: controls <= 12'b011000000101;
    6'b001001: controls <= 12'b011000000110;
    6'b001010: controls <= 12'b011000000111;
    6'b001101: controls <= 12'b011000001000;
    6'b100011: controls <= 12'b011010100100;
    6'b101011: controls <= 12'b001001000100;
    default: controls <= 12'b000000000000;
    endcase
end


endmodule