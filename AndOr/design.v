module AndOr(A, X, Y);
    input [31:0] A;
    output [31:0] X,Y;

    assign X = A & 32'b00000000000000000000000000000000;
    assign Y = A | 32'b11111111111111111111111111111111;
endmodule           