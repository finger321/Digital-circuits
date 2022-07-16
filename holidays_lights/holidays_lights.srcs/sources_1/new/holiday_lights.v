module holiday_lights (
    input  wire        clk   ,
	input  wire        rst   ,
	input  wire        button,
    input  wire [2:0] switch,
	output reg  [15:0] led
);
reg [31:0]      cnt=32'd0;
reg  button2=0; 
reg  [2:0]switch2=0;
always@(posedge clk or negedge rst)begin
if (button||button2)
    if(button2==0)  button2<=1;
	if (rst)
		cnt <= 32'd0;                    
     if (cnt ==32'd39)      
		cnt <= 32'd0;                     
	else
		cnt <= cnt + 32'd1;             
end
always@(posedge clk or negedge rst)begin
  if(button||button2)
    if(button2==0) begin
         led<=16'b0000000000000001;
         button2<=1;
      end
      if(switch!=switch2) begin
        switch2<=switch;
        case(switch)
        3'b000:led<=16'b0000000000000001;
        3'b001:led<=16'b0000000000000011;
        3'b010:led<=16'b0000000000000111;
        3'b011:led<=16'b0000000000001111;
        3'b100:led<=16'b0000000000011111;
        3'b101:led<=16'b0000000000111111;
        3'b110:led<=16'b0000000001111111;
        3'b111:led<=16'b0000000011111111;
        endcase
     end
	if (rst)   begin
        case(switch2)
        3'b000:led<=16'b0000000000000001;
        3'b001:led<=16'b0000000000000011;
        3'b010:led<=16'b0000000000000111;
        3'b011:led<=16'b0000000000001111;
        3'b100:led<=16'b0000000000011111;
        3'b101:led<=16'b0000000000111111;
        3'b110:led<=16'b0000000001111111;
        3'b111:led<=16'b0000000011111111;
        endcase
    end           
	else if (cnt ==32'd39)     
		led <= {led[14:0],led[15]};	
;
end

endmodule
