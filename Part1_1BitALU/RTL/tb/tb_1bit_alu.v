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
    // Arithmetic path (sel[3:2] = 2'b00)
    a = 1'b0; b = 1'b0; cin = 1'b0;
    sel = 4'b0000; #5; // A + B
    cin = 1'b1;    #5; // A + B + 1
    sel = 4'b0001; cin = 1'b0; #5; // A + B'
    cin = 1'b1;    #5; // A + B' + 1
    sel = 4'b0010; cin = 1'b0; #5; // A + 0
    cin = 1'b1;    #5; // A + 1
    sel = 4'b0011; cin = 1'b0; #5; // A + 1
    cin = 1'b1;    #5; // A + 1 + 1

    a = 1'b1; b = 1'b1; cin = 1'b0;
    sel = 4'b0000; #5;
    sel = 4'b0001; #5;
    sel = 4'b0010; #5;
    sel = 4'b0011; #5;

    // Logic path (sel[3:2] = 2'b01)
    a = 1'b0; b = 1'b0; cin = 1'b0;
    sel = 4'b0100; #5; // AND
    sel = 4'b0101; #5; // OR
    sel = 4'b0110; #5; // XOR
    sel = 4'b0111; #5; // NOT A

    a = 1'b1; b = 1'b0;
    sel = 4'b0100; #5;
    sel = 4'b0101; #5;
    sel = 4'b0110; #5;
    sel = 4'b0111; #5;

    a = 1'b1; b = 1'b1;
    sel = 4'b0100; #5;
    sel = 4'b0101; #5;
    sel = 4'b0110; #5;
    sel = 4'b0111; #5;

    // Shift path (sel[3:2] = 2'b10 / 2'b11, lower bits don't care)
    a = 1'b1;
    sel = 4'b1000; #5; // SHR A
    sel = 4'b1100; #5; // SHL A

    a = 1'b0;
    sel = 4'b1000; #5;
    sel = 4'b1100; #5;

    $finish;
end

endmodule
