module logic_circuit (
    input  wire a_i,
    input  wire b_i,
    input  wire [1:0]       sel_i,
    output wire e_o
);

    wire and_out;
    wire or_out;
    wire xor_out;
    wire not_out;

    assign and_out = a_i & b_i;
    assign or_out  = a_i | b_i;
    assign xor_out = a_i ^ b_i;
    assign not_out = ~a_i;

    mux4x1 u_mux4x1 (
        .a  (and_out),
        .b  (or_out),
        .c  (xor_out),
        .d  (not_out),
        .sel(sel_i),
        .y  (e_o)
    );

endmodule