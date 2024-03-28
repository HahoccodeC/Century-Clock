module counter_1(
   input clk, rst_n,
	output reg [3:0] sec_1,
	output reg clk_10s
);

always @(posedge clk or negedge rst_n) begin
	
    if (~rst_n) begin 
        sec_1 <= 0;
		  clk_10s<=0;
    end
    else begin
        if (sec_1 == 4'b1001) begin
            sec_1 <= 4'b0000;
				clk_10s <= 1;
					end
        else begin
        sec_1 <= sec_1 +1 ; 
		  end
    end
end

endmodule