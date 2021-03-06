module led (
    input clock,
	 input reset,
	 input right,
	 input left,
	 output wire [9:1] led
	 );
	 
	 reg [24:0] counter = 25'b0;
	 reg enable;
	 reg [9:1] led_loop;
	 wire enable_loop;
	 
	 assign enable_loop = enable;
	 assign led = led_loop;
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      counter <= 25'b0;
		  end else begin
		      counter <= counter+1'b1;
		  end
	 end 
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      enable <= 1'b0;
		  end else if (counter==25'hffffff) begin
		      enable <= 1'b1;
		  end else begin
		      enable <= 1'b0;
		  end 
	 end 
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      led_loop <= 9'b100000000;
		  end else if(enable_loop && left) begin
				led_loop <= {led_loop[1], led_loop[9:2]};
		  end else if(enable_loop && right) begin
				led_loop <= {led_loop[8:1], led_loop[9]};
		  end
	 end

endmodule
