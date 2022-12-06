module Instruction_Memory(reset, A, RD);

    input reset;
    input [31:0] A;
    output [31:0] RD;

    reg [31:0] mem [1023:0]; // 8bit = byte, 16bit = half-word, 32bit = word

    assign RD = (reset == 1'b1) ? 32'h00000000 : mem[A[31:2]];

    initial begin
      mem[0] <= 32'h00000013;
      mem[1] <= 32'h0002A203;
    end

endmodule