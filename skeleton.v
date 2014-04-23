module skeleton(	inclock, resetn, ps2_clock, ps2_data, debug_word, leds, 
					lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon, 	
					seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8, key2_pressed, key3_pressed,
					// reg8out, reg9out,
					col1, col2, col3, col4, col5, testRegWriteData, testRegWriteAddr, testRegWE, testWBRd, testIRWB, testIRFetch, testIRDecode,
					testIRExec, testIRMem, testD, testQ, testFdWE);

	input 			inclock, resetn, key2_pressed, key3_pressed;
	inout 			ps2_data, ps2_clock;
	
	output 			lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon,
					// reg8out, reg9out,
					col1, col2, col3, col4, col5, testRegWE, testFdWE;
	output 	[7:0] 	leds, lcd_data;
	output 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	output 	[4:0] 	testRegWriteAddr, testWBRd;
	output 	[31:0] 	debug_word, testRegWriteData, testIRWB, testIRFetch, testIRDecode, testIRExec, testIRMem, testD, testQ;
	
	wire			clock;
	wire			lcd_write_en;
	wire 	[31:0]	lcd_write_data;
	wire	[7:0]	ps2_key_data;
	wire			ps2_key_pressed;
	wire	[7:0]	ps2_out;
	// wire 	[39:0] 	gridValues;	
	// wire 			gridReady;

	
	// clock divider (by 5, i.e., 10 MHz)
	//pll div(inclock,clock);
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	assign clock = inclock;
	
	// your processor
	processor myprocessor(	clock, ~resetn, ps2_key_pressed, ps2_out, lcd_write_en, debug_word, key2_pressed, key3_pressed,
							testRegWriteData, testRegWriteAddr, testRegWE, testWBRd, testIRWB, testIRFetch, testIRDecode,
							testIRExec, testIRMem, testFdWE, testD, testQ);
							// gridValues, gridReady, reg8out, reg9out); //lcd_write_data);
	
	// keyboard controller
	PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
	
	// lcd controller
	lcd mylcd(clock, ~resetn, lcd_write_en, lcd_write_data[7:0], lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	
	// example for sending ps2 data to the first two seven segment displays
	Hexadecimal_To_Seven_Segment hex1(ps2_out[3:0], seg1);
	Hexadecimal_To_Seven_Segment hex2(ps2_out[7:4], seg2);
	
	// the other seven segment displays are currently set to 0
	Hexadecimal_To_Seven_Segment hex3(4'b0, seg3);
	Hexadecimal_To_Seven_Segment hex4(4'b0, seg4);
	Hexadecimal_To_Seven_Segment hex5(4'b0, seg5);
	Hexadecimal_To_Seven_Segment hex6(4'b0, seg6);
	Hexadecimal_To_Seven_Segment hex7(4'b0, seg7);
	Hexadecimal_To_Seven_Segment hex8(4'b0, seg8);
	
	// some LEDs that you could use for debugging if you wanted
	assign leds = 8'b00101011;

	assign col1 = 1'b0;
	assign col2 = 1'b1;
	assign col3 = 1'b1;
	assign col4 = 1'b1;
	assign col5 = 1'b1;
endmodule
