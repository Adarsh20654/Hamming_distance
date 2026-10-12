`include "./hamming.v"
`timescale 1ns / 1ps

module tb_hamming_distance8 ();
  
  reg[7:0] A;
  reg[7:0] B;
  reg[3:0] threshold;
  
  wire[7:0] difference;
  wire[3:0] distance;
  wire equal;
  wire within_threshold;
  
  integer i, j, t;
  integer bit_idx;
  integer errors = 0;
  integer total_tests = 0;
  
  reg[3:0] expected_distance;
  reg expected_equal;
  reg expected_within_threshold;
  reg[7:0] expected_difference;
  
  hamming_distance8 dut(
    .A(A),
    .B(B),
    .threshold(threshold),
    .difference(difference),
    .distance(distance),
    .equal(equal),
    .within_threshold(within_threshold)
  );
  
  initial begin
    $display("Starting Exhaustive Self-Checking Testbench...");
    
    for (i = 0; i <= 255; i = i + 1) begin
      A = i;
      for (j = 0; j <= 255; j = j + 1) begin
        B = j;
        
        for (t = 0; t <= 8; t = t + 4) begin
          threshold = t;
          
          expected_difference = A ^ B;
          expected_distance = 0;
          for (bit_idx = 0; bit_idx < 8; bit_idx = bit_idx + 1) begin
            if (expected_difference[bit_idx]) expected_distance = expected_distance + 1;
          end
          
          expected_equal = (expected_distance == 0) ? 1'b1 : 1'b0;
          expected_within_threshold = (expected_distance <= threshold) ? 1'b1 : 1'b0;
          
          #1;
          
          if (distance !== expected_distance || equal !== expected_equal || within_threshold !== expected_within_threshold) begin
            
            errors = errors + 1;
            
            if (errors <= 10) begin
              $display("MISMATCH at A=%b, B=%b, Thresh=%d", A, B, threshold);
              $display("  EXPECTED: Dist=%d, Eq=%b, Within=%b", expected_distance, expected_equal, expected_within_threshold);
              $display("  ACTUAL  : Dist=%d, Eq=%b, Within=%b", distance, equal, within_threshold);
            end
          end
          
          total_tests = total_tests + 1;
        end
      end
    end
    
    $display("========================================");
    $display("TEST COMPLETION SUMMARY");
    $display("Total vectors tested: %d", total_tests);
    if (errors == 0) begin
      $display("RESULT: PASS - Zero mismatches detected.");
    end
    else begin
      $display("RESULT: FAIL - %d mismatches found.", errors);
    end
    $display("========================================");
    $finish;
  end
endmodule