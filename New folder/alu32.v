module alu32(input logic [31:0] A, B, 
	     input logic [1:0] F,
             output logic [31:0] Y,
             output logic [3:0] FLAGS);

  logic [32:0] S;
  logic [31:0] Bout;
  logic        negative, zero, carry, overflow;

  assign Bout = F[0] ? ~B : B;
  assign S = A + Bout + F[0];

  always @ (*)
    case (F[1:0])
      2'b00: Y <= S;
      2'b01: Y <= S;
      2'b10: Y <= A & B; 
      2'b11: Y <= A | B;
    endcase

  assign zero = (Y == 32'b0);

  assign negative = Y[31];

  assign carry = (F[1] == 1'b0) & S[32];
         
  assign overflow = (F[1] == 1'b0) & 
                    ~(A[31] ^ B[31] ^ F[0]) &
                    (A[31] ^ S[31]);
  
  assign FLAGS = {negative, zero, carry, overflow};

endmodule
