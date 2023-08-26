`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/26 16:12:05
// Design Name: 
// Module Name: LightShow
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

module LightShow(
        input clk,    //使用时钟信号，频率为50MHz
        input rst_n,
        input [3:0]data_1,    //这里分别定义了想要输入的5个数
        input [3:0]data_2,
        input [3:0]data_3,
        input [3:0]data_4,
        input [3:0]data_5,
        output [7:0] o_px,    //这里是使能信号，即选择是哪个数码管显示
        output [6:0] o_led_1,    //7位对应一个数码管的七个灯泡
        output [6:0] o_led_2    //7位对应一个数码管的七个灯泡
    );
    

    parameter   C_COUNTER_NUM = 100000;    
    //parameter   C_COUNTER_NUM = 10; //计数器峰值
    
    reg  [3:0]  R_temp;             //当前显示的4-bit数据寄存器                
    reg  [7:0]  R_px_temp;          //段选信号寄存器
    reg  [32:0] R_counter;          //计数器寄存器
    
    //wire [7:0]  W_show_num;         
    
    //assign W_show_num = I_show_num;
    
    always@(posedge clk, negedge rst_n)
    begin
        if(!rst_n)          
        begin       //复位处理
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


//     reg[17:0] regN = 18'b0;    //结合regN用途一起看
//     reg[3:0] i_num;    //用来储存4个输入数中需要显示的那一个
//     always @(posedge clk)
//         regN = regN+1;    //clk每到上升沿regN就会+1 //再结合后面看
    
//     always @(regN[17:15])    
//     //clk为18位，这里取第17，18位，即1-16位是用于计时，所以时钟需要跳2的16次方
//     // （是一个很短且对于视觉残留和板子频率有益的时间）显示的数码管才更改，
//     // 进位到17~18位就用于确定哪个数码管
//     begin
//         case (regN[17:15])
//         3'b000:begin
//                 o_px<=8'b00000001;
//                 i_num<=data_1;
//                 end
//         3'b001:begin
//                 o_px<=8'b00000010;
//                 i_num<=data_2;  
//                 end      
//         3'b010:begin
//                 o_px<=8'b00000100;
//                 i_num<=data_3;
//                 end  
//         3'b011:begin 
//                 o_px<=8'b00001000;
//                 i_num<=data_4;
//                 end
//         3'b100:begin 
//                 o_px<=8'b00010000;
//                 i_num<=data_5;
//                 end
//         default:begin
//                 o_px<=8'b00100000;
//                 i_num<= 0 ;
//                 end
//        endcase
//     end
                
    
    
//     always @ (*)    //控制7个数码管里灯泡的亮灭
//         begin
//             case(i_num)
//             4'h0:o_led_1 = 7'b111_1110;
//             4'h1:o_led_1 = 7'b011_0000;
//             4'h2:o_led_1 = 7'b110_1101;
//             4'h3:o_led_1 = 7'b111_1001;
//             4'h4:o_led_1 = 7'b011_0011;
//             4'h5:o_led_1 = 7'b101_1011;
//             4'h6:o_led_1 = 7'b101_1111;
//             4'h7:o_led_1 = 7'b111_0000;
//             4'h8:o_led_1 = 7'b111_1111;
//             4'h9:o_led_1 = 7'b111_1011;
//             default:   
//                  o_led_1 = 7'b000_0000;
//             endcase
//          end  

endmodule

