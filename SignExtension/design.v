module Sign_Extension(ImmInst, ImmSrc, ImmExt);

    input [31:0] ImmInst;
    input [1:0] ImmSrc;
    output [31:0] ImmExt;

    assign ImmExt = (ImmSrc == 2'b00) ? {{20{ImmInst[31]}} , ImmInst[31:20]} : {{20{ImmInst[31]}} , ImmInst[31:25] , ImmInst[11:7]};

endmodule