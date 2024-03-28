module day_mon_year(
  input clk,
  input rst_n,
  output reg [3:0] day_1,
  output reg [1:0] day_10,
  output reg [3:0] mon_1,
  output reg [1:0] mon_10,
  output reg [3:0] year_1,
  output reg [3:0] year_10
);
wire [3:0] hour1;
wire [1:0] hour10;
hour_1 dmy (.clk (clk), .rst_n(rst_n), .hours_1(hours_1));
hour_10 dmy1 (.clk(clk), .rst_n(rst_n), .hours_10(hours_10));
reg day_flag;
reg [5:0] day_reg; 
reg [5:0] month_reg; 
reg [5:0] year_reg; 
reg [4:0] days_in_month [1:12];
initial begin
    days_in_month[1] = 31;
    days_in_month[2] = 28;
    days_in_month[3] = 31;
    days_in_month[4] = 30;
    days_in_month[5] = 31;
    days_in_month[6] = 30;
    days_in_month[7] = 31;
    days_in_month[8] = 31;
    days_in_month[9] = 30;
    days_in_month[10] = 31;
    days_in_month[11] = 30;
    days_in_month[12] = 31;
end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        day_reg <= 5'd1; 
        month_reg <= 5'd3; 
        year_reg <= 8'd24; 
        day_flag <= 1'b0; 
    end
    else begin
        if ((hours_10 == 2'b10) && (hours_1 == 4'd4)) begin
            day_flag <= 1'b1; 
        end

        if (day_flag == 1'b1) begin
            if (day_reg == days_in_month[month_reg]) begin
                day_reg <= 5'd1; 
                if (month_reg == 12)
                    month_reg <= 5'd1; 
                else
                    month_reg <= month_reg + 1; 
            end
            else begin
                day_reg <= day_reg + 1; 
            end
        end
    end
end
always @ (day_reg or month_reg or year_reg) begin
    integer i;
    reg [6:0] temp_day;
    reg [6:0] temp_month;
    reg [8:0] temp_year;

    temp_day = {6'b000000, day_reg};
    for (i = 0; i < 6; i = i + 1) begin
        if (temp_day >= 5'd5) begin
            temp_day = temp_day + 3;
        end
        temp_day = temp_day << 1;
    end
    day_1 = temp_day[3:0];
    day_10 = temp_day[6:4];

    temp_month = {6'b000000, month_reg};
    for (i = 0; i < 6; i = i + 1) begin
        if (temp_month >= 5'd5) begin
            temp_month = temp_month + 3;
        end
        temp_month = temp_month << 1;
    end
    mon_1 = temp_month[3:0];
    mon_10 = temp_month[6:4];

    temp_year = {8'b00000000, year_reg};
    for (i = 0; i < 8; i = i + 1) begin
        if (temp_year >= 5'd5) begin
            temp_year = temp_year + 3;
        end
        temp_year = temp_year << 1;
    end
    year_1 = temp_year[3:0];
    year_10 = temp_year[7:4];
end


endmodule