module Sign_Extension(ImmInst, ImmExt);

    input [11:0] ImmInst;
    output [31:0] ImmExt;

    assign ImmExt = {{20{ImmInst[11]}} , ImmInst};
endmodule