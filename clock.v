module clock ( 
  input clk_1s,
  input rst_1s,
  output reg clock
);
localparam COUNT_1S = 25000000-1;
reg [26:0] counter=0;
always @ (posedge clk_1s or negedge rst_1s) begin
  if(!rst_1s) begin
		counter<=0;
		clock<=0;
	end
	else begin 
			if(counter==COUNT_1S) begin
				clock<=~clock;
				counter=0;
			end
			else begin
				counter=counter+1;
			end
		end
	end
endmodule