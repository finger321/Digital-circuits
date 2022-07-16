`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/13 12:17:42
// Design Name: 
// Module Name: calculator_display
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
module calculator_display(
    input wire clk_g,
    input wire rst,
    input wire button,
    input wire [31:0] cal_result,
    output reg [7:0] led_en,
    output reg led_ca,
    output reg led_cb,
    output reg led_cc,
    output reg led_cd,
    output reg led_ce,
    output reg led_cf,
    output reg led_cg,
    output wire led_dp
);
reg dp;
assign led_dp=dp;
reg [31:0]cnt;
reg cnt_inc;
reg  work;
reg [2:0]	data;
reg flag;
reg [3:0]dig_data_temp;
reg [7:0]dig_data;
wire rst_n=~rst;
wire cnt_end=cnt_inc&(cnt==32'd1);
always @(posedge clk_g or negedge rst_n) begin
    if(~rst_n)    cnt_inc<=1'b0;
    else if(button) begin
        cnt_inc<=1'b1;
        work<=1'b1;
    end 
end
always @(posedge clk_g or negedge rst_n) begin
    if(~rst_n)begin
        cnt<=32'b0;
        flag<=1'b1;
        led_en<=8'b11111111;
    end 
    else if(cnt_end)begin
        cnt<=32'b0;
        if(flag)begin
            led_en<=8'b11111110;
            flag<=1'b0;
        end
        else begin
            led_en<={led_en[6:0],led_en[7]}; 
        end
    end 
    else if(cnt_inc)    cnt<=cnt+32'b1;
end
always @(*) begin
         case(led_en)
        8'b11111110:    dig_data_temp<=cal_result[3:0];
        8'b11111101:    dig_data_temp<=cal_result[7:4];
        8'b11111011:    dig_data_temp<=cal_result[11:8];
        8'b11110111:    dig_data_temp<=cal_result[15:12];
        8'b11101111:    dig_data_temp<=cal_result[19:16];
        8'b11011111:    dig_data_temp<=cal_result[23:20];
        8'b10111111:    dig_data_temp<=cal_result[27:24];
        8'b01111111:    dig_data_temp<=cal_result[31:28];
        default     : dig_data_temp<=4'b0000;
        endcase   
end
always @(*) begin
    case(dig_data_temp)
        0: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b00000011;
        1: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b10011111;
        2: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b00100101;
        3: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b00001101;
        4:  {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b10011001;
        5: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b01001001;
        6: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b01000001;
        7: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b00011111;
        8: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b00000001;
        9: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b00011001;
        10: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b00010001;
        11: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b11000001;
        12: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b11100101;
        13:{led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b10000101;
        14: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b01100001;
        15: {led_ca,led_cb,led_cc,led_cd,led_ce,led_cf,led_cg,dp}<=8'b01110001;
        default:;
    endcase
end
endmodule
