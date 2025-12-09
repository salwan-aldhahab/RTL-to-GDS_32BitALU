module 32bit_alu (
    input  wire [31:0] a_i,
    input  wire [31:0] b_i,
    input  wire        cin_i,
    input  wire [3:0]  sel_i,
    output wire [31:0] f_o,
    output wire        cout_o
);
    wire [32:0] carry;

    assign carry[0] = cin_i;

    1bit_alu u_alu_0  (.a_i(a_i[0]),  .b_i(b_i[0]),  .cin_i(carry[0]),  .sel_i(sel_i), .f_o(f_o[0]),  .cout_o(carry[1]));
    1bit_alu u_alu_1  (.a_i(a_i[1]),  .b_i(b_i[1]),  .cin_i(carry[1]),  .sel_i(sel_i), .f_o(f_o[1]),  .cout_o(carry[2]));
    1bit_alu u_alu_2  (.a_i(a_i[2]),  .b_i(b_i[2]),  .cin_i(carry[2]),  .sel_i(sel_i), .f_o(f_o[2]),  .cout_o(carry[3]));
    1bit_alu u_alu_3  (.a_i(a_i[3]),  .b_i(b_i[3]),  .cin_i(carry[3]),  .sel_i(sel_i), .f_o(f_o[3]),  .cout_o(carry[4]));
    1bit_alu u_alu_4  (.a_i(a_i[4]),  .b_i(b_i[4]),  .cin_i(carry[4]),  .sel_i(sel_i), .f_o(f_o[4]),  .cout_o(carry[5]));
    1bit_alu u_alu_5  (.a_i(a_i[5]),  .b_i(b_i[5]),  .cin_i(carry[5]),  .sel_i(sel_i), .f_o(f_o[5]),  .cout_o(carry[6]));
    1bit_alu u_alu_6  (.a_i(a_i[6]),  .b_i(b_i[6]),  .cin_i(carry[6]),  .sel_i(sel_i), .f_o(f_o[6]),  .cout_o(carry[7]));
    1bit_alu u_alu_7  (.a_i(a_i[7]),  .b_i(b_i[7]),  .cin_i(carry[7]),  .sel_i(sel_i), .f_o(f_o[7]),  .cout_o(carry[8]));
    1bit_alu u_alu_8  (.a_i(a_i[8]),  .b_i(b_i[8]),  .cin_i(carry[8]),  .sel_i(sel_i), .f_o(f_o[8]),  .cout_o(carry[9]));
    1bit_alu u_alu_9  (.a_i(a_i[9]),  .b_i(b_i[9]),  .cin_i(carry[9]),  .sel_i(sel_i), .f_o(f_o[9]),  .cout_o(carry[10]));
    1bit_alu u_alu_10 (.a_i(a_i[10]), .b_i(b_i[10]), .cin_i(carry[10]), .sel_i(sel_i), .f_o(f_o[10]), .cout_o(carry[11]));
    1bit_alu u_alu_11 (.a_i(a_i[11]), .b_i(b_i[11]), .cin_i(carry[11]), .sel_i(sel_i), .f_o(f_o[11]), .cout_o(carry[12]));
    1bit_alu u_alu_12 (.a_i(a_i[12]), .b_i(b_i[12]), .cin_i(carry[12]), .sel_i(sel_i), .f_o(f_o[12]), .cout_o(carry[13]));
    1bit_alu u_alu_13 (.a_i(a_i[13]), .b_i(b_i[13]), .cin_i(carry[13]), .sel_i(sel_i), .f_o(f_o[13]), .cout_o(carry[14]));
    1bit_alu u_alu_14 (.a_i(a_i[14]), .b_i(b_i[14]), .cin_i(carry[14]), .sel_i(sel_i), .f_o(f_o[14]), .cout_o(carry[15]));
    1bit_alu u_alu_15 (.a_i(a_i[15]), .b_i(b_i[15]), .cin_i(carry[15]), .sel_i(sel_i), .f_o(f_o[15]), .cout_o(carry[16]));
    1bit_alu u_alu_16 (.a_i(a_i[16]), .b_i(b_i[16]), .cin_i(carry[16]), .sel_i(sel_i), .f_o(f_o[16]), .cout_o(carry[17]));
    1bit_alu u_alu_17 (.a_i(a_i[17]), .b_i(b_i[17]), .cin_i(carry[17]), .sel_i(sel_i), .f_o(f_o[17]), .cout_o(carry[18]));
    1bit_alu u_alu_18 (.a_i(a_i[18]), .b_i(b_i[18]), .cin_i(carry[18]), .sel_i(sel_i), .f_o(f_o[18]), .cout_o(carry[19]));
    1bit_alu u_alu_19 (.a_i(a_i[19]), .b_i(b_i[19]), .cin_i(carry[19]), .sel_i(sel_i), .f_o(f_o[19]), .cout_o(carry[20]));
    1bit_alu u_alu_20 (.a_i(a_i[20]), .b_i(b_i[20]), .cin_i(carry[20]), .sel_i(sel_i), .f_o(f_o[20]), .cout_o(carry[21]));
    1bit_alu u_alu_21 (.a_i(a_i[21]), .b_i(b_i[21]), .cin_i(carry[21]), .sel_i(sel_i), .f_o(f_o[21]), .cout_o(carry[22]));
    1bit_alu u_alu_22 (.a_i(a_i[22]), .b_i(b_i[22]), .cin_i(carry[22]), .sel_i(sel_i), .f_o(f_o[22]), .cout_o(carry[23]));
    1bit_alu u_alu_23 (.a_i(a_i[23]), .b_i(b_i[23]), .cin_i(carry[23]), .sel_i(sel_i), .f_o(f_o[23]), .cout_o(carry[24]));
    1bit_alu u_alu_24 (.a_i(a_i[24]), .b_i(b_i[24]), .cin_i(carry[24]), .sel_i(sel_i), .f_o(f_o[24]), .cout_o(carry[25]));
    1bit_alu u_alu_25 (.a_i(a_i[25]), .b_i(b_i[25]), .cin_i(carry[25]), .sel_i(sel_i), .f_o(f_o[25]), .cout_o(carry[26]));
    1bit_alu u_alu_26 (.a_i(a_i[26]), .b_i(b_i[26]), .cin_i(carry[26]), .sel_i(sel_i), .f_o(f_o[26]), .cout_o(carry[27]));
    1bit_alu u_alu_27 (.a_i(a_i[27]), .b_i(b_i[27]), .cin_i(carry[27]), .sel_i(sel_i), .f_o(f_o[27]), .cout_o(carry[28]));
    1bit_alu u_alu_28 (.a_i(a_i[28]), .b_i(b_i[28]), .cin_i(carry[28]), .sel_i(sel_i), .f_o(f_o[28]), .cout_o(carry[29]));
    1bit_alu u_alu_29 (.a_i(a_i[29]), .b_i(b_i[29]), .cin_i(carry[29]), .sel_i(sel_i), .f_o(f_o[29]), .cout_o(carry[30]));
    1bit_alu u_alu_30 (.a_i(a_i[30]), .b_i(b_i[30]), .cin_i(carry[30]), .sel_i(sel_i), .f_o(f_o[30]), .cout_o(carry[31]));
    1bit_alu u_alu_31 (.a_i(a_i[31]), .b_i(b_i[31]), .cin_i(carry[31]), .sel_i(sel_i), .f_o(f_o[31]), .cout_o(carry[32]));

    assign cout_o = carry[32];
endmodule