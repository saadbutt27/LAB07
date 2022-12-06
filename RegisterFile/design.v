module Register_File(A1, A2, A3, WD3, clk, reset, WE3, RD1, RD2);

    input [4:0] A1, A2, A3; // A1->rs1 | A2->rs2 | A3->rd
    input clk, reset, WE3; // WE3 -> a key signal to let write or not
    input [31:0] WD3;

    output [3:0] RD1, RD2;

    reg [31:0] register[31:0];
    initial begin
      register[5] = 32'h00000000;
    end

    assign RD1 = (reset == 1'b1) ? 32'd0 : register[A1];
    assign RD2 = (reset == 1'b1) ? 32'd0 : register[A2];

    always @(negedge clk) begin
        if((WE3 == 1'b1) & (A3 != 5'h00)) begin
            register[A3] <= WD3;
        end
    end

endmodule                                                                                                   