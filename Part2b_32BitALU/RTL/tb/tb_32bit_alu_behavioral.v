`timescale 1ns/1ps

module tb_32bit_alu_behavioral;
    reg  [31:0] a;
    reg  [31:0] b;
    reg         cin;
    reg  [3:0]  sel;
    wire [31:0] f;
    wire        cout;

    alu_32bit_behavioral dut (
        .a   (a),
        .b   (b),
        .cin (cin),
        .sel (sel),
        .f   (f),
        .cout(cout)
    );

    initial begin
        a = 32'hA5A5_F0F0;
        b = 32'h0F0F_5A5A;

        sel = 4'b0000; cin = 1'b0; #10; // F = A
        sel = 4'b0000; cin = 1'b1; #10; // F = A + 1
        sel = 4'b0001; cin = 1'b0; #10; // F = A + B
        sel = 4'b0001; cin = 1'b1; #10; // F = A + B + 1
        sel = 4'b0010; cin = 1'b0; #10; // F = A + B'
        sel = 4'b0010; cin = 1'b1; #10; // F = A + B' + 1
        sel = 4'b0011; cin = 1'b0; #10; // F = A - 1
        sel = 4'b0011; cin = 1'b1; #10; // F = A

        sel = 4'b0100; cin = 1'bx; #10; // F = A & B
        sel = 4'b0101; cin = 1'bx; #10; // F = A | B
        sel = 4'b0110; cin = 1'bx; #10; // F = A ^ B
        sel = 4'b0111; cin = 1'bx; #10; // F = A'

        sel = 4'b1000; cin = 1'bx; #10; // F = shr A
        sel = 4'b1100; cin = 1'bx; #10; // F = shl A

        $finish;
    end
endmodule
