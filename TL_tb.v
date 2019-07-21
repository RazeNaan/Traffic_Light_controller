//Linear-feedback  shift register to generate random traffic
module LFSR(out,clk,rst);
	output reg [4:0] out;
	input clk,rst;
	wire feedback;
	assign feedback = ~(out[2]^out[4]);
	always@(posedge clk,posedge rst)
		begin
			if(rst) 
				out = 5'b0;
			else
				out = {out[3:0],feedback};
		end
endmodule

module test_TLC;

	reg Ta, Tb,  clk, rst;
	wire Ra, Ya, Ga, Rb, Yb, Gb;
	wire SensorA;
	wire SensorB;
	wire [4:0] out;
	integer i;

	traffic_light_controller dut(Ta, Tb, clk, rst, Ra, Ya, Ga, Rb, Yb, Gb);

	LFSR shift_rgstr(out,clk,rst);
	assign SensorA = shift_rgstr.out[0];
	assign SensorB = shift_rgstr.out[1];
	
	always
	begin 
		clk = 1; #5;
		clk = 0; #5;
	end
	initial
	begin
			rst = 1;
	 #5 rst = 0;
	end
	
	initial
	begin
		$dumpfile ("dump.vcd");
		$dumpvars (0, dut);
		$display("                                                                                Ra Ya Ga                      Rb Yb Gb");
		for(i = 0; i <= 15; i = i + 1)
		begin
			Ta = SensorA;
			Tb = SensorB; #10;
			$display("Current State = ", dut.currstate, "  Next State = ", dut.state, "  InputA = ", Ta, "  InputB = ", Tb, "  Traffic Light at A = ", Ra,"  ", Ya, "  ", Ga, "  Traffic Light at B = ", Rb, "  ", Yb, "  ", Gb);
		end
		$finish;
	end
endmodule
