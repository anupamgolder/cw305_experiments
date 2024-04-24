`timescale 1ns / 1ps

module aes_core (
	input  wire         clk,
	input  wire         load_i,
	input  wire [127:0] key_i,
	input  wire [127:0] data_i,
	output reg  [127:0] data_o,
	output reg          busy_o
);

reg    [3:0] round, round_new, round_max;
wire   [3:0] round_inc = round + 1;
wire   [3:0] round_dec = round - 1;

reg  [127:0] aes_state, aes_state_new;
reg  [127:0] sbb_i;
wire [127:0] sbb_o;

always @(posedge clk)
begin
	if(load_i)
	begin
        round_max <= 10;
	end
end


sbox sbox_inst00(.x(sbb_i[  7:  0]),.y(sbb_o[  7:  0]));
sbox sbox_inst01(.x(sbb_i[ 15:  8]),.y(sbb_o[ 15:  8]));
sbox sbox_inst02(.x(sbb_i[ 23: 16]),.y(sbb_o[ 23: 16]));
sbox sbox_inst03(.x(sbb_i[ 31: 24]),.y(sbb_o[ 31: 24]));
sbox sbox_inst04(.x(sbb_i[ 39: 32]),.y(sbb_o[ 39: 32]));
sbox sbox_inst05(.x(sbb_i[ 47: 40]),.y(sbb_o[ 47: 40]));
sbox sbox_inst06(.x(sbb_i[ 55: 48]),.y(sbb_o[ 55: 48]));
sbox sbox_inst07(.x(sbb_i[ 63: 56]),.y(sbb_o[ 63: 56]));
sbox sbox_inst08(.x(sbb_i[ 71: 64]),.y(sbb_o[ 71: 64]));
sbox sbox_inst09(.x(sbb_i[ 79: 72]),.y(sbb_o[ 79: 72]));
sbox sbox_inst10(.x(sbb_i[ 87: 80]),.y(sbb_o[ 87: 80]));
sbox sbox_inst11(.x(sbb_i[ 95: 88]),.y(sbb_o[ 95: 88]));
sbox sbox_inst12(.x(sbb_i[103: 96]),.y(sbb_o[103: 96]));
sbox sbox_inst13(.x(sbb_i[111:104]),.y(sbb_o[111:104]));
sbox sbox_inst14(.x(sbb_i[119:112]),.y(sbb_o[119:112]));
sbox sbox_inst15(.x(sbb_i[127:120]),.y(sbb_o[127:120]));


always @*
begin : subbytes_pre
    sbb_i = aes_state^key_i;
end
	
always @*
begin : subbytes_pst
		aes_state_new = sbb_o;
end

always @(posedge clk)
begin
	busy_o <= 0;
	if(load_i)
	begin		
		round     <= 0;
		busy_o    <= 1;
		data_o    <= 0;
		aes_state <= data_i;
	end
	else if(busy_o)
	begin
		busy_o    <= 1;
		round     <= round_inc;
		aes_state <= aes_state_new;
		
        if(round == round_max)
        begin
            data_o <= aes_state;
            busy_o <= 0;
        end	
	end
end

endmodule

module sbox (x, y);
  input  [7:0] x;
  output [7:0] y;

  function [7:0] S;
  input    [7:0] x;
    case (x)
        0:S= 99;   1:S=124;   2:S=119;   3:S=123;   4:S=242;   5:S=107;   6:S=111;   7:S=197;
        8:S= 48;   9:S=  1;  10:S=103;  11:S= 43;  12:S=254;  13:S=215;  14:S=171;  15:S=118;
       16:S=202;  17:S=130;  18:S=201;  19:S=125;  20:S=250;  21:S= 89;  22:S= 71;  23:S=240;
       24:S=173;  25:S=212;  26:S=162;  27:S=175;  28:S=156;  29:S=164;  30:S=114;  31:S=192;
       32:S=183;  33:S=253;  34:S=147;  35:S= 38;  36:S= 54;  37:S= 63;  38:S=247;  39:S=204;
       40:S= 52;  41:S=165;  42:S=229;  43:S=241;  44:S=113;  45:S=216;  46:S= 49;  47:S= 21;
       48:S=  4;  49:S=199;  50:S= 35;  51:S=195;  52:S= 24;  53:S=150;  54:S=  5;  55:S=154;
       56:S=  7;  57:S= 18;  58:S=128;  59:S=226;  60:S=235;  61:S= 39;  62:S=178;  63:S=117;
       64:S=  9;  65:S=131;  66:S= 44;  67:S= 26;  68:S= 27;  69:S=110;  70:S= 90;  71:S=160;
       72:S= 82;  73:S= 59;  74:S=214;  75:S=179;  76:S= 41;  77:S=227;  78:S= 47;  79:S=132;
       80:S= 83;  81:S=209;  82:S=  0;  83:S=237;  84:S= 32;  85:S=252;  86:S=177;  87:S= 91;
       88:S=106;  89:S=203;  90:S=190;  91:S= 57;  92:S= 74;  93:S= 76;  94:S= 88;  95:S=207;
       96:S=208;  97:S=239;  98:S=170;  99:S=251; 100:S= 67; 101:S= 77; 102:S= 51; 103:S=133;
      104:S= 69; 105:S=249; 106:S=  2; 107:S=127; 108:S= 80; 109:S= 60; 110:S=159; 111:S=168;
      112:S= 81; 113:S=163; 114:S= 64; 115:S=143; 116:S=146; 117:S=157; 118:S= 56; 119:S=245;
      120:S=188; 121:S=182; 122:S=218; 123:S= 33; 124:S= 16; 125:S=255; 126:S=243; 127:S=210;
      128:S=205; 129:S= 12; 130:S= 19; 131:S=236; 132:S= 95; 133:S=151; 134:S= 68; 135:S= 23;
      136:S=196; 137:S=167; 138:S=126; 139:S= 61; 140:S=100; 141:S= 93; 142:S= 25; 143:S=115;
      144:S= 96; 145:S=129; 146:S= 79; 147:S=220; 148:S= 34; 149:S= 42; 150:S=144; 151:S=136;
      152:S= 70; 153:S=238; 154:S=184; 155:S= 20; 156:S=222; 157:S= 94; 158:S= 11; 159:S=219;
      160:S=224; 161:S= 50; 162:S= 58; 163:S= 10; 164:S= 73; 165:S=  6; 166:S= 36; 167:S= 92;
      168:S=194; 169:S=211; 170:S=172; 171:S= 98; 172:S=145; 173:S=149; 174:S=228; 175:S=121;
      176:S=231; 177:S=200; 178:S= 55; 179:S=109; 180:S=141; 181:S=213; 182:S= 78; 183:S=169;
      184:S=108; 185:S= 86; 186:S=244; 187:S=234; 188:S=101; 189:S=122; 190:S=174; 191:S=  8;
      192:S=186; 193:S=120; 194:S= 37; 195:S= 46; 196:S= 28; 197:S=166; 198:S=180; 199:S=198;
      200:S=232; 201:S=221; 202:S=116; 203:S= 31; 204:S= 75; 205:S=189; 206:S=139; 207:S=138;
      208:S=112; 209:S= 62; 210:S=181; 211:S=102; 212:S= 72; 213:S=  3; 214:S=246; 215:S= 14;
      216:S= 97; 217:S= 53; 218:S= 87; 219:S=185; 220:S=134; 221:S=193; 222:S= 29; 223:S=158;
      224:S=225; 225:S=248; 226:S=152; 227:S= 17; 228:S=105; 229:S=217; 230:S=142; 231:S=148;
      232:S=155; 233:S= 30; 234:S=135; 235:S=233; 236:S=206; 237:S= 85; 238:S= 40; 239:S=223;
      240:S=140; 241:S=161; 242:S=137; 243:S= 13; 244:S=191; 245:S=230; 246:S= 66; 247:S=104;
      248:S= 65; 249:S=153; 250:S= 45; 251:S= 15; 252:S=176; 253:S= 84; 254:S=187; 255:S= 22;
    endcase
  endfunction

  assign y = S(x);
endmodule