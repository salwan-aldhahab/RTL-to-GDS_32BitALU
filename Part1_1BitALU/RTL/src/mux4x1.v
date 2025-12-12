`timescale 1ns/1ps
module mux4x1 (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    input  wire [1:0]       sel,
    output wire y
);
    reg y_reg;
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