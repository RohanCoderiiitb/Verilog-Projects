`timescale 1ns/1ps 

module sq_wave_generator_tb;
    reg clk, reset; wire sq_a, sq_b;
    sq_wave_generator uut(.sq_a(sq_a), .sq_b(sq_b), .clk(clk), .reset(reset));

    initial clk = 1'b0;
    always #125 clk = ~clk;

    initial begin
        $dumpfile("sqwavegen.vcd");
        $dumpvars(0, sq_wave_generator_tb);
    end

    initial begin
        reset = 1'b1;
        #500 reset = 1'b0;
        #5000 reset = 1'b1;
        #1000 reset = 1'b0;
        #5000 $finish;
    end

endmodule