module mux2x1(inp1, inp2, signal, out);

    input [31:0] inp1, inp2;
    input signal;
    output [31:0] out;

    assign out = (signal == 1'b0) ? inp1 : inp2;

endmodule