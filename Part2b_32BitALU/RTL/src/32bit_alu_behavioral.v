module 32bit_alu_behavioral (
    input  wire [31:0] a,      // Operand A
    input  wire [31:0] b,      // Operand B
    input  wire        cin,    // Carry-in / borrow-in
    input  wire [3:0]  sel,    // Operation select
    output wire [31:0] f,      // Result
    output wire        cout    // Carry-out / borrow-out / shift bit
);

    reg [31:0] f_r;            // Registered version of result
    reg        cout_r;         // Registered version of carry-out
    reg [32:0] tmp;            // 33-bit helper for arithmetic carry capture

    always @* begin
        // Safe defaults to avoid inferred latches
        f_r    = 32'd0;
        cout_r = 1'b0;
        tmp    = 33'd0;

        casez (sel)
            4'b0000: begin
                // Increment A by cin (pass-through or INC)
                tmp    = {1'b0, a} + {32'd0, cin};
                f_r    = tmp[31:0];
                cout_r = tmp[32];
            end
            4'b0001: begin
                // A + B + cin (ADD with optional carry-in)
                tmp    = {1'b0, a} + {1'b0, b} + {32'd0, cin};
                f_r    = tmp[31:0];
                cout_r = tmp[32];
            end
            4'b0010: begin
                // A + (~B) + cin (SUB using two's complement)
                tmp    = {1'b0, a} + {1'b0, ~b} + {32'd0, cin};
                f_r    = tmp[31:0];
                cout_r = tmp[32];
            end
            4'b0011: begin
                // A + (-1) + cin (DECREMENT with carry behavior)
                tmp    = {1'b0, a} + 33'h1_FFFF_FFFF + {32'd0, cin};
                f_r    = tmp[31:0];
                cout_r = tmp[32];
            end
            4'b0100: begin
                // BITWISE AND
                f_r = a & b;
            end
            4'b0101: begin
                // BITWISE OR
                f_r = a | b;
            end
            4'b0110: begin
                // BITWISE XOR
                f_r = a ^ b;
            end
            4'b0111: begin
                // BITWISE NOT of A
                f_r = ~a;
            end
            4'b10??: begin
                // Logical right shift by 1
                f_r    = a >> 1;
                cout_r = a[0];   // LSB shifted out
            end
            4'b11??: begin
                // Logical left shift by 1
                f_r    = a << 1;
                cout_r = a[31];  // MSB shifted out
            end
            default: begin
                // Unknown select -> stay at safe defaults
                f_r    = 32'd0;
                cout_r = 1'b0;
            end
        endcase
    end

    assign f    = f_r;
    assign cout = cout_r;
endmodule
