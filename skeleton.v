module skeleton(	inclock, resetn, ps2_clock, ps2_data, debug_word, leds, 
					lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon, 	
					seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8, key2_pressed, key3_pressed,
					testRegWriteData, testRegWriteAddr, testRegWE, ledLeads);

	input 			inclock, resetn, key2_pressed, key3_pressed;
	inout 			ps2_data, ps2_clock;
	
	output 			lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon, testRegWE;
	output 	[7:0] 	leds, lcd_data;
	output 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	output 	[4:0] 	testRegWriteAddr;
	output 	[31:0] 	debug_word, testRegWriteData;
	
	wire			clock;
	wire			lcd_write_en;
	wire 	[31:0]	lcd_write_data;
	wire	[7:0]	ps2_key_data;
	wire			ps2_key_pressed;
	wire	[7:0]	ps2_out;
	wire 	[39:0] 	gridValues;	
	wire 			gridReady;
	
	// clock divider (by 5, i.e., 10 MHz)
	//pll div(inclock,clock);
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	assign clock = inclock;
	
	// your processor
	processor myprocessor(	clock, ~resetn, ps2_key_pressed, ps2_out, lcd_write_en, debug_word, key2_pressed, key3_pressed,
							testRegWriteData, testRegWriteAddr, testRegWE, gridValues, gridReady, reg8out, reg9out); //lcd_write_data);
	
	// keyboard controller
	PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
	
	// lcd controller
	lcd mylcd(clock, ~resetn, lcd_write_en, lcd_write_data[7:0], lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);

	// LED DISPLAY CODE HERE
	wire [4:0] colActive;
	wire [7:0] col1, col2, col3, col4, col5;
	output [13:0] ledLeads;

	ringCounter5 LEDcounter(clock, colActive); // can put in separate clock

	assign col1 = gridValues[39:32];
	assign col2 = gridValues[31:24];
	assign col3 = gridValues[23:16];
	assign col4 = gridValues[15:8];
	assign col5 = gridValues[7:0];

	assign ledLeads[0]  = gridReady & (colActive[4]&col1[2] | colActive[3]&col2[2] | colActive[2]&col3[2] | colActive[1]&col4[2] | colActive[0]&col5[2]); //LED pin 1, row 6
	assign ledLeads[1]  = gridReady & (colActive[4]&col1[0] | colActive[3]&col2[0] | colActive[2]&col3[0] | colActive[1]&col4[0] | colActive[0]&col5[0]); //LED pin 2, row 8
	assign ledLeads[2]  = ~(gridReady & colActive[3]); //LED pin 3, col 2
	assign ledLeads[3]  = ~(gridReady & colActive[2]); //LED pin 4, col 3
	assign ledLeads[4]  = gridReady & (colActive[4]&col1[3] | colActive[3]&col2[3] | colActive[2]&col3[3] | colActive[1]&col4[3] | colActive[0]&col5[3]); //LED pin 5, row 5
	assign ledLeads[5]  = ~(gridReady & colActive[0]); //LED pin 6, col 5
	assign ledLeads[6]  = gridReady & (colActive[4]&col1[1] | colActive[3]&col2[1] | colActive[2]&col3[1] | colActive[1]&col4[1] | colActive[0]&col5[1]); //LED pin 7, row 7
	assign ledLeads[7]  = gridReady & (colActive[4]&col1[5] | colActive[3]&col2[5] | colActive[2]&col3[5] | colActive[1]&col4[5] | colActive[0]&col5[5]); //LED pin 8, row 3
	assign ledLeads[8]  = gridReady & (colActive[4]&col1[7] | colActive[3]&col2[7] | colActive[2]&col3[7] | colActive[1]&col4[7] | colActive[0]&col5[7]); //LED pin 9, row 1
	assign ledLeads[9]  = ~(gridReady & colActive[1]); //LED pin 10, col 4
	assign ledLeads[10] = ledLeads[3]; //LED pin 11, col 3
	assign ledLeads[11] = gridReady & (colActive[4]&col1[4] | colActive[3]&col2[4] | colActive[2]&col3[4] | colActive[1]&col4[4] | colActive[0]&col5[4]); //LED pin 12, row 4
	assign ledLeads[12] = ~(gridReady & colActive[4]); //LED pin 13, col 1
	assign ledLeads[13] = gridReady & (colActive[4]&col1[6] | colActive[3]&col2[6] | colActive[2]&col3[6] | colActive[1]&col4[6] | colActive[0]&col5[6]); //LED pin 14, row 2
endmodule
