module Register_File(A1, A2, A3, WD3, clk, reset, WE3, RD1, RD2);

    input [4:0] A1, A2, A3; // A1->rs1 | A2->rs2 | A3->rd
    input clk, reset, WE3; // WE3 -> a key signal to let write or not - Write Enable
    input [31:0] WD3; // WD3 -> Write Data

    output [31:0] RD1, RD2;

    // 32 registers of 32-1bits
    reg [31:0] register[31:0];
    wire [31:0] regO;

    initial begin
        register[0] <= 32'h00000000;
        register[1] <= 32'h00100121;
        register[3] <= 32'h00121004;
        register[4] <= 32'h43127895;
        register[5] <= 32'h00000006;
        register[6] <= 32'h00000007; // Base register
    end

    // reading from registers which are operands
    assign RD1 = (reset == 1'b1) ? 32'd0 : register[A1];
    assign RD2 = (reset == 1'b1) ? 32'd0 : register[A2];

    always @(negedge clk) begin
        if((WE3 == 1'b1) & (A3 != 5'h00)) begin
            register[A3] <= WD3;
        end
    end
    assign regO = register[A3];

endmodule                                                                                                   