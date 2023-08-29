`timescale 1ns / 1ps


module LightShow(
    input clk,             
    input rst_n,
    input [3:0]data_1,      //待显示的5个数
    input [3:0]data_2,
    input [3:0]data_3,
    input [3:0]data_4,
    input [3:0]data_5,
    
    output [7:0] o_px,      //数码管使能信号
    output [6:0] o_led_1,   //后四位数码管段选信号
    output [6:0] o_led_2    //前四位数码管段选信号
);
    

    parameter   C_COUNTER_NUM = 500000;     // 轮流显示数字
    
    reg  [3:0]  R_temp;                     //当前显示的4-bit数据寄存器                
    reg  [7:0]  R_px_temp;                  //段选信号寄存器
    reg  [32:0] R_counter;                  //计数器寄存器
    
    
    // 轮流显示数字
    always@(posedge clk, negedge rst_n)
    begin
        if(!rst_n)          
        begin       //复位
            R_px_temp <= 8'b0000_0001;
            R_temp <= data_1;
            R_counter <= 0;
        end
        else if(R_px_temp == 8'b0000_0001 && R_counter >= C_COUNTER_NUM)
        begin       
            R_temp <= data_2;
            R_px_temp <= 8'b0000_0010;
            R_counter <= 0;
        end
        else if(R_px_temp == 8'b0000_0010 && R_counter >= C_COUNTER_NUM)
        begin       
            R_temp <= data_3;
            R_px_temp <= 8'b0000_0100;
            R_counter <= 0;
        end
        else if(R_px_temp == 8'b0000_0100 && R_counter >= C_COUNTER_NUM)
        begin       
            R_temp <= data_4;
            R_px_temp <= 8'b0000_1000;
            R_counter <= 0;
        end
        else if(R_px_temp == 8'b0000_1000 && R_counter >= C_COUNTER_NUM)
        begin       
            R_temp <= data_5;
            R_px_temp <= 8'b0001_0000;
            R_counter <= 0;
        end
        else if(R_px_temp == 8'b0001_0000 && R_counter >= C_COUNTER_NUM)
        begin       
            R_temp <= data_1;
            R_px_temp <= 8'b0000_0001;
            R_counter <= 0;
        end
        else
        begin
            R_counter <= (R_counter + 1);
        end
    end
    
    // 数码管段选信号
    assign o_led_1[0] = (R_temp == 4'b0000||R_temp == 4'b0001||R_temp == 4'b0111
                            ||R_temp == 4'b1100)?0:1;
    assign o_led_1[1] = (R_temp == 4'b0001||R_temp == 4'b0010||R_temp == 4'b0011
                            ||R_temp == 4'b0111||R_temp == 4'b1101)?0:1;
    assign o_led_1[2] = (R_temp == 4'b0001||R_temp == 4'b0011||R_temp == 4'b0100
                            ||R_temp == 4'b0101||R_temp == 4'b0111||R_temp == 4'b1001)?0:1;
    assign o_led_1[3] = (R_temp == 4'b0001||R_temp == 4'b0100||R_temp == 4'b0111
                            ||R_temp == 4'b1010||R_temp == 4'b1111)?0:1;
    assign o_led_1[4] = (R_temp == 4'b0010||R_temp == 4'b1100||R_temp == 4'b1110
                            ||R_temp == 4'b1111)?0:1;
    assign o_led_1[5] = (R_temp == 4'b0101||R_temp == 4'b0110||R_temp == 4'b1011
                            ||R_temp == 4'b1100||R_temp == 4'b1110||R_temp == 4'b1111)?0:1;
    assign o_led_1[6] = (R_temp == 4'b0001||R_temp == 4'b0100||R_temp == 4'b1011
                            ||R_temp == 4'b1101)?0:1;
                            
    assign o_led_2[0] = (R_temp == 4'b0000||R_temp == 4'b0001||R_temp == 4'b0111
                            ||R_temp == 4'b1100)?0:1;
    assign o_led_2[1] = (R_temp == 4'b0001||R_temp == 4'b0010||R_temp == 4'b0011
                            ||R_temp == 4'b0111||R_temp == 4'b1101)?0:1;
    assign o_led_2[2] = (R_temp == 4'b0001||R_temp == 4'b0011||R_temp == 4'b0100
                            ||R_temp == 4'b0101||R_temp == 4'b0111||R_temp == 4'b1001)?0:1;
    assign o_led_2[3] = (R_temp == 4'b0001||R_temp == 4'b0100||R_temp == 4'b0111
                            ||R_temp == 4'b1010||R_temp == 4'b1111)?0:1;
    assign o_led_2[4] = (R_temp == 4'b0010||R_temp == 4'b1100||R_temp == 4'b1110
                            ||R_temp == 4'b1111)?0:1;
    assign o_led_2[5] = (R_temp == 4'b0101||R_temp == 4'b0110||R_temp == 4'b1011
                            ||R_temp == 4'b1100||R_temp == 4'b1110||R_temp == 4'b1111)?0:1;
    assign o_led_2[6] = (R_temp == 4'b0001||R_temp == 4'b0100||R_temp == 4'b1011
                            ||R_temp == 4'b1101)?0:1;

    assign o_px = R_px_temp;   

endmodule
