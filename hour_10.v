module hour_10(   
  input clk,
  input rst_n, 
  output reg [1:0] hours_10,
  output reg clock_day1
);
 wire [4:0] hours_1;
 hour_1 khoi_gio_10a (.clk(clk), .rst_n(rst_n), .hours_1(hours_1));
 
always @ (posedge clk or negedge rst_n) begin
  if(!rst_n) begin
  hours_10 <= 2'b00;
  clock_day1 <= 0;
  end
 else begin
    if (hours_1 == 4'd10) begin
        hours_10 <= hours_10 + 1; 
    end
    else if (hours_1 == 4'd4 && hours_10 == 2'd2) begin
        hours_10 <= 2'b00; 
        clock_day1 <= 1; 
    end
end
end
endmodule