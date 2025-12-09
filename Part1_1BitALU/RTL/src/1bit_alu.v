module 1bit_alu (
    input  wire a_i,
    input  wire b_i,
    input  wire cin_i,
    input  wire [3:0]       sel_i,
    output wire f_o,
    output wire cout_o
);
    wire d_o;
    wire e_o;
    wire a_shr_1bit;
    wire a_shl_1bit;

    assign a_shr_1bit = a_i >> 1;
    assign a_shl_1bit = a_i << 1;

    arithmetic_circuit u_arithmetic_circuit (
        .a_i   (a_i),
        .b_i   (b_i),
        .cin_i (cin_i),
        .sel_i (sel_i[1:0]),
        .d_o   (d_o),
        .cout_o(cout_o)
    );

    logic_circuit u_logic_circuit (
        .a_i   (a_i),
        .b_i   (b_i),
        .sel_i (sel_i[1:0]),
        .e_o   (e_o)
    );

    mux4x1 u_mux4x1 (
        .a  (d_o),
        .b  (e_o),
        .c  (a_shr_1bit),
        .d  (a_shl_1bit),
        .sel(sel_i[3:2]),
        .y  (f_o)
    );
endmodule
