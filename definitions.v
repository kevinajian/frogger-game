module counter16(ctrl, clk, out, ready, restart, reset, test);
	input ctrl, clk, restart, reset;
	output out, ready, test;
	wire [0:15] dffOut;
	wire dffOrStart, resetDff, dffROut;
	
	assign test = restart;

	assign resetDff = restart | reset;
	assign out = dffOut[0] | dffOut[1] | dffOut[2] | dffOut[3] | dffOut[4] | dffOut[5] | dffOut[6] |
			dffOut[7] | dffOut[8] | dffOut[9] | dffOut[10] | dffOut[11] | dffOut[12] | dffOut[13] |
			dffOut[14];
	assign ready = dffOut[15];

	myDff dffRestart(.d(restart), .aclr(1'b0), .we(1'b1), .clk(clk), .q(dffROut));
	myDff dff0(.d(ctrl), .aclr(resetDff), .we(1'b1), .clk(clk), .q(dffOut[0]));

	genvar i;
	generate
		for (i = 1; i <= 15; i = i + 1) begin: loop1
			myDff dff0(.d(dffOut[i - 1]), .aclr(resetDff), .we(1'b1), .clk(clk), .q(dffOut[i]));
		end
	endgenerate
endmodule

module counter32(ctrl, clk, out, ready, restart, reset);
	input ctrl, clk, restart, reset;
	output out, ready;
	wire [0:31] dffOut;
	wire trigger, dffOrStart, resetDff, dffROut;

	assign dffOrStart = ctrl | dffROut;
	assign resetDff = restart | reset;
	assign out = dffOut[0] | dffOut[1] | dffOut[2] | dffOut[3] | dffOut[4] | dffOut[5] | dffOut[6] |
			dffOut[7] | dffOut[8] | dffOut[9] | dffOut[10] | dffOut[11] | dffOut[12] | dffOut[13] | dffOut[14] |
			dffOut[15] | dffOut[16] | dffOut[17] | dffOut[18] | dffOut[19] | dffOut[20] | dffOut[21] | dffOut[22] |
			dffOut[23] | dffOut[24] | dffOut[25] | dffOut[26] | dffOut[27] | dffOut[28] | dffOut[29] | dffOut[30];
	assign ready = dffOut[31];

	myDff dffRestart(.d(restart), .aclr(1'b0), .we(1'b1), .clk(clk), .q(dffROut));
	myDff dff0(.d(dffOrStart), .aclr(resetDff), .we(1'b1), .clk(clk), .q(dffOut[0]));

	genvar i;
	generate
		for (i = 1; i <= 31; i = i + 1) begin: loop1
			myDff dff0(.d(dffOut[i - 1]), .aclr(resetDff), .we(1'b1), .clk(clk), .q(dffOut[i]));
		end
	endgenerate
endmodule

module negate16(data, out);
	input [15:0] data;
	output [15:0] out;
	wire [15:0] neg;
	wire carry;

	genvar i;
	generate
		for (i = 0; i <= 15; i = i + 1) begin: loop1
			assign neg[i] = ~data[i];
		end
	endgenerate

	sixteenAdd sixAdd(.inputA(neg), .inputB(16'b0000000000000001), .cIn(1'b0), .cOut(carry), .out(out));
endmodule

module negate32(data, out);
	input [31:0] data;
	output [31:0] out;
	wire [31:0] neg;
	wire carry;

	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin: loop1
			assign neg[i] = ~data[i];
		end
	endgenerate

	thirtyTwoAdd ttAdd(.inputA(neg), .inputB(32'b00000000000000000000000000000001), .cIn(1'b0), .cOut(carry), .out(out));
endmodule

module myDff(d, aclr, we, clk, q);
    input d, aclr, we, clk;
	output q;
	reg q;
	
	always @(posedge clk) begin
		if (aclr) begin
			q = 1'b0;
		end else if (we) begin
			q = d;
		end
	end
endmodule

module dff5(d, aclr, we, clk, q);
	input [4:0] d;
	input aclr, we, clk;
	output [4:0] q;

	genvar i;
	generate
		for (i = 0; i <= 4; i = i + 1) begin: loop1
			myDff dff0(.d(d[i]), .aclr(aclr), .we(we), .clk(clk), .q(q[i]));
		end
	endgenerate
endmodule

module dff16(d, aclr, we, clk, q);
	input [15:0] d;
	input aclr, we, clk;
	output [15:0] q;

	genvar i;
	generate
		for (i = 0; i <= 15; i = i + 1) begin: loop1
			myDff dff0(.d(d[i]), .aclr(aclr), .we(we), .clk(clk), .q(q[i]));
		end
	endgenerate
endmodule

module dff32(d, aclr, we, clk, q);
	input [31:0] d;
	input aclr, we, clk;
	output [31:0] q;

	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin: loop1
			myDff dff0(.d(d[i]), .aclr(aclr), .we(we), .clk(clk), .q(q[i]));
		end
	endgenerate
endmodule

module dff32Special(d, aclr, we, clk, q, testD, testQ, testAclr, testWE, testClk);
	input [31:0] d;
	input aclr, we, clk;
	output [31:0] q, testD, testQ;
	output testAclr, testWE, testClk;

	assign testD = d;
	assign testQ = q;
	assign testAclr = aclr;
	assign testWE = we;
	assign testClk = clk;

	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin: loop1
			myDff dff0(.d(d[i]), .aclr(aclr), .we(we), .clk(clk), .q(q[i]));
		end
	endgenerate
endmodule

module thirtyTwoAdd(inputA, inputB, cIn, cOut, out);
	input [31:0] inputA, inputB;
	input cIn;
	output [31:0] out;
	output cOut;
	wire [4:0] carry;

	assign carry[0] = cIn;
	assign cOut = carry[4];
	genvar i;
	generate
		for (i = 0; i <= 3; i = i + 1) begin: loop1
			eightAdd adder (.inputA(inputA[i * 8 + 7:i * 8]), .inputB(inputB[i * 8 + 7:i * 8]), .cIn(carry[i]),
					.cOut(carry[i + 1]), .out(out[i * 8 + 7:i * 8]));
		end
	endgenerate
endmodule

module oneAdd(inputA, inputB, cIn, out);
    input inputA, inputB, cIn;
    output out;

    assign out = inputA ^ inputB ^ cIn;
endmodule

module eightAdd(inputA, inputB, cIn, cOut, out);
    input [7:0] inputA, inputB;
    input cIn;
    output [7:0] out;
    output cOut;
    wire [8:0] carry;
    wire [7:0] g, p;

    assign carry[0] = cIn;
    assign cOut = carry[8];
    genvar i;
    generate
        for (i = 0; i <= 7; i = i + 1) begin: loop1
            assign g[i] = inputA[i] & inputB[i];
            assign p[i] = inputA[i] | inputB[i];
            assign carry[i+1] = g[i] | (p[i] & carry[i]);
            oneAdd adder(.inputA(inputA[i]), .inputB(inputB[i]), .cIn(carry[i]), .out(out[i]));
        end
    endgenerate
endmodule

module sixteenAdd(inputA, inputB, cIn, cOut, out);
	input [15:0] inputA, inputB;
	input cIn;
	output [15:0] out;
	output cOut;
	wire [2:0] carry;

	assign carry[0] = cIn;
	assign cOut = carry[2];
	genvar i;
	generate
		for (i = 0; i <= 1; i = i + 1) begin: loop1
			eightAdd adder(.inputA(inputA[i * 8 + 7:i * 8]), .inputB(inputB[i * 8 + 7:i * 8]), .cIn(carry[i]),
					.cOut(carry[i + 1]), .out(out[i * 8 + 7:i * 8]));
		end
	endgenerate
endmodule

module thirtyTwoSub(inputA, inputB, out);
	input [31:0] inputA, inputB;
	output [31:0] out;
	wire [31:0] negB, negBOne;
	
	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin: loop1
			assign negB[i] = ~inputB[i];
		end
	endgenerate
	
	thirtyTwoAdd ttAddOne(.inputA(negB), .inputB(2'b01), .out(negBOne));
	thirtyTwoAdd ttAddNeg(.inputA(inputA), .inputB(negBOne), .out(out));
endmodule

module thirtyTwoAnd(dataA, dataB, result);
	input [31:0] dataA, dataB;
	output [31:0] result;
	
	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin: loop1
			assign result[i] = dataA[i] & dataB[i];
		end
	endgenerate
endmodule

module thirtyTwoOr(dataA, dataB, result);
	input [31:0] dataA, dataB;
	output [31:0] result;
	
	genvar i;
	generate
		for (i = 0; i <= 31; i = i + 1) begin: loop1
			assign result[i] = dataA[i] | dataB[i];
		end
	endgenerate
endmodule

module thirtyTwoSll(data, shiftAmt, out);
	input [4:0] shiftAmt;
	input [31:0] data;
	output [31:0] out;
	wire [31:0] sixteenOut, eightOut, fourOut, twoOut, oneOut, sixteenMuxOut, eightMuxOut,
			fourMuxOut, twoMuxOut;
	
	twoMux32 shftSixteenMux (.ctrl(shiftAmt[4]), .inputA(data), .inputB(sixteenOut),
			.out(sixteenMuxOut));
	twoMux32 shft (.ctrl(shiftAmt[3]), .inputA(sixteenMuxOut), .inputB(eightOut),
			.out(eightMuxOut));
	twoMux32 shftFourMux (.ctrl(shiftAmt[2]), .inputA(eightMuxOut), .inputB(fourOut),
			.out(fourMuxOut));
	twoMux32 shftTwoMux (.ctrl(shiftAmt[1]), .inputA(fourMuxOut), .inputB(twoOut),
			.out(twoMuxOut));	
	twoMux32 shftOneMux (.ctrl(shiftAmt[0]), .inputA(twoMuxOut), .inputB(oneOut),
			.out(out));	
	
	genvar i;
	generate
		for (i = 0; i <= 15; i = i + 1) begin: loop1
			assign sixteenOut[i] = 1'b0;
			assign sixteenOut[i + 16] = data[i];
		end
		
		for (i = 0; i <= 7; i = i + 1) begin: loop2
			assign eightOut[i] = 1'b0;
		end
		for (i = 0; i <= 23; i = i + 1) begin: loop3
			assign eightOut[i + 8] = sixteenMuxOut[i];
		end
		
		for (i = 0; i <= 3; i = i + 1) begin: loop4
			assign fourOut[i] = 1'b0;
		end
		for (i = 0; i <= 27; i = i + 1) begin: loop5
			assign fourOut[i + 4] = eightMuxOut[i];
		end
		
		for (i = 0; i <= 1; i = i + 1) begin: loop6
			assign twoOut[i] = 1'b0;
		end
		for (i = 0; i <= 29; i = i + 1) begin: loop7
			assign twoOut[i + 2] = fourMuxOut[i];
		end
		
		assign oneOut[0] = 1'b0;
		for (i = 0; i <= 30; i = i + 1) begin: loop8
			assign oneOut[i + 1] = twoMuxOut[i];
		end
	endgenerate
endmodule

module sll(data, out);
	input [31:0] data;
	output [31:0] out;

	assign out[0] = 1'b0;
	genvar i;
	generate
		for (i = 1; i <= 31; i = i + 1) begin: loop1
			assign out[i] = data[i - 1];
		end
	endgenerate
endmodule

module thirtyTwoSra(data, shiftAmt, out);
	input [4:0] shiftAmt;
	input [31:0] data;
	output [31:0] out;
	wire [31:0] sixteenOut, eightOut, fourOut, twoOut, oneOut, sixteenMuxOut, eightMuxOut,
			fourMuxOut, twoMuxOut;
	
	twoMux32 shftSixteenMux (.ctrl(shiftAmt[4]), .inputA(data), .inputB(sixteenOut),
			.out(sixteenMuxOut));
	twoMux32 shftEightMux (.ctrl(shiftAmt[3]), .inputA(sixteenMuxOut), .inputB(eightOut),
			.out(eightMuxOut));
	twoMux32 shftFourMux (.ctrl(shiftAmt[2]), .inputA(eightMuxOut), .inputB(fourOut),
			.out(fourMuxOut));
	twoMux32 shftTwoMux (.ctrl(shiftAmt[1]), .inputA(fourMuxOut), .inputB(twoOut),
			.out(twoMuxOut));	
	twoMux32 shftOneMux (.ctrl(shiftAmt[0]), .inputA(twoMuxOut), .inputB(oneOut),
			.out(out));	
	
	genvar i;
	generate
		for (i = 0; i <= 15; i = i + 1) begin: loop1
			assign sixteenOut[i + 16] = data[31];
			assign sixteenOut[i] = data[i + 16];
		end
		
		for (i = 0; i <= 7; i = i + 1) begin: loop2
			assign eightOut[i + 24] = sixteenMuxOut[31];
		end
		for (i = 0; i <= 23; i = i + 1) begin: loop3
			assign eightOut[i] = sixteenMuxOut[i + 8];
		end
		
		for (i = 0; i <= 3; i = i + 1) begin: loop4
			assign fourOut[i + 28] = eightMuxOut[31];
		end
		for (i = 0; i <= 27; i = i + 1) begin: loop5
			assign fourOut[i] = eightMuxOut[i + 4];
		end
		
		for (i = 0; i <= 1; i = i + 1) begin: loop6
			assign twoOut[i + 30] = fourMuxOut[31];
		end
		for (i = 0; i <= 29; i = i + 1) begin: loop7
			assign twoOut[i] = fourMuxOut[i + 2];
		end
		
		assign oneOut[31] = twoMuxOut[31];
		for (i = 0; i <= 30; i = i + 1) begin: loop8
			assign oneOut[i] = twoMuxOut[i + 1];
		end
	endgenerate
endmodule

module sra16(data, out);
	input [15:0] data;
	output [15:0] out;

	assign out[15] = data[15];
	genvar i;
	generate
		for (i = 0; i <= 14; i = i + 1) begin: loop1
			assign out[i] = data[i + 1];
		end
	endgenerate
endmodule

module sra32(data, out);
	input [31:0] data;
	output [31:0] out;

	assign out[31] = data[31];
	genvar i;
	generate
		for (i = 0; i <= 30; i = i + 1) begin: loop1
			assign out[i] = data[i + 1];
		end
	endgenerate
endmodule

module thirtyTwoComp(inputA, inputB, neq, lt);
	input [31:0] inputA, inputB;
	output neq, lt;
	wire neq0, lt0, neq1, lt1, neq2, lt2, neq3, lt3, neq4, lt4, neq5, lt5, neq6, lt6, neq7, lt7,
			neq8, lt8, neq9, lt9, neq10, lt10, neq11, lt11, neq12, lt12, neq13, lt13, neq14,
			lt14;
	wire[1:0] iA0, iB0, iA1, iB1, iA2, iB2, iA3, iB3, iA4, iB4, iA5, iB5, iA6, iB6, iA7,
			iB7, iA8, iB8, iA9, iB9, iA10, iB10, iA11, iB11, iA12, iB12, iA13, iB13,
			iA14, iB14, iA15, iB15;
			
	genvar i;
	generate
		for (i = 0; i <= 1; i = i + 1) begin: loop1
			assign iA0[i] = inputA[i];
			assign iB0[i] = inputB[i];
			assign iA1[i] = inputA[i+2];
			assign iB1[i] = inputB[i+2];
			assign iA2[i] = inputA[i+4];
			assign iB2[i] = inputB[i+4];
			assign iA3[i] = inputA[i+6];
			assign iB3[i] = inputB[i+6];
			assign iA4[i] = inputA[i+8];
			assign iB4[i] = inputB[i+8];
			assign iA5[i] = inputA[i+10];
			assign iB5[i] = inputB[i+10];
			assign iA6[i] = inputA[i+12];
			assign iB6[i] = inputB[i+12];
			assign iA7[i] = inputA[i+14];
			assign iB7[i] = inputB[i+14];
			assign iA8[i] = inputA[i+16];
			assign iB8[i] = inputB[i+16];
			assign iA9[i] = inputA[i+18];
			assign iB9[i] = inputB[i+18];
			assign iA10[i] = inputA[i+20];
			assign iB10[i] = inputB[i+20];
			assign iA11[i] = inputA[i+22];
			assign iB11[i] = inputB[i+22];
			assign iA12[i] = inputA[i+24];
			assign iB12[i] = inputB[i+24];
			assign iA13[i] = inputA[i+26];
			assign iB13[i] = inputB[i+26];
			assign iA14[i] = inputA[i+28];
			assign iB14[i] = inputB[i+28];
			assign iA15[i] = inputA[i+30];
			assign iB15[i] = inputB[i+30];
		end
	endgenerate
	
	twoComp tc0(.inputA(iA15), .inputB(iB15), .neqi(1'b0), .lti(1'b0), .neq(neq0), .lt(lt0));
	twoComp tc1(.inputA(iA14), .inputB(iB14), .neqi(neq0), .lti(lt0), .neq(neq1), .lt(lt1));
	twoComp tc2(.inputA(iA13), .inputB(iB13), .neqi(neq1), .lti(lt1), .neq(neq2), .lt(lt2));
	twoComp tc3(.inputA(iA12), .inputB(iB12), .neqi(neq2), .lti(lt2), .neq(neq3), .lt(lt3));
	twoComp tc4(.inputA(iA11), .inputB(iB11), .neqi(neq3), .lti(lt3), .neq(neq4), .lt(lt4));
	twoComp tc5(.inputA(iA10), .inputB(iB10), .neqi(neq4), .lti(lt4), .neq(neq5), .lt(lt5));
	twoComp tc6(.inputA(iA9), .inputB(iB9), .neqi(neq5), .lti(lt5), .neq(neq6), .lt(lt6));
	twoComp tc7(.inputA(iA8), .inputB(iB8), .neqi(neq6), .lti(lt6), .neq(neq7), .lt(lt7));
	twoComp tc8(.inputA(iA7), .inputB(iB7), .neqi(neq7), .lti(lt7), .neq(neq8), .lt(lt8));
	twoComp tc9(.inputA(iA6), .inputB(iB6), .neqi(neq8), .lti(lt8), .neq(neq9), .lt(lt9));
	twoComp tc10(.inputA(iA5), .inputB(iB5), .neqi(neq9), .lti(lt9), .neq(neq10), .lt(lt10));
	twoComp tc11(.inputA(iA4), .inputB(iB4), .neqi(neq10), .lti(lt10), .neq(neq11), .lt(lt11));
	twoComp tc12(.inputA(iA3), .inputB(iB3), .neqi(neq11), .lti(lt11), .neq(neq12), .lt(lt12));
	twoComp tc13(.inputA(iA2), .inputB(iB2), .neqi(neq12), .lti(lt12), .neq(neq13), .lt(lt13));
	twoComp tc14(.inputA(iA1), .inputB(iB1), .neqi(neq13), .lti(lt13), .neq(neq14), .lt(lt14));
	twoComp tc15(.inputA(iA0), .inputB(iB0), .neqi(neq14), .lti(lt14), .neq(neq), .lt(lt));
endmodule

module twoComp(inputA, inputB, neqi, lti, neq, lt);
	input neqi, lti;
	input [1:0] inputA, inputB;
	output neq, lt;
	wire neq0, neq1, lt0, lt1;
	wire [2:0] ctrl;
	
	assign ctrl[0] = inputA[1];
	assign ctrl[1] = lti;
	assign ctrl[2] = neqi;
	assign neq0 = (inputA[0] & ~inputB[0]) | (~inputA[0] & inputB[0]) | inputB[1];
	assign neq1 = ~inputB[1] | (inputA[0] & ~inputB[0]) | (~inputA[0] & inputB[0]);
	assign lt0 = (~inputA[0] & inputB[0]) | inputB[1];
	assign lt1 = ~inputA[0] & inputB[1] & inputB[0];
	
	eightMux neqMux(.ctrl(ctrl), .i0(neq0), .i1(neq1), .i2(1'b0), .i3(1'b0), .i4(1'b1),
			.i5(1'b1), .i6(1'b1), .i7(1'b1), .out(neq));
	eightMux ltMux(.ctrl(ctrl), .i0(lt0), .i1(lt1), .i2(1'b0), .i3(1'b0), .i4(1'b0),
			.i5(1'b0), .i6(1'b1), .i7(1'b1), .out(lt));
endmodule

module triSt(data, ctrl, out);
	input ctrl;
	input data;
	output out;
	
	assign out = (ctrl) ? data : 1'bz;
endmodule

module triSt5(data, ctrl, out);
	input ctrl;
	input [4:0] data;
	output [4:0] out;

	assign out = (ctrl) ? data : 5'bzzzzz;
endmodule

module triSt16(data, ctrl, out);
	input ctrl;
	input [15:0] data;
	output [15:0] out;
	
	assign out = (ctrl) ? data : 16'bzzzzzzzzzzzzzzzz;
endmodule

module triSt32(data, ctrl, out);
	input ctrl;
	input [31:0] data;
	output [31:0] out;
	
	assign out = (ctrl) ? data : 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
endmodule

module decoder(in, out);
	input [4:0] in;
	output [31:0] out;
	
	assign out[0] = ~in[4] & ~in[3] & ~in[2] & ~in[1] & ~in[0];
	assign out[1] = ~in[4] & ~in[3] & ~in[2] & ~in[1] & in[0];
	assign out[2] = ~in[4] & ~in[3] & ~in[2] & in[1] & ~in[0];
	assign out[3] = ~in[4] & ~in[3] & ~in[2] & in[1] & in[0];
	assign out[4] = ~in[4] & ~in[3] & in[2] & ~in[1] & ~in[0];
	assign out[5] = ~in[4] & ~in[3] & in[2] & ~in[1] & in[0];
	assign out[6] = ~in[4] & ~in[3] & in[2] & in[1] & ~in[0];
	assign out[7] = ~in[4] & ~in[3] & in[2] & in[1] & in[0];
	assign out[8] = ~in[4] & in[3] & ~in[2] & ~in[1] & ~in[0];
	assign out[9] = ~in[4] & in[3] & ~in[2] & ~in[1] & in[0];
	assign out[10] = ~in[4] & in[3] & ~in[2] & in[1] & ~in[0];
	assign out[11] = ~in[4] & in[3] & ~in[2] & in[1] & in[0];
	assign out[12] = ~in[4] & in[3] & in[2] & ~in[1] & ~in[0];
	assign out[13] = ~in[4] & in[3] & in[2] & ~in[1] & in[0];
	assign out[14] = ~in[4] & in[3] & in[2] & in[1] & ~in[0];
	assign out[15] = ~in[4] & in[3] & in[2] & in[1] & in[0];
	assign out[16] = in[4] & ~in[3] & ~in[2] & ~in[1] & ~in[0];
	assign out[17] = in[4] & ~in[3] & ~in[2] & ~in[1] & in[0];
	assign out[18] = in[4] & ~in[3] & ~in[2] & in[1] & ~in[0];
	assign out[19] = in[4] & ~in[3] & ~in[2] & in[1] & in[0];
	assign out[20] = in[4] & ~in[3] & in[2] & ~in[1] & ~in[0];
	assign out[21] = in[4] & ~in[3] & in[2] & ~in[1] & in[0];
	assign out[22] = in[4] & ~in[3] & in[2] & in[1] & ~in[0];
	assign out[23] = in[4] & ~in[3] & in[2] & in[1] & in[0];
	assign out[24] = in[4] & in[3] & ~in[2] & ~in[1] & ~in[0];
	assign out[25] = in[4] & in[3] & ~in[2] & ~in[1] & in[0];
	assign out[26] = in[4] & in[3] & ~in[2] & in[1] & ~in[0];
	assign out[27] = in[4] & in[3] & ~in[2] & in[1] & in[0];
	assign out[28] = in[4] & in[3] & in[2] & ~in[1] & ~in[0];
	assign out[29] = in[4] & in[3] & in[2] & ~in[1] & in[0];
	assign out[30] = in[4] & in[3] & in[2] & in[1] & ~in[0];
	assign out[31] = in[4] & in[3] & in[2] & in[1] & in[0];
endmodule

module multiplexer(ctrl, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11,
		r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24,
		r25, r26, r27, r28, r29, r30, r31, out);
	input [4:0] ctrl;
	input [31:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12,
			r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24,
			r25, r26, r27, r28, r29, r30, r31;
	output [31:0] out;
	wire [31:0] triStCtrl;
	
	decoder triStSelect (ctrl, triStCtrl);
	triSt32 triSt0 (r0, triStCtrl[0], out);
	triSt32 triSt1 (r1, triStCtrl[1], out);
	triSt32 triSt2 (r2, triStCtrl[2], out);
	triSt32 triSt3 (r3, triStCtrl[3], out);
	triSt32 triSt4 (r4, triStCtrl[4], out);
	triSt32 triSt5 (r5, triStCtrl[5], out);
	triSt32 triSt6 (r6, triStCtrl[6], out);
	triSt32 triSt7 (r7, triStCtrl[7], out);
	triSt32 triSt8 (r8, triStCtrl[8], out);
	triSt32 triSt9 (r9, triStCtrl[9], out);
	triSt32 triSt10 (r10, triStCtrl[10], out);
	triSt32 triSt11 (r11, triStCtrl[11], out);
	triSt32 triSt12 (r12, triStCtrl[12], out);
	triSt32 triSt13 (r13, triStCtrl[13], out);
	triSt32 triSt14 (r14, triStCtrl[14], out);
	triSt32 triSt15 (r15, triStCtrl[15], out);
	triSt32 triSt16 (r16, triStCtrl[16], out);
	triSt32 triSt17 (r17, triStCtrl[17], out);
	triSt32 triSt18 (r18, triStCtrl[18], out);
	triSt32 triSt19 (r19, triStCtrl[19], out);
	triSt32 triSt20 (r20, triStCtrl[20], out);
	triSt32 triSt21 (r21, triStCtrl[21], out);
	triSt32 triSt22 (r22, triStCtrl[22], out);
	triSt32 triSt23 (r23, triStCtrl[23], out);
	triSt32 triSt24 (r24, triStCtrl[24], out);
	triSt32 triSt25 (r25, triStCtrl[25], out);
	triSt32 triSt26 (r26, triStCtrl[26], out);
	triSt32 triSt27 (r27, triStCtrl[27], out);
	triSt32 triSt28 (r28, triStCtrl[28], out);
	triSt32 triSt29 (r29, triStCtrl[29], out);
	triSt32 triSt30 (r30, triStCtrl[30], out);
	triSt32 triSt31 (r31, triStCtrl[31], out);
endmodule

module thirtyTwoMux(ctrl, addIn, subIn, andIn, orIn, sllIn, sraIn, out);
	input [4:0] ctrl;
	input [31:0] addIn, subIn, andIn, orIn, sllIn, sraIn;
	output [31:0] out;
	wire addCtrl, subCtrl, andCtrl, orCtrl, sllCtrl, sraCtrl;
	
	assign addCtrl = ~ctrl[4] & ~ctrl[3] & ~ctrl[2] & ~ctrl[1] & ~ctrl[0];
	assign subCtrl = ~ctrl[4] & ~ctrl[3] & ~ctrl[2] & ~ctrl[1] & ctrl[0];
	assign andCtrl = ~ctrl[4] & ~ctrl[3] & ~ctrl[2] & ctrl[1] & ~ctrl[0];
	assign orCtrl = ~ctrl[4] & ~ctrl[3] & ~ctrl[2] & ctrl[1] & ctrl[0];
	assign sllCtrl = ~ctrl[4] & ~ctrl[3] & ctrl[2] & ~ctrl[1] & ~ctrl[0];
	assign sraCtrl = ~ctrl[4] & ~ctrl[3] & ctrl[2] & ~ctrl[1] & ctrl[0];
	
	triSt32 addTS(.data(addIn), .ctrl(addCtrl), .out(out));
	triSt32 subTS(.data(subIn), .ctrl(subCtrl), .out(out));
	triSt32 andTS(.data(andIn), .ctrl(andCtrl), .out(out));
	triSt32 orTS(.data(orIn), .ctrl(orCtrl), .out(out));
	triSt32 sllTS(.data(sllIn), .ctrl(sllCtrl), .out(out));
	triSt32 sraTS(.data(sraIn), .ctrl(sraCtrl), .out(out));
endmodule

module eightMux(ctrl, i0, i1, i2, i3, i4, i5, i6, i7, out);
	input [2:0] ctrl;
	input i0, i1, i2, i3, i4, i5, i6, i7;
	output out;
	wire ctrl0, ctrl1, ctrl2, ctrl3, ctrl4, ctrl5, ctrl6, ctrl7;
	
	assign ctrl0 = ~ctrl[2] & ~ctrl[1] & ~ctrl[0];
	assign ctrl1 = ~ctrl[2] & ~ctrl[1] & ctrl[0];
	assign ctrl2 = ~ctrl[2] & ctrl[1] & ~ctrl[0];
	assign ctrl3 = ~ctrl[2] & ctrl[1] & ctrl[0];
	assign ctrl4 = ctrl[2] & ~ctrl[1] & ~ctrl[0];
	assign ctrl5 = ctrl[2] & ~ctrl[1] & ctrl[0];
	assign ctrl6 = ctrl[2] & ctrl[1] & ~ctrl[0];
	assign ctrl7 = ctrl[2] & ctrl[1] & ctrl[0];
	
	triSt ts0(.data(i0), .ctrl(ctrl0), .out(out));
	triSt ts1(.data(i1), .ctrl(ctrl1), .out(out));
	triSt ts2(.data(i2), .ctrl(ctrl2), .out(out));
	triSt ts3(.data(i3), .ctrl(ctrl3), .out(out));
	triSt ts4(.data(i4), .ctrl(ctrl4), .out(out));
	triSt ts5(.data(i5), .ctrl(ctrl5), .out(out));
	triSt ts6(.data(i6), .ctrl(ctrl6), .out(out));
	triSt ts7(.data(i7), .ctrl(ctrl7), .out(out));
endmodule

module twoMux5(ctrl, inputA, inputB, out);
	input ctrl;
	input [4:0] inputA, inputB;
	output [4:0] out;
	wire ctrlA, ctrlB;
	
	assign ctrlA = ~ctrl;
	assign ctrlB = ctrl;
	
	triSt5 aTS(.data(inputA), .ctrl(ctrlA), .out(out));
	triSt5 bTS(.data(inputB), .ctrl(ctrlB), .out(out));
endmodule

module twoMux16(ctrl, inputA, inputB, out);
	input ctrl;
	input [15:0] inputA, inputB;
	output [15:0] out;
	wire ctrlA, ctrlB;
	
	assign ctrlA = ~ctrl;
	assign ctrlB = ctrl;
	
	triSt16 aTS(.data(inputA), .ctrl(ctrlA), .out(out));
	triSt16 bTS(.data(inputB), .ctrl(ctrlB), .out(out));
endmodule

module twoMux32(ctrl, inputA, inputB, out);
	input ctrl;
	input [31:0] inputA, inputB;
	output [31:0] out;
	wire ctrlA, ctrlB;
	
	assign ctrlA = ~ctrl;
	assign ctrlB = ctrl;
	
	triSt32 aTS(.data(inputA), .ctrl(ctrlA), .out(out));
	triSt32 bTS(.data(inputB), .ctrl(ctrlB), .out(out));
endmodule

module fourMux32(ctrl, inputA, inputB, inputC, inputD, out);
	input [1:0] ctrl;
	input [31:0] inputA, inputB, inputC, inputD;
	output [31:0] out;
	wire ctrlA, ctrlB, ctrlC, ctrlD;
	
	assign ctrlA = ~ctrl[1] & ~ctrl[0];
	assign ctrlB = ~ctrl[1] & ctrl[0];
	assign ctrlC = ctrl[1] & ~ctrl[0];
	assign ctrlD = ctrl[1] & ctrl[0];
	
	triSt32 aTS(.data(inputA), .ctrl(ctrlA), .out(out));
	triSt32 bTS(.data(inputB), .ctrl(ctrlB), .out(out));
	triSt32 cTS(.data(inputC), .ctrl(ctrlC), .out(out));
	triSt32 dTS(.data(inputD), .ctrl(ctrlD), .out(out));
endmodule

module fourMux5(ctrl, inputA, inputB, inputC, inputD, out);
	input [1:0] ctrl;
	input [4:0] inputA, inputB, inputC, inputD;
	output [4:0] out;
	wire ctrlA, ctrlB, ctrlC, ctrlD;
	
	assign ctrlA = ~ctrl[1] & ~ctrl[0];
	assign ctrlB = ~ctrl[1] & ctrl[0];
	assign ctrlC = ctrl[1] & ~ctrl[0];
	assign ctrlD = ctrl[1] & ctrl[0];
	
	triSt5 aTS(.data(inputA), .ctrl(ctrlA), .out(out));
	triSt5 bTS(.data(inputB), .ctrl(ctrlB), .out(out));
	triSt5 cTS(.data(inputC), .ctrl(ctrlC), .out(out));
	triSt5 dTS(.data(inputD), .ctrl(ctrlD), .out(out));
endmodule

module signEx17(data, out);
	input 	[16:0]	data;
	output 	[31:0]	out;

	assign out[16:0] = data;
	genvar i;
	generate
		for (i = 17; i <= 31; i = i + 1) begin: loop1
			assign out[i] = data[16];
		end
	endgenerate
endmodule

module signEx27(data, out);
	input 	[26:0]	data;
	output 	[31:0]	out;

	assign out[26:0] = data;
	genvar i;
	generate
		for (i = 27; i <= 31; i = i + 1) begin: loop1
			assign out[i] = data[26];
		end
	endgenerate
endmodule

module stage(inputA, inputB, inputC, inputD, clk, we, reset, outA, outB, outC, outD, testD, testQ, testAclr, testWE, testClk);
	input 	[31:0] 	inputA, inputB, inputC, inputD;
	input 			clk, we, reset;
	output 	[31:0] 	outA, outB, outC, outD, testD, testQ;
	output 			testAclr, testWE, testClk;

	dff32 dataA(	.d(inputA),
					.aclr(reset),
					.we(we),
					.clk(clk),
					.q(outA));
	dff32Special dataB(	.d(inputB),
						.aclr(reset),
						.we(we),
						.clk(clk),
						.q(outB),
						.testD(testD),
						.testQ(testQ),
						.testAclr(testAclr),
						.testWE(testWE),
						.testClk(testClk));
	dff32 dataC(	.d(inputC),
					.aclr(reset),
					.we(we),
					.clk(clk),
					.q(outC));
	dff32 dataD(	.d(inputD),
					.aclr(reset),
					.we(we),
					.clk(clk),
					.q(outD));
endmodule

module fiveComp(inputA, inputB, out);
	input 	[4:0] 	inputA, inputB;
	output 			out;
	wire 	[4:0]	equals;

	genvar i;
	generate
		for (i = 0; i <= 4; i = i + 1) begin: loop1
			assign equals[i] = ~(inputA[i] ^ inputB[i]);
		end
	endgenerate

	assign out = equals[4] & equals[3] & equals[2] & equals[1] & equals[0];
endmodule