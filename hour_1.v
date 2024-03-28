module hour_1 (
  input clk,
  input rst_n,
  output reg [4:0] hours_1,
  output reg clock_hour10
);
 wire [3:0] minutes_1;
 wire [2:0] minutes_10;
min_1 khoi_gio_1a ( .clk(clk), .rst_n(rst_n), .minutes_1(minutes_1));
min_10 khoi_gio_1b ( .clk(clk0), .rst_n(rst_n), .minutes_10(minutes_10));

always @ (posedge clk or negedge rst_n) begin
  if(!rst_n) begin
    hours_1 <= 4'b0000;
	 clock_hour10 <= 0;
  end
  else begin
    if (minutes_10 == 3'b110 && minutes_1 == 4'b0000) begin
            hours_1 <= hours_1 + 1;
        end
        else if (hours_1 == 4'b1010) begin
            hours_1 <= 4'b0000;
				clock_hour10 <= 1;
        end
end
end
endmodule