`include "define.sv"

module alu(
    input wire [3:0] aluctr,
    input wire [`DATA_WIDTH-1:0] alu1, alu2,
    output reg [`DATA_WIDTH-1:0] out,
    output wire zero
);
wire signed [`DATA_WIDTH-1:0] salu1, salu2;
assign salu1 = alu1;
assign salu2 = alu2;


always@(*)begin
    case(aluctr)
    `ALUAND: out <= alu1 & alu2;
    `ALUADD: out <= salu1 + salu2;
    `ALUADDU: out <= alu1 + alu2;
    `ALUOR:  out <= alu1 | alu2;
    `ALUSUB: out <= alu1 - alu2;
    `ALUSLT: out <= (salu1 < salu2) ? 1 : 0;
    `ALUSLTU:out <= (alu1 < alu2) ? 1 : 0;
    `ALUSLL : out <= (alu1 << alu2);
    `ALUSRL:  out <= (alu1 >> alu2);
    `ALUSRA:  out <= (salu1 >>> alu2);
    `ALUEQU:  out <= (alu1 == alu2) ? 1 : 0;
    `ALUNEQ:  out <= (alu1 == alu2) ? 0 : 1;
    `ALUXOR:  out <= (alu1 ^ alu2);
    `ALUNOR:  out <= ~(alu1 | alu2);
    endcase
end
zero = (aluctr == `ALUEQU && out == 1) | (aluctr == `ALUNEQ && out == 0);
endmodule