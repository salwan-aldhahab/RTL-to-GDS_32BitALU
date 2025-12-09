module logic_circuit #(
    parameter integer WIDTH = 1
) (
    input  wire [WIDTH-1:0] a_i,
    input  wire [WIDTH-1:0] b_i,
    input  wire [1:0]       sel_i,
    output wire [WIDTH-1:0] e_o
);

    wire [WIDTH-1:0] and_out;
    wire [WIDTH-1:0] or_out;
    wire [WIDTH-1:0] xor_out;
    wire [WIDTH-1:0] not_out;

    assign and_out = a_i & b_i;
    assign or_out  = a_i | b_i;
    assign xor_out = a_i ^ b_i;
    assign not_out = ~a_i;

    mux4x1 #(
        .WIDTH(WIDTH)
    ) u_mux4x1 (
        .a  (and_out),
        .b  (or_out),
        .c  (xor_out),
        .d  (not_out),
        .sel(sel_i),
        .y  (e_o)
    );

endmodule