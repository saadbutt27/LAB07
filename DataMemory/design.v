module Data_Memory(A, WD, clk, reset, WE, RD);

    input [31:0] A, WD;
    input clk, reset, WE;

    output [31:0] RD;

    reg [31:0] memory [1023:0];
    
    initial begin
      memory[0] = 32'h00000001;
      memory[1] = 32'h00000010;
      memory[2] = 32'h00000100;
      memory[3] = 32'h00001000;
      memory[4] = 32'h00010000;
    end

    // read
    assign RD = (WE == 1'b0) ? memory[A] : 32'h00000000;

    // write
    always @(posedge clk) begin
        if (WE == 1'b1) begin
            memory[A] <= WD; 
        end
    end

endmodule