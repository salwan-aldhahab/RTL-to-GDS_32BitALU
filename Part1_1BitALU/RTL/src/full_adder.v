module full_adder #(
    parameter WIDTH = 1
)(
    input  wire [WIDTH-1:0] a_i,
    input  wire [WIDTH-1:0] b_i,
    input  wire [WIDTH-1:0] cin_i,
    output wire [WIDTH-1:0] sum_o,
    output wire [WIDTH-1:0] cout_o
);
    assign sum_o  = a_i ^ b_i ^ cin_i;
    assign cout_o = (a_i & b_i) | (cin_i & (a_i ^ b_i));
endmodule