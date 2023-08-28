`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/26 22:03:50
// Design Name: 
// Module Name: tb_top
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


module tb_top(

    );
    reg clk;
    reg rst_n;
    wire [7:0] o_px;
    wire [6:0] o_led_1;
    wire [6:0] o_led_2;
    
    reg rx;
    reg [7:0] RX_DATA;
    reg [7:0] TX_DATA = 8'b1111_1111;

 //wire define
    wire tx;

 ////
 //\* Main Code \//
 ////


 //��������rx_byte
 initial begin
 #200
 rx_byte();
 end

 //��������rx_byte�������������rx_bit���񣬷���8�����ݣ��ֱ�Ϊ0~7
 task rx_byte(); //��Ϊ����Ҫ�ⲿ���ݲ���������������û������
 integer j;
 for(j=0; j<8; j=j+1) //����8��rx_bit����ÿ�η��͵�ֵ��0�仯7
 rx_bit(j);
 endtask

 //��������rx_bit��ÿ�η��͵�������10λ��data��ֵ�ֱ�Ϊ0��7��j��ֵ���ݽ���
 task rx_bit(
 input [7:0] data
 );
 integer i;
 for(i=0; i<10; i=i+1) begin
 case(i)
 0: rx <= 1'b0;
 1: rx <= data[0];
 2: rx <= data[1];
 3: rx <= data[2];
 4: rx <= data[3];
 5: rx <= data[4];
 6: rx <= data[5];
 7: rx <= data[6];
 8: rx <= data[7];
 9: rx <= 1'b1;
 endcase
 #(5208*20); //ÿ����1λ������ʱ5208��ʱ������
 end
 endtask
    
   top top( .clk (clk ),
            .rst_n (rst_n ),
            .rx (rx),
            .o_px(o_px),
            .o_led_1(o_led_1),
            .o_led_2(o_led_2),
            .tx (tx)
            );

    initial begin

        rst_n = 1;
        clk = 0;
        rx = 1'b1;
        
        #30 rst_n = 0;

        #30 rst_n = 1;

    end

    always
        #5 clk = ~clk;

endmodule
