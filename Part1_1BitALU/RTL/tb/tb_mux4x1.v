module tb_mux4x1;

reg a;
reg b;
reg c;
reg d;
reg [1:0] sel;
wire y;

mux4x1 uut (
    .a  (a),
    .b  (b),
    .c  (c),
    .d  (d),
    .sel(sel),
    .y  (y)
);

initial begin
    a = 1'b0;
    b = 1'b1;
    c = 1'b0;
    d = 1'b1;

    sel = 2'b00; #5; // y = a
    sel = 2'b01; #5; // y = b
    sel = 2'b10; #5; // y = c
    sel = 2'b11; #5; // y = d

    a = 1'b1; b = 1'b0; c = 1'b1; d = 1'b0;
    sel = 2'b00; #5;
    sel = 2'b01; #5;
    sel = 2'b10; #5;
    sel = 2'b11; #5;

    $finish;
end

endmodule