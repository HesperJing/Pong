module led (
    input clock,
	 input reset,
	 input right,
	 input left,
	output wire [9:1] led    //9 LEDs (1 to 9) used to blink when a player wins.
	 );
	 
	reg [24:0] counter = 25'b0;    //System clock is 50MHz, which is too high for eyes to see leds blinking. This counter is used to divide frequency. Blinker's frequency is 50MHz/2^25=1.49Hz. 
	 reg enable;
	 reg [9:1] led_loop;
	 wire enable_loop;
	 
	 assign enable_loop = enable;
	 assign led = led_loop;
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      counter <= 25'b0;    //If reset, counter starts over from 0.   
		  end else begin
		      counter <= counter+1'b1;
		  end
	 end 
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      enable <= 1'b0;
	     end else if (counter==25'hffffff) begin    //When counter is full, provides a enable signal to light up leds.
		      enable <= 1'b1;
		  end else begin
		      enable <= 1'b0;
		  end 
	 end 
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      led_loop <= 9'b100000000;    //Light up the led9 at first.
		  end else if(enable_loop && left) begin
			  led_loop <= {led_loop[1], led_loop[9:2]};    //Leds light up from left to right in turn.
		  end else if(enable_loop && right) begin
			  led_loop <= {led_loop[8:1], led_loop[9]};    //Leds light up from right to left in turn.
		  end
	 end

endmodule
