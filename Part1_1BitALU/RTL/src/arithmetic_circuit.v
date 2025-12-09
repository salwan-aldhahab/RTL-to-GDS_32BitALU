module arithmetic_circuit #(
    parameter integer WIDTH = 1
) (
    input  wire [WIDTH-1:0] a_i,
    input  wire [WIDTH-1:0] b_i,
    input  wire [WIDTH-1:0] cin_i,
    input  wire [1:0]       sel_i,
    output wire [WIDTH-1:0] d_o,
    output wire [WIDTH-1:0] cout_o
);
    wire [WIDTH-1:0] mux_b_o;
    wire [WIDTH-1:0] not_b;

    assign not_b = ~b_i;

    mux4x1 #(
        .WIDTH(WIDTH)
    ) u_mux4x1 (
        .a  (b_i),
        .b  (not_b),
        .c  ({WIDTH{1'b0}}),
        .d  ({WIDTH{1'b1}}),
        .sel(sel_i),
        .y  (mux_b_o)
    );

    full_adder #(
        .WIDTH(WIDTH)
    ) u_full_adder (
        .a_i   (a_i),
        .b_i   (mux_b_o),
        .cin_i (cin_i),
        .sum_o (d_o),
        .cout_o(cout_o)
    );
endmodule