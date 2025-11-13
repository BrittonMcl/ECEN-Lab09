`timescale 1ns / 1ps
module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
    output [63:0] BusA;
    output [63:0] BusB;
    input [63:0] BusW;
    input [4:0] RA, RB, RW;
    input RegWr;
    input Clk;


    reg [63:0] registers [31:0];

    // Initialize registers to zero
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] = 64'b0;
    end
     
    //write logic
    always @ (negedge Clk) begin
        //never write to register 31 so it stays zero
        if(RegWr && RW != 5'd31) begin
            registers[RW] <= #3 BusW;  // 3 tic write delay
        end
    end

    assign #2 BusA = (RA == 5'd31) ? 64'd0 : registers[RA];
    assign #2 BusB = (RB == 5'd31) ? 64'd0 : registers[RB];
endmodule
