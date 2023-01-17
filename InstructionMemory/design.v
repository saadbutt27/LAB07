module Instruction_Memory(reset, A, RD);

    input reset;
    input [31:0] A;
    
    output [31:0] RD;
    
    // Memory
    reg [31:0] mem [1023:0]; // 8bit = byte, 16bit = half-word, 32bit = word

    assign RD = (reset == 1'b1) ? 32'h00000000 : mem[A[31:2]];

    initial begin
    // mem[0] <= 32'h005A2023;
    // mem[1] <= 32'h006A2223;
    // mem[2] <= 32'h0064A423;
      mem[0] <= 32'h00410113;
      mem[1] <= 32'h00532023;
      mem[2] <= 32'h00432223;
      mem[3] <= 32'h00332423;
      // mem[0] <= 32'h00000013;
      // mem[1] <= 32'h0002A203;
      // mem[2] <= 32'h0042A203;
    end

endmodule