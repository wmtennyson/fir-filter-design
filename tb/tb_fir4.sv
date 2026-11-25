`timescale 1ns/1ps
module tb_fir4;
  parameter integer W = 16;
  logic clk = 0;
  logic reset = 1;
  logic [W-1:0] a = '0;
  wire [W+1:0] s_reference, s_candidate;
  logic [W-1:0] hist [0:3];
  logic [W+1:0] expected = '0;
  integer checks = 0;
  integer seed = 260;
  integer unused_seed_result;
  localparam logic [W-1:0] MAX_VALUE = {W{1'b1}};

  fir4rca_u #(.w(W)) reference_dut (.clk(clk), .reset(reset), .a(a), .s(s_reference));
  fir4_csa #(.w(W)) candidate_dut (.clk(clk), .reset(reset), .a(a), .s(s_candidate));

  always #5 clk = ~clk;

  // Independent behavioral model uses the old tap values, matching latency.
  always @(posedge clk) begin
    if (reset) begin
      expected = '0;
      for (integer i = 0; i < 4; i = i + 1) hist[i] = '0;
    end else begin
      expected = {2'b0, hist[0]} + {2'b0, hist[1]} +
                 {2'b0, hist[2]} + {2'b0, hist[3]};
      for (integer i = 3; i > 0; i = i - 1) hist[i] = hist[i-1];
      hist[0] = a;
    end
    #1;
    if (s_reference !== expected || s_candidate !== expected)
      $fatal(1, "W=%0d check=%0d expected=%h reference=%h candidate=%h",
             W, checks, expected, s_reference, s_candidate);
    checks = checks + 1;
  end

  task automatic drive(input logic [W-1:0] value, input logic rst);
    @(negedge clk);
    a = value;
    reset = rst;
  endtask

  initial begin
    unused_seed_result = $urandom(seed);
    repeat (2) drive('0, 1'b1);
    repeat (8) drive('0, 1'b0);
    repeat (8) drive(MAX_VALUE, 1'b0);
    for (integer i = 0; i < 20; i = i + 1)
      drive((i % 2) ? MAX_VALUE : '0, 1'b0);
    // Impulse and carry-heavy transitions.
    drive(MAX_VALUE, 1'b0);
    repeat (8) drive('0, 1'b0);
    for (integer i = 0; i < 1000; i = i + 1)
      drive($urandom, 1'b0);
    // Reset while nonzero samples are in flight.
    repeat (4) drive(MAX_VALUE, 1'b0);
    drive(MAX_VALUE, 1'b1);
    drive('0, 1'b0);
    repeat (8) drive('0, 1'b0);
    @(negedge clk);
    $display("PASS: W=%0d, %0d registered-output checks", W, checks);
    $finish;
  end

  initial begin
    #20000;
    $fatal(1, "Simulation timeout");
  end
endmodule
