module booth2 (
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
reg [17:0] x1=18'b0;
reg [17:0] x2=18'b0;
//x3为2x补，x4为-2x补
reg [17:0] x3=18'b0;
reg [17:0] x4=18'b0;
//y扩展为两位符号位，末尾添0；
reg [17:0] y1=18'b0;
reg [3:0] cnt=4'b0;
reg temp;
reg [33:0] z1=34'b0;
always @(posedge clk or negedge rst_n) begin
	if(~rst_n)begin
	 busy1<=1'b0;
	 cnt<=4'b0;
     z<=32'b0;
     temp<=1'b0;
	end
	if(start||busy)begin
        if(start)begin
            cnt<=4'b0;
            z<=32'b0;
            z1<=34'b0;
            busy1<=1'b1;
            y1[15:0]=y;
            y1=y1<<1;
            y1[17]=y1[16];
            {x1[17],x1[16],x1[15:0]}={x[15],x[15],x[15:0]};
	        x2[15:0]=~x[15:0]+16'b1;
	        x2[17:16]={x2[15],x2[15]};
	        x3[17:0]=x1<<1;
	        x4[17:0]=x2<<1;
	    end
	    else if(busy==1) begin
	         if(cnt<=4'b1000)begin
	             if(cnt<4'b1000)begin
                    if({y1[2],y1[1],y1[0]}==3'b001||{y1[2],y1[1],y1[0]}==3'b010)begin
                        z1[33:16]=z1[33:16]+x1;
                    end
                    else if({y1[2],y1[1],y1[0]}==3'b011)begin
                        z1[33:16]=z1[33:16]+x3;
                    end
                    else if({y1[2],y1[1],y1[0]}==3'b100)begin
                        z1[33:16]=z1[33:16]+x4;
                    end                           	
                    else if({y1[2],y1[1],y1[0]}==3'b110||{y1[2],y1[1],y1[0]}==3'b101)begin
                        z1[33:16]=z1[33:16]+x2;
                    end
	                else   begin 
	                       z1=z1;
	                end
	                if(z1[32]^z1[31]==1)begin
	                temp=z1[32];
	                end
	                else if(z1[33]^z1[32]==1)begin
	                temp=z1[33];
	                end
	                else begin
	                temp=z1[31];
	                end

	                z1=z1>>2;
	                y1=y1>>2;
	                z1[33:32]={temp,temp};
                 end     
                 else begin
                    busy1=1'b0;
                 end       
                 cnt<=cnt+1;      
           end 
	    end
	    z=z1[31:0];
	end

end
endmodule