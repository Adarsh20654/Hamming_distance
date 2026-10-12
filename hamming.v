`include "./adder.v"
`include "./comparator.v"

module hamming_distance8 (
  input wire[7:0] A,
  input wire[7:0] B,
  input wire[3:0] threshold,
  output wire[7:0] difference,
  output wire[3:0] distance,
  output wire equal,
  output wire within_threshold
);
  assign difference = A ^ B;
  wire is_less;
  
  comparator_8bit c1(
    .A(A),
    .B(B),
    .less(is_less),
    .equal(equal)
  );
  
  wire[1:0] L1_A, L1_B, L1_C, L1_D;
  
  wire[2:0] L2_A, L2_B;
  
  wire c2_A, c2_B;
  wire c3_0, c3_1;
  
  full_adder fa1_A(
    .a(difference[0]),
    .b(difference[1]),
    .carry_in(1'b0),
    .sum(L1_A[0]),
    .carry_out(L1_A[1])
  );
  full_adder fa1_B(
    .a(difference[2]),
    .b(difference[3]),
    .carry_in(1'b0),
    .sum(L1_B[0]),
    .carry_out(L1_B[1])
  );
  full_adder fa1_C(
    .a(difference[4]),
    .b(difference[5]),
    .carry_in(1'b0),
    .sum(L1_C[0]),
    .carry_out(L1_C[1])
  );
  full_adder fa1_D(
    .a(difference[6]),
    .b(difference[7]),
    .carry_in(1'b0),
    .sum(L1_D[0]),
    .carry_out(L1_D[1])
  );
  
  full_adder fa2_A0(
    .a(L1_A[0]),
    .b(L1_B[0]),
    .carry_in(1'b0),
    .sum(L2_A[0]),
    .carry_out(c2_A)
  );
  full_adder fa2_A1(
    .a(L1_A[1]),
    .b(L1_B[1]),
    .carry_in(c2_A),
    .sum(L2_A[1]),
    .carry_out(L2_A[2])
  );
  
  full_adder fa2_B0(
    .a(L1_C[0]),
    .b(L1_D[0]),
    .carry_in(1'b0),
    .sum(L2_B[0]),
    .carry_out(c2_B)
  );
  full_adder fa2_B1(
    .a(L1_C[1]),
    .b(L1_D[1]),
    .carry_in(c2_B),
    .sum(L2_B[1]),
    .carry_out(L2_B[2])
  );
  
  full_adder fa3_0(
    .a(L2_A[0]),
    .b(L2_B[0]),
    .carry_in(1'b0),
    .sum(distance[0]),
    .carry_out(c3_0)
  );
  full_adder fa3_1(
    .a(L2_A[1]),
    .b(L2_B[1]),
    .carry_in(c3_0),
    .sum(distance[1]),
    .carry_out(c3_1)
  );
  full_adder fa3_2(
    .a(L2_A[2]),
    .b(L2_B[2]),
    .carry_in(c3_1),
    .sum(distance[2]),
    .carry_out(distance[3])
  );
  wire less;
  wire equ;
  comparator_4bit c2(
    .A(distance),
    .B(threshold),
    .less(less),
    .equal(equ)
  );
  assign within_threshold = less | equ;
  
endmodule