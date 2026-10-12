module comparator_4bit (
  input wire[3:0] A,
  input wire[3:0] B,
  output less,
  output equal
);
  wire x0;
  wire x1;
  wire x2;
  wire x3;
  
  assign x3 = ~(A[3] ^ B[3]);
  assign x2 = ~(A[2] ^ B[2]);
  assign x1 = ~(A[1] ^ B[1]);
  assign x0 = ~(A[0] ^ B[0]);
  
  assign less = ((~A[3]) & B[3]) | (x3 & (~A[2]) & B[2]) | (x3 & x2 & (~A[1]) & B[1]) | (x3 & x2 & x1 & (~A[0]) & B[0]);
  assign equal = (x3 & x2 & x1 & x0);
endmodule

module comparator_8bit (
  input wire[7:0] A,
  input wire[7:0] B,
  output less,
  output equal
);
  wire less_1;
  wire less_2;
  wire equal_1;
  wire equal_2;
  
  comparator_4bit c1(
    .A(A[7:4]),
    .B(B[7:4]),
    .less(less_1),
    .equal(equal_1)
  );
  comparator_4bit c2(
    .A(A[3:0]),
    .B(B[3:0]),
    .less(less_2),
    .equal(equal_2)
  );
  
  
  assign equal = equal_1 & equal_2;
  assign less = less_1 | (equal_1 & less_2);
  
endmodule