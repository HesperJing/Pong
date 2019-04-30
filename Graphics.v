module Graphics #(
	parameter BACKGROUND_RGB	= 16'h00,
	parameter BALL_RGB 			= 16'hff,												//RGB color of the ball
	parameter PADDLE_RGB			= 16'hff,												//RGB color of the paddle
	parameter BALL_SIZE			= 4,														//length of ball edge in pixel
	parameter PADDLE_WIDTH 		= 3,														//width of paddle in pixels
	parameter PADDLE_HEIGTH 	= 20,														//heigth of paddle in pixels
	parameter MAX_H 				= 320,													//maximum horizontal position of the ball														
	parameter MAX_V 				= 240,													//maximum vertical position of the ball			
	parameter MIN_H 				= 0,														//minimum horizontal position of the ball
	parameter MIN_V 				= 0														//minimum vertical position of the ball
	)(
	input wire [8:0]	ball_x,
	input wire [8:0]	ball_y,
	input wire [8:0]	paddle_1_x,
	input wire [8:0]	paddle_1_y,
	input wire [8:0]	paddle_2_x,
	input wire [8:0]	paddle_2_y,
	input wire [8:0]	pixel_x,
	input wire [8:0]	pixel_y,
	output reg [15:0]	pixel_color
	);
	
	always @(pixel_x or pixel_y) begin 
	
		if (pixel_y >= ball_y && pixel_y <= (ball_y + BALL_SIZE)) begin
		
			if (pixel_x >= ball_x && pixel_x <= (ball_x + BALL_SIZE)) begin
			
				pixel_color <= BALL_RGB;
				
			end
		
		end else if (pixel_y >= paddle_1_y && pixel_y <= (paddle_1_y + PADDLE_HEIGTH)) begin
		
			if (pixel_x >= paddle_1_x && pixel_x <= (paddle_1_x + PADDLE_WIDTH)) begin
			
				pixel_color <= PADDLE_RGB;
				
			end
		
		end else if (pixel_y >= paddle_2_y && pixel_y <= (paddle_2_y + PADDLE_HEIGTH)) begin
		
			if (pixel_x >= paddle_2_x && (pixel_x <= (paddle_2_x + PADDLE_WIDTH))) begin
			
				pixel_color <= PADDLE_RGB;
				
			end
			
		end else begin
		
			pixel_color <= BACKGROUND_RGB;
		
		end
		
	end

endmodule	