`include "./ProgramCounter/design.v"
`include "./InstructionMemory/design.v"
`include "./RegisterFile/design.v"
`include "./ControlUnit/Control_Unit.v"
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
    wire [31:0] RD2;
    wire [31:0] Extended;
    wire [31:0] ALUResult;
    wire RegWrite;
    wire MemWrite;
    wire [31:0] RD;
    wire [31:0] NextIns;
    wire [2:0] ALUControl;
    wire [1:0] ImmSrc;

    wire [31:0] X,Y;
 
    // Module Instantiation
    Program_Counter Program_Counter (  // fetch cyle starts
        .PCNext(NextIns),
        .clk(clk),
        .reset(reset),
        .PC(PC_w)
    );

    Instruction_Memory Instruction_Memory (
        .reset(reset),
        .A(PC_w),
        .RD(Instruction)
    );                                 // fetch cyle ends

    Control_Unit Control_Unit (  // Decode cycle satrts
        .zero(),
        .op(Instruction[6:0]),
        .func3(Instruction[14:12]),
        .func7(),
        .PCSrc(),
        .RegWrite(RegWrite),
        .ALUSrc(),
        .MemWrite(MemWrite),
        .ResultSrc(),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl)
    );

    Register_File Register_File (
        .A1(Instruction[19:15]),
        .A2(Instruction[24:20]),
        .A3(Instruction[11:7]),
        .WD3(RD),
        .clk(clk),
        .reset(reset),
        .WE3(RegWrite),
        .RD1(RD1),
        .RD2(RD2)
    );

    Sign_Extension Sign_Extension ( 
        .ImmInst(Instruction),
        .ImmSrc(ImmSrc),
        .ImmExt(Extended)
    );                              // Decode cycle ends

    Flags_ALU ALU (
        .A(RD1),
        .B(Extended),
        .ctrl(ALUControl),
        .Result(ALUResult),
        .Z(),
        .N(),
        .C(),
        .V()
    );

    Data_Memory Data_Memory (
        .A(ALUResult),
        .WD(RD2),
        .clk(clk),
        .reset(reset),
        .WE(MemWrite),
        .RD(RD)
    );

    Adder Adder (
        .Inp1(PC_w),
        .Inp2(32'd4),
        .Sum(NextIns)
    );

endmodule