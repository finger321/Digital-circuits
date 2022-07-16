module memory_w_r(
   input wire clk_g,
   input wire rst,
   input wire button,
   input wire [15:0]douta,
   output reg ena,
   output reg wea,
   output reg [3:0]addra,
   output reg [15:0] led,
   output reg [15:0]dina
    );
reg [31:0] cnt;
reg work;
reg read;
always@(posedge clk_g or negedge rst)begin
    if(rst==1'b1)begin
    cnt<=32'd0;
    work<=0;
    end
    else begin
     if(button)begin
        work<=1;
        cnt<=32'd0;
    end
    if(work)  begin
      if (cnt ==32'd49)      
		cnt <= 32'd0;                     
	else
		cnt <= cnt + 32'd1; 
    end                 
   end
end
always@(posedge clk_g or negedge rst )begin
       if(rst==1'b1)begin
        work<=0;
        dina<=16'b0000000000000001;
        led<=16'b0000000000000000;
        addra<=4'b0000;  
        end
        else begin
           if(button)begin
                work<=1;
                ena<=1;
                wea<=1;    
                dina<=16'b0000000000000001;
                led<=16'b0000000000000000;
                addra<=4'b0000;    
            end
        if(work==1'b1) begin
             if(addra!=4'b1111&&wea)begin
                  addra<=addra+4'b1;
                  dina<=(dina<<1)+16'b1;
             end
             else if(addra==4'b1111&&wea) begin
                  addra<=4'b0000;
                  wea<=0; 
                  read<=1;
             end
             if(read)begin
             ena<=0;
             read<=0;
             end
             if(~wea)begin 
                 if(cnt==32'd49)begin
                       ena<=1;
                     if(addra!=4'b1111)begin  
                         addra<=addra+4'b1;
                     end
                     led<=douta;
                 end 
                 else ena<=0;          
           end
      end
  end
end



endmodule