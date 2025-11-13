module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
    input [63:0] CurrentPC, SignExtImm64;
    input Branch, ALUZero, Uncondbranch;
    output reg [63:0] NextPC;

    always @(*) begin
        // Go to next instruction by default
        NextPC = CurrentPC + 4;

        // If both true then branch taken
        if (Branch && ALUZero)
            NextPC = CurrentPC + (SignExtImm64 << 2);

        // If unconditional branch take it
        else if (Uncondbranch)
            NextPC = CurrentPC + (SignExtImm64 << 2);
    end
endmodule