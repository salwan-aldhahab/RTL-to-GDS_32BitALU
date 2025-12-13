module tb_32bit_alu;
    reg  [31:0] a;
    reg  [31:0] b;
    reg         cin;
    reg  [3:0]  sel;
    wire [31:0] f;
    wire        cout;

    alu_32bit uut (
        .a_i   (a),
        .b_i   (b),
        .cin_i (cin),
        .sel_i (sel),
        .f_o   (f),
        .cout_o(cout)
    );

    initial begin
        a = 32'hA5A5_F0F0;
        b = 32'h0F0F_5A5A;

        sel = 4'b0000; cin = 1'b0; #10; // F = A
        sel = 4'b0000; cin = 1'b1; #10; // F = A + 1
        sel = 4'b0001; cin = 1'b0; #10; // F = A + B  (B=0)
        sel = 4'b0001; cin = 1'b1; #10; // F = A + B + 1
        sel = 4'b0010; cin = 1'b0; #10; // F = A + B' (borrow)
        sel = 4'b0010; cin = 1'b1; #10; // F = A + B' + 1
        sel = 4'b0011; cin = 1'b0; #10; // F = A - 1
        sel = 4'b0011; cin = 1'b1; #10; // F = A

        sel = 4'b0100; cin = 1'bx; #10; // F = A & B

        sel = 4'b0101; cin = 1'bx; #10; // F = A | B

        sel = 4'b0110; cin = 1'bx; #10; // F = A ^ B

        sel = 4'b0111; cin = 1'bx; #10; // F = A'

        sel = 4'b10xx; cin = 1'bx; #10; // F = shr A
        sel = 4'b11xx; cin = 1'bx; #10; // F = shl A
        $finish;
    end
endmodule
