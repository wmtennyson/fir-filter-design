// Unsigned carry-save candidate scaffold for William Tennyson and Aydan Olaez.
// Follows the ECE 260A registered FIR interface. No measured PPA claim.
module fir4_csa #(parameter integer w = 16) (
  input logic clk,
  input logic reset,
  input logic [w-1:0] a,
  output logic [w+1:0] s
);
  localparam integer N = w + 2;
  logic [w-1:0] ar, br, cr, dr;
  wire [N-1:0] x = {{2{1'b0}}, ar};
  wire [N-1:0] y = {{2{1'b0}}, br};
  wire [N-1:0] z = {{2{1'b0}}, cr};
  wire [N-1:0] d = {{2{1'b0}}, dr};

  // Each compressor represents three operands as a sum and shifted carry.
  wire [N-1:0] sum1 = x ^ y ^ z;
  wire [N-1:0] carry1 = ((x & y) | (x & z) | (y & z)) << 1;
  wire [N-1:0] sum2 = sum1 ^ carry1 ^ d;
  wire [N-1:0] carry2 = ((sum1 & carry1) | (sum1 & d) | (carry1 & d)) << 1;
  wire [N-1:0] sum = sum2 + carry2;

  always_ff @(posedge clk) begin
    if (reset) begin
      ar <= '0;
      br <= '0;
      cr <= '0;
      dr <= '0;
      s <= '0;
    end else begin
      ar <= a;
      br <= ar;
      cr <= br;
      dr <= cr;
      s <= sum;
    end
  end
endmodule
