`timescale 1ns / 1ps

module ASCON_SBOX
(
    input  [63:0] Xark0,Xark1,Xark2,Xark3,Xark4,
    output [63:0] Xsb0,Xsb1,Xsb2,Xsb3,Xsb4
);

wire [63:0] Xa0,Xa1,Xa2,Xa3,Xa4,Xb0,Xb1,Xb2,Xb3,Xb4,Xc0,Xc1,Xc2,Xc3,Xc4;

assign Xa0 = Xark0 ^ Xark4;
assign Xa1 = Xark1;
assign Xa2 = Xark2 ^ Xark1;
assign Xa3 = Xark3;
assign Xa4 = Xark4 ^ Xark3;

assign Xb0 = ~Xa0 & Xa1;
assign Xb1 = ~Xa1 & Xa2;
assign Xb2 = ~Xa2 & Xa3;
assign Xb3 = ~Xa3 & Xa4;
assign Xb4 = ~Xa4 & Xa0;

assign Xc0 = Xa0 ^ Xb1;
assign Xc1 = Xa1 ^ Xb2;
assign Xc2 = Xa2 ^ Xb3;
assign Xc3 = Xa3 ^ Xb4;
assign Xc4 = Xa4 ^ Xb0; 

assign Xsb0 = Xc0 ^ Xc4;
assign Xsb1 = Xc1 ^ Xc0;
assign Xsb2 = ~ Xc2;
assign Xsb3 = Xc3 ^ Xc2;
assign Xsb4 = Xc4;

endmodule