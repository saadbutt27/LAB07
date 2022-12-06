`include "./ProgramCounter/design.v"
`include "./InstructionMemory/design.v"
`include "./RegisterFile/design.v"
`include "./ControlUnit/control_unit.v"
`include "./ControlUnit/DecoderModules/main_decoder.v"
`include "./ControlUnit/DecoderModules/alu_decoder.v"
`include "./SignExtension/design.v"
`include "./ALU/design.v"
`include "./DataMemory/design.v"
`include "./Adder/design.v"

module Single_Cycle(clk, reset);

    input clk, reset;
    // Interim wire declaration
    wire[31:0] PC_w;
    wire [31:0] Instruction;
    wire [31:0] RD1;
    wire [31:0] Extended;
    wire [31:0] ALUResult;
    wire RegWrite;
    wire [31:0] RD;
    wire [31:0] NextIns;
 
    // Module Instantiation
    Program_Counter Program_Counter (  // fetch cyle starts
        .clk(clk),
        .reset(reset),
        .PC(PC_w),
        .PCNext(NextIns)
    );

    Instruction_Memory Instruction_Memory (  // fetch cyle ends
        .reset(reset),
        .A(PC_w),
        .RD(Instruction)
    );

    control_unit control_unit (  // Decode cycle satrts
        .zero(),
        .op(Instruction[6:0]),
        .func3(Instruction[14:12]),
        .func7(),
        .PCSrc(),
        .RegWrite(RegWrite),
        .ALUSrc(),
        .MemWrite(),
        .ResultSrc(),
        .ImmSrc(),
        .ALUControl()
    );

    Register_File Register_File (
        .A1(Instruction[19:15]),
        .A2(),
        .A3(Instruction[11:7]),
        .WD3(RD),
        .clk(clk),
        .reset(reset),
        .WE3(RegWrite),
        .RD1(RD1),
        .RD2()
    );

    Sign_Extension Sign_Extension (  // Decode cycle ends
        .ImmInst(Instruction[31:20]),
        .ImmExt(Extended)
    );

    Flags_ALU Flags_ALU (
        .A(RD1),
        .B(Extended),
        .ctrl(),
        .Result(),
        .Z(),
        .N(),
        .C(),
        .V()
    );

    Data_Memory Data_Memory (
        .A(ALUResult),
        .WD(),
        .clk(clk),
        .reset(reset),
        .WE(),
        .RD(RD)
    );

    Adder Adder (
        .Inp1(PC_w),
        .Inp2(32'd4),
        .Sum(NextIns)
    );

endmodule