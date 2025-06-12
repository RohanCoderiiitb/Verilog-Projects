module sq_wave_generator (sq_a, sq_b, clk, reset);
   input clk, reset;
   output reg sq_a, sq_b;
   reg [1:0] counter;
   always @(posedge clk) begin
      if(reset) counter = 0;
      else counter <= counter+1;
   end
   always @(*) begin
      if(reset) begin
         sq_a = 0;
         sq_b = 0;
      end
      else begin
         sq_a = ~counter[1];
         sq_b = counter[0] ^ counter[1];
      end
   end
endmodule