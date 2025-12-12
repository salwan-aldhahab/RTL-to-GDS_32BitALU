module tb_1bit_alu;

reg a;
reg b;
reg cin;
reg [3:0] sel;
wire f;
wire cout;

alu_1bit uut (
    .a_i   (a),
    .b_i   (b),
    .cin_i (cin),
    .sel_i (sel),
    .f_o   (f),
    .cout_o(cout)
);

initial begin
    a = 1'b1;
    b = 1'b0;

    sel = 4'b0000; cin = 1'b0; #5; // F = A
    sel = 4'b0000; cin = 1'b1; #5; // F = A + 1
    sel = 4'b0001; cin = 1'b0; #5; // F = A + B  (B=0)
    sel = 4'b0001; cin = 1'b1; #5; // F = A + B + 1
    sel = 4'b0010; cin = 1'b0; #5; // F = A + B' (borrow)
    sel = 4'b0010; cin = 1'b1; #5; // F = A + B' + 1
    sel = 4'b0011; cin = 1'b0; #5; // F = A - 1
    sel = 4'b0011; cin = 1'b1; #5; // F = A

    sel = 4'b0100; cin = 1'b0; #5; // F = A & B
    sel = 4'b0100; cin = 1'b1; #5; // F = A & B

    sel = 4'b0101; cin = 1'b0; #5; // F = A | B
    sel = 4'b0101; cin = 1'b1; #5; // F = A | B

    sel = 4'b0110; cin = 1'bx; #5; // F = A ^ B

    sel = 4'b0111; cin = 1'bx; #5; // F = A'

    sel = 4'b10xx; cin = 1'bx; #5; // F = shr A
    sel = 4'b11xx; cin = 1'bx; #5; // F = shl A
    $finish;
end

endmodule
