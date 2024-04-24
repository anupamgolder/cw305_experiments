`timescale 1ns / 1ps

module ASCON_DATAPATH
(
    input         clk,intial,inc,
    input   [3:0] constti,
    input  [63:0] Xi0,Xi1,Xi2,Xi3,Xi4,
    output [63:0] Xo0,Xo1,Xo2,Xo3,Xo4
);
    
    wire  [7:0] constt;
    reg  [63:0] Xreg0,Xreg1,Xreg2,Xreg3,Xreg4;
    
    ASCON_ROUND_CONSTANT asconRC1
    (
        .clk(clk),
        .intial(intial),
        .inc(inc),
        .constti(constti),
        .constt(constt)
    );
    
    ASCON_ROUND_FUNCTION asconRF1
    (
        .Xi0(Xreg0),
        .Xi1(Xreg1),
        .Xi2(Xreg2),
        .Xi3(Xreg3),
        .Xi4(Xreg4), 
        .Roundconstant(constt), 
        .Xo0(Xo0),
        .Xo1(Xo1),
        .Xo2(Xo2),
        .Xo3(Xo3),
        .Xo4(Xo4)
    );
    
    always @ (posedge clk) 
    begin
        Xreg0 = Xi0;
        Xreg1 = Xi1;
        Xreg2 = Xi2;
        Xreg3 = Xi3;
        Xreg4 = Xi4;
    end
    
endmodule
