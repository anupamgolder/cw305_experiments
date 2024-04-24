`timescale 1ns / 1ps

module ASCON_CONTROLLER
(
    input               clk,start,
    input       [127:0] key,nonce,
    output reg          intial,inc,
    output reg    [3:0] consti,
    output reg   [63:0] Xi0,Xi1,Xi2,Xi3,Xi4,
    input        [63:0] Xo0,Xo1,Xo2,Xo3,Xo4,
    output reg          busy,
    output reg          done
);
        
reg [5:0] cstate;
reg [5:0] nstate;

parameter   idle         = 6'b000000,
            intialize1   = 6'b000001,
            intialize2   = 6'b000010,
            intialize3   = 6'b000011,
            intialize4   = 6'b000100,
            intialize5   = 6'b000101,
            intialize6   = 6'b000110,
            intialize7   = 6'b000111,
            intialize8   = 6'b001000,
            intialize9   = 6'b001001,
            intialize10  = 6'b001010,
            intialize11  = 6'b001011,
            intialize12  = 6'b001100,
            intializereg = 6'b101011;

always@(*) 
begin
    case (cstate)
    //idle
    6'b000000:begin
        intial = 0; inc = 0;
        consti = 4'b0000;
        Xi0 = 64'b0;
        Xi1 = 64'b0;
        Xi2 = 64'b0;
        Xi3 = 64'b0;
        Xi4 = 64'b0;
        busy = 1'b0;
        done = 1'b0;
        if (start)
            nstate = intializereg;
        else
            nstate = idle;
    end
    
    //intializereg
    6'b101011:begin
        intial = 1; inc = 0;
        consti = 4'b0000;
        Xi0 = 64'h80400c0600000000;
        Xi1 = key[127:64];
        Xi2 = key[63:0];
        Xi3 = nonce[127:64];
        Xi4 = nonce[63:0];
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize1;
    end

    //intialize1  
    6'b000001:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize2;
    end
    
    //intialize2
    6'b000010:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize3;
    end
    
    //intialize3
    6'b000011:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize4;
    end

    //intialize4
    6'b000100:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize5;
    end

    //intialize5
    6'b000101:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize6;
    end

    //intialize6
    6'b000110:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize7;
    end

    //intialize7
    6'b000111:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize8;
    end

    //intialize8
    6'b001000:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize9;
    end
        
    //intialize9
    6'b001001:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize10;
    end

    //intialize10
    6'b001010:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize11;
    end

    //intialize11
    6'b001011:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b1;
        done = 1'b0;
        nstate = intialize12;
    end

    //intialize12
    6'b001100:begin
        intial = 0; inc = 1;
        consti = 4'b0000;
        Xi0 = Xo0;
        Xi1 = Xo1;
        Xi2 = Xo2;
        Xi3 = Xo3;
        Xi4 = Xo4;
        busy = 1'b0;
        done = 1'b1;
        nstate = idle;
    end
    
    default:begin
            intial = 1; inc = 0;
            consti = 4'b0000;
            Xi0 = Xo0;
            Xi1 = Xo1;
            Xi2 = Xo2;
            Xi3 = Xo3;
            Xi4 = Xo4;
            busy = 1'b0;
            done = 1'b0;
            nstate = idle;
    end

    endcase
end
    
always @(posedge clk)
begin
    cstate <= nstate;    
end
    
endmodule
