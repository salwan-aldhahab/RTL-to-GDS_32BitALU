`timescale 1ns/1ps
module arithmetic_circuit (
    input  wire a_i,
    input  wire b_i,
    input  wire cin_i,
    input  wire [1:0]       sel_i,
    output wire d_o,
    output wire cout_o
);
    wire mux_b_o;
    wire not_b;

    assign not_b = ~b_i;

    mux4x1 u_mux4x1 (
        .a  (b_i),
        .b  (not_b),
        .c  (1'b0),
        .d  (1'b1),
        .sel(sel_i),
        .y  (mux_b_o)
    );

    full_adder u_full_adder (
        .a_i   (a_i),
        .b_i   (mux_b_o),
        .cin_i (cin_i),
        .sum_o (d_o),
        .cout_o(cout_o)
    );
endmodule