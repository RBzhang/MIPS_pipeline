`include "define.sv"

module ALUcon(
    input wire [3:0] ALUOp,
    input wire [5:0] funct,
    output reg [3:0] aluctr
);
always@(*)begin
    case(ALUOp)
    4'b0000: aluctr <= 4'bxxxx;
    4'b0001: aluctr <= `ALUEQU;
    4'b0010: 
    case(funct)
    6'b000000: aluctr <= `ALUSLL;
    6'b000011: aluctr <= `ALUSRA;
    6'b000010: aluctr <= `ALUSRL;
    6'b100000: aluctr <= `ALUADD;
    6'b100001: aluctr <= `ALUADDU;
    6'b100010: aluctr <= `ALUSUB;
    6'b100100: aluctr <= `ALUAND;
    6'b100101: aluctr < `ALUOR;
    6'b100111: aluctr <= `ALUNOR;
    6'b101010: aluctr <= `ALUSLT;
    6'b101011: aluctr <= `ALUSLTU;
    default: aluctr <= 4'bxxxx;
    endcase
    4'b0011: aluctr <= `ALUNEQ;
    4'b0100: aluctr <= `ALUADD;
    4'b0101: aluctr <= `ALUAND;
    4'b0110: aluctr <= `ALUADDU;
    4'b0111: aluctr <= `ALUSLT;
    4'b1000: aluctr <= `ALUOR;
    default: aluctr <= 4'bxxxx;
    endcase
end

endmodule