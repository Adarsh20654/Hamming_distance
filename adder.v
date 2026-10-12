module full_adder (
  input wire a,
  input wire b,
  input wire carry_in,
  output wire sum,
  output wire carry_out
);
  
  wire intermidiate;
  wire carry1;
  wire carry2;
  
  half_adder h1(
    .a(a),
    .b(b),
    .sum(intermidiate),
    .carry(carry1)
  );
  
  half_adder h2(
    .a(intermidiate),
    .b(carry_in),
    .sum(sum),
    .carry(carry2)
  );
  
  assign carry_out = carry1 | carry2;
  
endmodule

module half_adder (
  input wire a,
  input wire b,
  output wire sum,
  output wire carry
);
  
  assign sum = a ^ b;
  assign carry = a & b;
  
endmodule