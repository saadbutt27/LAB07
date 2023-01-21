module Instruction_Memory(reset, A, RD);

    input reset;
    input [31:0] A;
    
    output [31:0] RD;
    
    // Memory
    reg [31:0] mem [1023:0]; // 8bit = byte, 16bit = half-word, 32bit = word

    assign RD = (reset == 1'b1) ? 32'h00000000 : mem[A[31:2]];

    initial begin
      mem[0] <= 32'h00400293; // addi x5, x0, 4
      mem[1] <= 32'h00600313; // addi x6, x0, 6 
      mem[2] <= 32'h00628433; // add x8, x5, x6
      mem[3] <= 32'h00802023; // sw x8, 0x0(x0)
      mem[4] <= 32'h40530433; // sub x8, x6, x5
      mem[5] <= 32'h00002483; // lw x9, 0x0(x20)
      mem[6] <= 32'h009472B3; // and x5, x8, x9
      mem[7] <= 32'h00946333; // or x6, x8, x9
      mem[8] <= 32'h00502423; // sw x6, 0x8(x)
    end

endmodule