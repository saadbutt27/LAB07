module Adder(Inp1, Inp2, Sum);

    // inputs
    input [31:0] Inp1, Inp2;
    // outputs
    output [31:0] Sum;

    //logic designing
    assign Sum = Inp1 + Inp2;

endmodule