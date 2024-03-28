module min_10 (
  input clk, 
  input rst_n,
  output reg [3:0] minutes_10,
  output reg clock_hour1
);
  wire [3:0] sec_1;
  wire [2:0] sec_10;
  wire [3:0] minutes_1;
  counter_1 khoi_phut_10a ( .clk(clk), .rst_n(rst_n), .sec_1(sec_1));
  counter_10 khoi_phut_10b (.clk(clk), .rst_n(rst_n), .sec_10(sec_10));
  min_1 khoi_phut_10c (.clk(clk), .rst_n(rst_n), .minutes_1(minutes_1));
    always @ (posedge clk or negedge rst_n) begin
	 if(!rst_n) begin
	 minutes_10 <= 0;
	 clock_hour1 <= 0;
	 end
	 else begin
	  if (minutes_1 == 4'b1010) begin
                minutes_10 <= minutes_10 + 1;
            end
		else if (minutes_1 == 4'b0000 && minutes_10 == 3'b110) begin
                minutes_10 <= 3'b000;
                clock_hour1 <= 1'b1;
            end
      else begin
		minutes_10 <= minutes_10;
		end
		end
	end
endmodule