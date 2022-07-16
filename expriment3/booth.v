module booth (
    input  wire        clk  ,
	input  wire        rst_n,
	input  wire [15:0] x    ,
	input  wire [15:0] y    ,
	input  wire        start,
	output reg  [31:0] z    ,
	output wire        busy 
);


reg  busy1=1'b0;
assign busy=busy1;
reg [15:0] x1=16'b0;
reg [15:0] x2=16'b0;
reg [15:0] y1=16'b0;
reg [4:0] cnt=5'b0;
reg yn1=1'b0;
reg temp;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n)begin
	 busy1<=1'b0;
	 cnt<=5'b0;
     z<=32'b0;
	end
	if(start||busy)begin
        if(start)begin
            cnt<=5'b0;
            z<=32'b0;
            busy1<=1'b1;
            y1[15:0]<=y[15:0];
            x1[15:0]<=x[15:0];
	        x2[15:0]<=~x[15:0]+16'b1;
	        yn1<=1'b0;
	    end
	    else if(busy==1) begin
	         if(cnt<=5'b10000)begin
	             if(cnt<5'b10000)begin
	                 if(y1[0]^yn1==1&&yn1>y1[0])begin
	                     yn1=y1[0];
	                     z[31:16]=z[31:16]+x1[15:0];
	                 end
	                 else if(y1[0]^yn1==1&&yn1<y1[0])begin
	                     yn1=y1[0];
	                     z[31:16]=z[31:16]+x2[15:0];
	                 end
	                 else begin
	                     y1=y1;
	                     z=z;
	                 end
	                 temp=z[31];
	                 y1[15:0]=y1[15:0]>>1;
	                 z[31:0]=z[31:0]>>1;
	                 z[31]=temp;
                 end     
                 else begin
                    busy1=1'b0;
                 end       
                 cnt<=cnt+1;      
           end 
	    end
	end
end
endmodule