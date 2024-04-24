`timescale 1ns / 1ps

module ASCON_ROUND_FUNCTION
(
    input  [63:0] Xi0,Xi1,Xi2,Xi3,Xi4, 
    input   [7:0] Roundconstant, 
    output [63:0] Xo0,Xo1,Xo2,Xo3,Xo4 );


wire [63:0] Xark0,Xark1,Xark2,Xark3,Xark4,Xsb0,Xsb1,Xsb2,Xsb3,Xsb4;

assign Xark0 = Xi0;
assign Xark1 = Xi1;
assign Xark2 = Xi2 ^ {56'b0,Roundconstant};
assign Xark3 = Xi3;
assign Xark4 = Xi4;

ASCON_SBOX  asconsbox1
(
    .Xark0(Xark0),
    .Xark1(Xark1),
    .Xark2(Xark2),
    .Xark3(Xark3),
    .Xark4(Xark4),
    .Xsb0 (Xsb0),
    .Xsb1 (Xsb1),
    .Xsb2 (Xsb2),
    .Xsb3 (Xsb3),
    .Xsb4 (Xsb4)
);

assign Xo0 = Xsb0 ^  { Xsb0[18:0],Xsb0[63:19] } ^ { Xsb0[27:0],Xsb0[63:28] };
assign Xo1 = Xsb1 ^  { Xsb1[60:0],Xsb1[63:61] } ^ { Xsb1[38:0],Xsb1[63:39] };
assign Xo2 = Xsb2 ^  { Xsb2[ 0:0],Xsb2[63: 1] } ^ { Xsb2[ 5:0],Xsb2[63: 6] };
assign Xo3 = Xsb3 ^  { Xsb3[ 9:0],Xsb3[63:10] } ^ { Xsb3[16:0],Xsb3[63:17] };
assign Xo4 = Xsb4 ^  { Xsb4[ 6:0],Xsb4[63: 7] } ^ { Xsb4[40:0],Xsb4[63:41] };

endmodule
