`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/27 15:32:50
// Design Name: 
// Module Name: tb_rs232
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


module tb_rs232();

////
//\* Parameter and Internal Signal \//
////

//reg define
reg sys_clk;
reg sys_rst_n;
reg rx_en;
reg tx_en;
reg rx;
reg [7:0] RX_DATA;
reg [7:0] TX_DATA = 8'b1111_1111;

 //wire define
 wire tx;

 ////
 //\* Main Code \//
 ////

 //��ʼ��ϵͳʱ�ӡ�ȫ�ָ�λ�������ź�
 initial begin
 sys_clk = 1'b1;
 sys_rst_n <= 1'b0;
 rx_en <= 1'b1;
 tx_en <= 1'b1;
 rx <= 1'b1;
//  TX_DATA <= 8'd8;
 #20;
 sys_rst_n <= 1'b1;
 end

 //��������rx_byte
 initial begin
 #200
 rx_byte();
 end

 //sys_clk:ÿ10ns��ƽ��תһ�Σ�����һ��50MHz��ʱ���ź�
 always #10 sys_clk = ~sys_clk;

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

 ////
 //\* Instantiation \//
 ////

 //------------------------rs232_inst------------------------
 rs232 rs232_inst(
 .sys_clk (sys_clk ), //input sys_clk
 .sys_rst_n (sys_rst_n ), //input sys_rst_n
 .rx (rx ), //input rx
 .TX_DATA(TX_DATA),
// .rx_en(rx_en),
// .tx_en(tx_en), 
 .RX_DATA(RX_DAtA),
 .tx (tx ) //output tx
 );

 endmodule
