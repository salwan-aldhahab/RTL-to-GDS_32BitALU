module mux4x1 #(
    parameter integer WIDTH = 1
) (
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    input  wire [WIDTH-1:0] c,
    input  wire [WIDTH-1:0] d,
    input  wire [1:0]       sel,
    output wire [WIDTH-1:0] y
);
    reg [WIDTH-1:0] y_reg;

    always @(*) begin
        case (sel)
            2'b00: y_reg = a;
            2'b01: y_reg = b;
            2'b10: y_reg = c;
            default: y_reg = d;
        endcase
    end

    assign y = y_reg;
endmodule