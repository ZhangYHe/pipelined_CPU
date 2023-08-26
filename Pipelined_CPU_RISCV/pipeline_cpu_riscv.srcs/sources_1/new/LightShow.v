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
        input clk,    //ʹ��ʱ���źţ�Ƶ��Ϊ50MHz
        input [3:0]data_1,    //����ֱ�������Ҫ�����5����
        input [3:0]data_2,
        input [3:0]data_3,
        input [3:0]data_4,
        input [3:0]data_5,
        output reg[7:0] o_px,    //������ʹ���źţ���ѡ�����ĸ��������ʾ
        output reg[6:0] o_led    //7λ��Ӧһ������ܵ��߸�����
    );
    
    reg[17:0] regN = 18'b0;    //���regN��;һ��
    reg[3:0] i_num;    //��������4������������Ҫ��ʾ����һ��
    always @(posedge clk)
        regN = regN+1;    //clkÿ��������regN�ͻ�+1 //�ٽ�Ϻ��濴
    
    always @(regN[17:15])    
    //clkΪ18λ������ȡ��17��18λ����1-16λ�����ڼ�ʱ������ʱ����Ҫ��2��16�η�
    // ����һ���ܶ��Ҷ����Ӿ������Ͱ���Ƶ�������ʱ�䣩��ʾ������ܲŸ��ģ�
    // ��λ��17~18λ������ȷ���ĸ������
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
                
    
    
    always @ (*)    //����7�����������ݵ�����
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

