`timescale 1ns/1ps
module tb_logic_circuit;

reg a;
reg b;
reg [1:0] sel;
wire e;

logic_circuit uut (
    .a_i (a),
    .b_i (b),
    .sel_i(sel),
    .e_o (e)
);

initial begin
    a = 1'b0; b = 1'b0;

    sel = 2'b00; #5; // AND
    sel = 2'b01; #5; // OR
    sel = 2'b10; #5; // XOR
    sel = 2'b11; #5; // NOT A

    a = 1'b1; b = 1'b0;
    sel = 2'b00; #5;
    sel = 2'b01; #5;
    sel = 2'b10; #5;
    sel = 2'b11; #5;

    a = 1'b1; b = 1'b1;
    sel = 2'b00; #5;
    sel = 2'b01; #5;
    sel = 2'b10; #5;
    sel = 2'b11; #5;

    $finish;
end

endmodule