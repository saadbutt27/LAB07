module tb();

    reg clk=0, reset;

    Single_Cycle dut (
        .clk(clk),
        .reset(reset)
    );

    always begin
       clk = ~clk;
       #50;
    end

    initial begin
      reset <= 1'b1;
      #100;
      reset <= 1'b0;
      #500;
      $finish;
    end

    initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0);
    end

endmodule