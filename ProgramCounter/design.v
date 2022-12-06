module Program_Counter(PCNext, clk, reset, PC);

    input [31:0] PCNext;
    input clk, reset;  

    output reg [31:0] PC;

    always @(posedge clk) begin
        if (reset == 1'b1) begin
            PC <= 32'h00000000;
        end
        else begin
            PC <= PCNext;
        end
    end

endmodule