module module_AND (
output logic out,
input logic in1,
input logic in2,
input logic c_in
);

assign out = (in1 & in2) || (c_in & (in1 || in2));
endmodule

module module_XOR (
output logic out,
input logic in1,
input logic in2,
input logic c_in
);

assign out = in1 ^ in2 ^ c_in;
endmodule

module adder (
input logic na, nb, c_in,
output logic nsum, nc_out
);

logic a, b, sum, c_out;

assign a = na;
assign b = nb;

module_XOR m1(.out(sum), .in1(a), .in2(b), .c_in(c_in));
module_AND m2(.out(c_out), .in1(a), .in2(b), .c_in(c_in));

assign nsum = sum;
assign nc_out = c_out;

endmodule

module alu(
    input logic [3:0] operandA, operandB,
    input logic [2:0] funcsel,
    output logic [3:0] result
);

logic [3:0] maybeinvertedB;
assign maybeinvertedB = 1

always_comb
    case (funcsel[1:0])
        : 
        default: 
    endcase
endmodule