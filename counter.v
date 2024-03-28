module counter(
input clk,rst_n, sw0,
output [6:0] led1,
output [6:0] led2,
output [6:0] led3,
output [6:0] led4,
output [6:0] led5,
output [6:0] led6
);

wire [3:0] in;
wire [3:0] sec1;
wire [3:0] sec10;
wire [3:0] min1;
wire [3:0] min10;
wire [3:0] hour1;
wire [3:0] hour10;
wire clock;

reg [3:0] sec11;
reg [3:0] sec101;
reg [3:0] min11;
reg [3:0] min101;
reg [3:0] hour11;
reg [3:0] hour101;
reg state;

parameter SETTING_TIME = 0;
parameter SETTING_DAY = 1;

clock clo(
	.clk_1s(clk),
	.rst_1s(rst_n),
	.clock(clock)
);
counter_1 cnt_1 (
   .clk(clock), 
   .rst_n(rst_n), 
	.sec_1(sec1));
counter_10 cnt_10 (
   .clk(clock), 
	.rst_n(rst_n), 
	.sec_10(sec10));
min_1 min_1 (
   .clk(clock), 
	.rst_n (rst_n), 
	.minutes_1(min1));
min_10 min_10 (
   .clk(clock),
	.rst_n (rst_n),
	.minutes_10(min10));
hour_1 hour_1 (
   .clk(clock),
	.rst_n(rst_n),
	.hours_1(hour1)
);
hour_10 hour_10 (
   .clk(clock),
	.rst_n(rst_n),
	.hours_10(hour10)
);
day_mon_year day_mon_year (
   .clk(clock),
	.rst_n(rst_n),
	.day_1(sec1),
	.day_10(sec10),
	.mon_1 (min1),
	.mon_10 (min10),
	.year_1 (hour1),
	.year_10 (hour10)
);

always @ (posedge clk or negedge rst_n) begin 
 if(!rst_n) begin 
    state <= SETTING_TIME;
 end
 else begin 
  if (!sw0) begin
    state <= SETTING_DAY : begin
	  sec11 <= sec_1;
	  sec101 <= sec_10;
	  min11 <= minutes_1;
	  min101 <= minutes_10;
	  hour11 <= hours_1;
	  hour101 <= hours_10;
	 end;
  end
  else begin 
  state <= SETTING_TIME;
  end
 end
end

case (state) 
   SETTING_TIME: begin
	  sec11 <= sec_1;
	  sec101 <= sec_10;
	  min11 <= minutes_1;
	  min101 <= minutes_10;
	  hour11 <= hours_1;
	  hour101 <= hours_10;
	  end
	 SETTING_DAY: begin
	  sec11 <= day_1;
	  sec101 <= day_10;
	  min11 <= mon_1;
	  min101 <= mon_10;
	  hour11 <= year_1;
	  hour101 <= year_10;
	 end
	default: SETTING_TIME;
end
endcase
end
LED7 led7a (.in(sec11), .led(led1));
LED7 led7b (.in(sec101), .led(led2));
LED7 led7c (.in(min11), .led(led3));
LED7 led7d (.in(min101), .led(led4));
LED7 led7e (.in(hour11), .led(led5));
LED7 led7f (.in(hour101), .led(led6));

endmodule