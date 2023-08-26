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
        input [3:0]data_1,    //这里分别定义了想要输入的5个数
        input [3:0]data_2,
        input [3:0]data_3,
        input [3:0]data_4,
        input [3:0]data_5,
        output reg[7:0] o_px,    //这里是使能信号，即选择是哪个数码管显示
        output reg[6:0] o_led    //7位对应一个数码管的七个灯泡
    );
    
    reg[17:0] regN = 18'b0;    //结合regN用途一起看
    reg[3:0] i_num;    //用来储存4个输入数中需要显示的那一个
    always @(posedge clk)
        regN = regN+1;    //clk每到上升沿regN就会+1 //再结合后面看
    
    always @(regN[17:15])    
    //clk为18位，这里取第17，18位，即1-16位是用于计时，所以时钟需要跳2的16次方
    // （是一个很短且对于视觉残留和板子频率有益的时间）显示的数码管才更改，
    // 进位到17~18位就用于确定哪个数码管
    begin
        case (regN[17:15])
        3'b000:begin
                o_px<=8'b00000001;
                i_num<=data_1;
                end
        3'b001:begin
                o_px<=8'b00000010;
                i_num<=data_2;  
                end      
        3'b010:begin
                o_px<=8'b00000100;
                i_num<=data_3;
                end  
        3'b011:begin 
                o_px<=8'b00001000;
                i_num<=data_4;
                end
        3'b100:begin 
                o_px<=8'b00010000;
                i_num<=data_5;
                end
        default:begin
                o_px<=8'b00100000;
                i_num<= 0 ;
                end
       endcase
    end
                
    
    
    always @ (*)    //控制7个数码管里灯泡的亮灭
        begin
            case(i_num)
            4'h0:o_led = 7'b111_1110;
            4'h1:o_led = 7'b011_0000;
            4'h2:o_led = 7'b110_1101;
            4'h3:o_led = 7'b111_1001;
            4'h4:o_led = 7'b011_0011;
            4'h5:o_led = 7'b101_1011;
            4'h6:o_led = 7'b101_1111;
            4'h7:o_led = 7'b111_0000;
            4'h8:o_led = 7'b111_1111;
            4'h9:o_led = 7'b111_1011;
            default:   
                 o_led = 7'b000_0000;
            endcase
         end  

endmodule

