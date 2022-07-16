`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/13 12:12:47
// Design Name: 
// Module Name: calculator_hex
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module calculator_hex(
    input wire clk_g,
    input wire rst,
    input wire button,
    input wire [2:0] func,
    input wire [7:0] num1,
    input wire [7:0] num2,
    output reg  [31:0] cal_result
    );
wire rst_n=~rst;
reg [31:0]   num;
reg button2;
reg cnt2_inc;
reg firstcaculate;
reg [31:0]  cnt2;
always @(posedge clk_g or negedge rst_n) begin
    if(~rst_n)begin
        cal_result<=8'h00000000;
        num<=8'h00000000;
        firstcaculate<=1'b0;
        cnt2<=1'b0;
        cnt2_inc<=1'b0;
        button2<=1'b0;
    end
    else begin
             if(button)begin
                //cnt2_inc<=1'b1;
                button2<=1'b1;
            end
//             if(cnt2_inc)begin
//                 if(cnt2==32'd1)begin
//                    cnt2_inc<=1'b0;
//                    button2<=1'b1;
//                    cnt2<=1'b0;
//                    end
//                    else begin
//                    cnt2<=cnt2+32'd1;
//                    end
//                end
             if(button2) begin
               if(firstcaculate==1'b0)begin
                    firstcaculate<=1'b1;
                    case (func)
                    3'b000      : begin
                                    num<=num1+num2;
                                    cal_result<=num1+num2;
                                    button2<=1'b0;
                                end
                    3'b001      : begin
                                    num<=num1-num2;
                                    cal_result<=num1-num2;
                                    button2<=1'b0;
                                end
                    3'b010      : begin
                                    num<=num1*num2;
                                    cal_result<=num1*num2;
                                    button2<=1'b0;
                                end
                    3'b011      : begin
                                    num<=num1/num2;
                                    cal_result<=num1/num2;
                                    button2<=1'b0;           
                                end
                    3'b100      : begin
                                    num<=num1%num2;
                                    cal_result<=num1%num2;
                                     button2<=1'b0;
                                end
                    3'b101      : begin
                                    num<=num2*num2;
                                    cal_result<=num2*num2;
                                    button2<=1'b0;
                                end 
                    default     : begin
                                    num<=num;
                                    cal_result<=cal_result;
                                   button2<=1'b0;
                                    end
                    endcase
                end
                else begin
                    case (func)
                    3'b000      : begin
                                    num<=num+num2;
                                    cal_result<=num+num2;
                                    button2<=1'b0;
                                end
                    3'b001      : begin
                                    num<=num-num2;
                                    cal_result<=num-num2;
                                    button2<=1'b0;
                                end
                    3'b010      : begin
                                    num<=num*num2;
                                    cal_result<=num*num2;
                                    button2<=1'b0;
                                end
                    3'b011      : begin
                                    num<=num/num2;
                                    cal_result<=num/num2;
                                    button2<=1'b0;
                                end
                    3'b100      : begin
                                    num<=num%num2;
                                    cal_result<=num%num2;
                                    button2<=1'b0;    
                                end
                    3'b101      : begin
                                    num<=num*num;
                                    cal_result<=num*num;
                                    button2<=1'b0;
                                end 
                    default     : begin
                                    num<=num;
                                    cal_result<=cal_result;
                                    button2<=1'b0;
                                    end
                    endcase
                end  
            end
            else begin
            num<=num;
            cal_result<=cal_result;
            end
         
    end
end

endmodule
