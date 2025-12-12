`timescale 1ns/1ps

module tb_arithmetic_circuit;

reg a;
reg b;
reg cin;
reg [1:0] sel;
wire d;
wire cout;

arithmetic_circuit uut (
    .a_i   (a),
    .b_i   (b),
    .cin_i (cin),
    .sel_i (sel),
    .d_o   (d),
    .cout_o(cout)
);

initial begin
    a = 1'b0; b = 1'b0; cin = 1'b0;

    sel = 2'b00; cin = 1'b0; #5; // A + B
    sel = 2'b00; cin = 1'b1; #5;
    sel = 2'b01; cin = 1'b0; #5; // A + B'
    sel = 2'b01; cin = 1'b1; #5;
    sel = 2'b10; cin = 1'b0; #5; // A + 0
    sel = 2'b11; cin = 1'b1; #5; // A + 1

    a = 1'b1; b = 1'b0; cin = 1'b0;
    sel = 2'b00; #5;
    sel = 2'b01; #5;
    sel = 2'b10; cin = 1'b1; #5;
    sel = 2'b11; cin = 1'b0; #5;

    a = 1'b1; b = 1'b1; cin = 1'b0;
    sel = 2'b00; #5;
    sel = 2'b01; #5;
    sel = 2'b10; cin = 1'b1; #5;
    sel = 2'b11; cin = 1'b1; #5;

    $finish;
end

endmodule