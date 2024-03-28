module counter_10 (
    input clk,      
    input rst_n,    
    output reg [2:0] sec_10,
	 output reg clock_1min
);

wire [3:0] sec_1;
counter_1 khoi_giay (.clk(clk), .rst_n(rst_n), .sec_1(sec_1)); 

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        sec_10 <= 3'b000;
		  clock_1min <=0;
    end
    else begin
	 if (sec_1 == 4'b1001) begin
            if (sec_10 == 3'd5) begin
                sec_10 <= 3'b000;
                clock_1min <= 1'b1;
            end
            else begin
                sec_10 <= sec_10 + 1;
            end
        end
    end
end
endmodule
