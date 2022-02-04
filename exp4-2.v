module bit_subtractor(S, C4, A, B, C0);
    input [3:0]A, B;
    input C0;
    output [3:0]S;
    output C4;

// concatenation operator
assign {C4, S} = A + ~B + C0; 

endmodule // bit_subtractor


module tb_substractor;
    reg [3:0]A, B;
    reg Cin;
    wire [3:0]S;
    wire C4;
    
    bit_subtractor tb(S, C4, A, B, Cin);
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
        $monitor("A: %b, B: %b, Cin: %b, S: %b, Cout: %b", A, B, Cin, S, C4);
    end
endmodule // tb