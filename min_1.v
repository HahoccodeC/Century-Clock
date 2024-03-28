module min_1 (
    input clk,
    input rst_n,
    output reg [3:0] minutes_1,
	 output reg clock_min10
);

wire [3:0] sec_1;
wire [2:0] sec_10;

counter_1 khoi_phut_1a (
    .clk(clk),
    .rst_n(rst_n),
    .sec_1(sec_1)
);

counter_10 khoi_phut_1b (
    .clk(clk),
    .rst_n(rst_n),
    .sec_10(sec_10)
);

always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        minutes_1 <= 4'b0000;
		  clock_min10 <= 0;
    end
    else begin
        if (sec_10 == 3'b101 && sec_1 == 4'b1001) begin
            minutes_1 <= minutes_1 + 1;
        end
        else if (minutes_1 == 4'b1010) begin
            minutes_1 <= 4'b0000;
				clock_min10 <= 1;
        end
    end
end

endmodule

