`timescale 1ns / 1ps

module tb_ASCON_AEAD();
    
    reg clk, start;
    
    initial
    begin
        clk = 0;
    end
    
    always #5 clk = ~clk;
    
    reg  [127:0] key,nonce;
    wire [63:0]  Xo0,Xo1,Xo2,Xo3,Xo4;
    wire         busy;
    wire done;
    ASCON_AEAD ascon_aead1
    (
        .clk(clk),
        .start(start),
        .key(key),
        .nonce(nonce),
        .Xo0F(Xo0),
        .Xo1F(Xo1),
        .Xo2F(Xo2),
        .Xo3F(Xo3),
        .Xo4F(Xo4),
        .busy(busy),
        .done(done)
    );
    
    initial
    begin
        key   = 128'h000102030405060708090A0B0C0D0E0F;
        nonce = 128'h000102030405060708090A0B0C0D0E0F;
        start = 0;
        #7 
        start = 1; 
        #10 
        start = 0;
        #100; 
    end
    
endmodule