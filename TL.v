module traffic_light_controller(
	input Ta,
	input Tb,
	input clk,
	input rst,
	output Ga,
	output Ya,
	output Ra,
	output Gb,
	output Yb,
	output Rb
);

	reg [1:0] state, nextstate, currstate;
	parameter s0 = 2'b00;
	parameter s1 = 2'b01;
	parameter s2 = 2'b10;
	parameter s3 = 2'b11;

	reg Ra1,Ya1,Ga1,Rb1,Yb1,Gb1;

	//nextstate logic
	always @ (posedge clk, posedge rst)
		if (rst) state <= s0;
		else 
		begin
			currstate <= state;
			state <= nextstate;
		end

	always @ (*)
		case(state)
			s0:	begin
					if(Ta) nextstate = s0;
					else  nextstate = s1;
				end
			s1: begin
					nextstate = s2;
				end
			s2: begin
					if(Tb) nextstate = s2;
					else  nextstate = s3;
				end
			s3: begin
					nextstate = s0;
				end
			default nextstate = s0;
		endcase

	//output logic
	always @ (*)
		case(currstate)
			s0:	begin
					 Ra1 <= 0;
					 Ya1 <= 0;
					 Ga1 <= 1;
					 Rb1 <= 1;
					 Yb1 <= 0;
					 Gb1 <= 0;
				end
			s1: begin
					 Ra1 <= 0;
					 Ya1 <= 1;
					 Ga1 <= 0;
					 Rb1 <= 1;
					 Yb1 <= 0;
					 Gb1 <= 0;
				end
			s2: begin
					 Ra1 <= 1;
					 Ya1 <= 0;
					 Ga1 <= 0;
					 Rb1 <= 0;
					 Yb1 <= 0;
					 Gb1 <= 1;
				end
			s3: begin
					 Ra1 <= 1;
					 Ya1 <= 0;
					 Ga1 <= 0;
					 Rb1 <= 0;
					 Yb1 <= 1;
					 Gb1 <= 0;
				end
			default nextstate = s0;
		endcase
		
		 //Final Lights
		 assign Ra = Ra1;
		 assign Rb = Rb1;
		 assign Ya = Ya1;
		 assign Yb = Yb1;
		 assign Ga = Ga1;
		 assign Gb = Gb1;

endmodule		
