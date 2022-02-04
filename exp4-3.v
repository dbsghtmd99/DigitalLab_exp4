module halfadder (S, C, x, y);
   input x, y;
   output S, C;

   xor (S, x, y);
   and (C, x, y);

endmodule // halfadder

module fulladder(S, Cout, x, y, Cin);
    input x, y, Cin;
    output S, Cout;
    wire S1, C1, C2;

    // halfadder HA1(S1, C1, x, y);
    // halfadder HA2(S, C2, S1, Cin);
    // or G1(Cout, C2, C1);

    assign S = x ^ y ^ Cin;
    assign Cout = (x & y) | (Cin & x) | (Cin & y);

endmodule // fulladder

module four_bit_adder(S, Cout, A, B, Cin);
    input [3:0]A, B;
    input Cin;
    output [3:0]S;
    output Cout;
    wire C1, C2, C3;

    fulladder FA0(S[0], C1, A[0], B[0], Cin);
    fulladder FA1(S[1], C2, A[1], B[1], C1);
    fulladder FA2(S[2], C3, A[2], B[2], C2);
    fulladder FA3(S[3], Cout, A[3], B[3], C3);

endmodule // four_bit_adder

module four_bit_subtractor(S, C4, A, B, C0);
    input [3:0]A, B;
    input C0;       //C_In
    output [3:0]S;
    output C4;      //C_Out
    wire C1, C2, C3;
    // wire [3:0]notB;

    // not (notB[0], B[0]);
    // fulladder FA0(S[0], C1, A[0], notB[0], C0);
    // not (notB[1], B[1]);
    // fulladder FA0(S[1], C2, A[1], notB[1], C1);
    // not (notB[2], B[2]);
    // fulladder FA0(S[2], C3, A[2], notB[2], C2);
    // not (notB[3], B[3]);
    // fulladder FA0(S[3], C4, A[3], notB[3], C3);

    fulladder FA0(S[0], C1, A[0], ~B[0], C0);
    fulladder FA0(S[1], C2, A[1], ~B[1], C1);
    fulladder FA0(S[2], C3, A[2], ~B[2], C2);
    fulladder FA0(S[3], C4, A[3], ~B[3], C3);

endmodule // four_bit_subtractor


module tb_4_bit_adder;
    reg [3:0]A, B;
    reg Cin;
    wire [3:0]S;
    wire Cout;

    four_bit_adder tb(S, Cout, A, B, Cin);

    initial begin
        // initialize
        A = 4'b0000; B = 4'b0000; Cin = 1'b0;

        // A = 5, B = 6
        A = 4'b0101; B = 4'b0110; Cin = 1'b0;
        #30

        // A = 9, B = 7
        A = 4'b1001; B = 4'b0111; Cin = 1'b1;
        #30
        $finish;
    end

    initial begin
        $monitor("A: %b, B: %b, Cin: %b, S: %b, Cout: %b", A, B, Cin, S, Cout);
    end

endmodule // tb_4_bit_adder

/*
module tb_4_bit_subtractor;
    reg [3:0]A, B;
    reg Cin;
    wire [3:0]S;
    wire Cout;

    four_bit_subtractor tb(S, Cout, A, B, Cin);

    initial begin
        // initialize
        A = 4'b0000; B = 4'b0000; Cin = 1'b0;

        // A = 5, B = 6
        A = 4'b0101; B = 4'b0110; Cin = 1'b0;
        #30
        
        // A = 9, B = 7
        A = 4'b1001; B = 4'b0111; Cin = 1'b1;
        #30
        $finish;
        
    end

    initial begin
        $monitor("A: %b, B: %b, Cin: %b, S: %b, Cout: %b", A, B, Cin, S, Cout);
    end

endmodule // tb_4_bit_subtractor
*/