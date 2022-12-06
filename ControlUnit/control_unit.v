`include "./DecoderModules/main_decoder.v"
`include "./DecoderModules/alu_decoder.v"
module control_unit(zero, op, func3, func7, PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc, ImmSrc, ALUControl);

    input zero, func7;
    input [6:0] op;
    input [2:0] func3;

    output PCSrc, RegWrite, ALUSrc, MemWrite, ResultSrc;
    output [1:0] ImmSrc;
    output [2:0] ALUControl;

    wire [1:0] ALUOp;
    wire op5, Branch;

    assign op5 = op[5];

    main_decoder main_dec (
        .op(op), .RegWrite(RegWrite), .ALUSrc(ALUSrc), .MemWrite(MemWrite), 
        .ResultSrc(ResultSrc), .Branch(Branch), .ImmSrc(ImmSrc), .ALUOp(ALUOp)
    );

    alu_decoder alu_dec (
        .ALUOp(ALUOp), .func3(func3), .op5(op5), .func7_5(func7), .ALUControl(ALUControl)
    );

    assign PCSrc = zero & Branch;
    
endmodule