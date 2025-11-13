module SignExtender(BusImm, Imm26, Ctrl); 
   output reg [63:0] BusImm; 
   input [25:0] Imm26; 
   input [1:0] Ctrl; 
   
   always @(*) begin 
      case(Ctrl) 
         2'b00: BusImm = {52'b0, Imm26[21:10]}; // Zero-extend (unsigned) I Type
         2'b01: BusImm = {{55{Imm26[20]}}, Imm26[20:12]};  // Sign-extend D Type
         2'b10: BusImm = {{38{Imm26[25]}}, Imm26[25:0]};   // Sign-extend B Type
         2'b11: BusImm = {{45{Imm26[23]}}, Imm26[23:5]};   // Sign-extend CB Type
         default: BusImm = 64'b0;                        // Default case
      endcase 
   end
   
endmodule
