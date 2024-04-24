`timescale 1ns / 1ps

module ASCON_ROUND_CONSTANT 
(
    input        clk,intial,inc,
    input  [3:0] constti,
    output [7:0] constt
);

reg [3:0] consttd;
reg [3:0] consttq;

always @(*) 
begin
    case ({intial,inc})
        2'b00: consttd = consttq ;
        2'b01: consttd = consttq +1;
        2'b10: consttd = constti;
        2'b11: consttd = constti;
    endcase
end

always @(posedge clk) 
begin
        consttq <= consttd;
end

assign constt = {~consttq,consttq};

endmodule
