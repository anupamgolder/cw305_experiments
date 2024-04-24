`timescale 1ns / 1ps

module ASCON_AEAD
(
    input                clk,start, 
    input        [127:0] key,nonce,
    //output   reg  [63:0] Xo0F,Xo1F,Xo2F,Xo3F,Xo4F,
    output  [63:0] Xo0,Xo1,Xo2,Xo3,Xo4,
    output               busy
);

wire        intial,inc;
wire [3:0]  consti;
wire [63:0] Xi0,Xi1,Xi2,Xi3,Xi4;
//wire [63:0] Xo0,Xo1,Xo2,Xo3,Xo4;
wire done;

ASCON_CONTROLLER asconcont1
(
    .clk(clk),
    .start(start),
    .key(key),
    .nonce(nonce),
    .intial(intial),
    .inc(inc),
    .consti(consti),
    .Xi0(Xi0),
    .Xi1(Xi1),
    .Xi2(Xi2),
    .Xi3(Xi3),
    .Xi4(Xi4),
    .Xo0(Xo0),
    .Xo1(Xo1),
    .Xo2(Xo2),
    .Xo3(Xo3),
    .Xo4(Xo4),
    .busy(busy),
    .done(done)
);
    
ASCON_DATAPATH ascondatapath1
(
    .clk(clk),
    .intial(intial),
    .inc(inc),
    .constti(consti),
    .Xi0(Xi0),
    .Xi1(Xi1),
    .Xi2(Xi2),
    .Xi3(Xi3),
    .Xi4(Xi4),
    .Xo0(Xo0),
    .Xo1(Xo1),
    .Xo2(Xo2),
    .Xo3(Xo3),
    .Xo4(Xo4)   
);    

//always@(posedge clk)
//begin
//    if (done)
//    begin
//        Xo0F = Xo0;
//        Xo1F = Xo1;
//        Xo2F = Xo2;
//        Xo3F = Xo3;
//        Xo4F = Xo4;
//    end
//end
endmodule
