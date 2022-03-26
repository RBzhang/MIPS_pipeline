`timescale 1ps/1ps
`include "define.sv"
import SimSrcGen::*;
module TestBench;

reg clk, rst;

initial GenClk(clk, 2, 2);
initial GenRst(clk, rst, 1,2);

wire [`DATA_WIDTH-1:0] result, pc , code;
top cpu(.clk(clk),.rst(rst), .result(result),.pc_out(pc),.code_out(code));


endmodule