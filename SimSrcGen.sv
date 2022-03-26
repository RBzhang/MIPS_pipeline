`timescale 1ns/1ps
package SimSrcGen;
task automatic GenClk(
    ref logic clk,input realtime delay,realtime period
);
    clk = 1'b0;
    #delay;
    forever #(period/2) clk = ~clk;
endtask
task automatic GenRst(
    ref logic clk,
    ref logic rst,
    input int start,
    input int duration
);
    rst= 1'b0;
    repeat (start) @(posedge clk);
    rst = 1'b1;
    repeat (duration) @(posedge clk);
    rst = 1'b0;
endtask
endpackage