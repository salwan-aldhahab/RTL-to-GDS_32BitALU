`timescale 1ns/1ps
module full_adder (
    input  wire a_i,
    input  wire b_i,
    input  wire cin_i,
    output wire sum_o,
    output wire cout_o
);
    assign sum_o  = a_i ^ b_i ^ cin_i;
    assign cout_o = (a_i & b_i) | (cin_i & (a_i ^ b_i));
endmodule