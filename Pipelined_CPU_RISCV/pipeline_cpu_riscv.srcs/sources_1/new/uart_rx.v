`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/27 15:30:44
// Design Name: 
// Module Name: uart_rx
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


module uart_rx
#(
parameter UART_BPS = 'd9600, //���ڲ�����
parameter CLK_FREQ = 'd50_000_000 //ʱ��Ƶ��
)
(
input wire sys_clk , //ϵͳʱ��50MHz
input wire sys_rst_n , //ȫ�ָ�λ
input wire rx , //���ڽ�������
output reg [7:0] RX_DATA , //��ת�����8bit����
output reg po_flag //��ת�����������Ч��־�ź�
);

//localparam define
localparam BAUD_CNT_MAX = CLK_FREQ/UART_BPS ;
//reg define
reg rx_reg1 ;
reg rx_reg2 ;
reg rx_reg3 ;
reg start_nedge ;
reg work_en ;
reg [12:0] baud_cnt ;
reg bit_flag ;
reg [3:0] bit_cnt ;
reg [7:0] rx_data ;
reg rx_flag ;

//���������Ĵ�����������ͬ����������������̬
//rx_reg1:��һ���Ĵ������Ĵ�������״̬��λΪ1
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
rx_reg1 <= 1'b1;
else
rx_reg1 <= rx;
//rx_reg2:�ڶ����Ĵ������Ĵ�������״̬��λΪ1
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
rx_reg2 <= 1'b1;
else
rx_reg2 <= rx_reg1;
//rx_reg3:�������Ĵ����͵ڶ����Ĵ�����ͬ�����½��ؼ��
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
rx_reg3 <= 1'b1;
else
rx_reg3 <= rx_reg2;
//start_nedge:��⵽�½���ʱstart_nedge����һ��ʱ�ӵĸߵ�ƽ
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
start_nedge <= 1'b0;
else if((~rx_reg2) && (rx_reg3))
start_nedge <= 1'b1;
else
start_nedge <= 1'b0;
//work_en:�������ݹ���ʹ���ź�
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
work_en <= 1'b0;
else if(start_nedge == 1'b1)
work_en <= 1'b1;
else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
work_en <= 1'b0;
//baud_cnt:�����ʼ�������������0������5207
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
baud_cnt <= 13'b0;
else if((baud_cnt == BAUD_CNT_MAX - 1) || (work_en == 1'b0))
baud_cnt <= 13'b0;
else if(work_en == 1'b1)
baud_cnt <= baud_cnt + 1'b1;
//bit_flag:��baud_cnt�������������м���ʱ�������������ȶ���
//��ʱ����һ����־�źű�ʾ���ݿ��Ա�ȡ��
always@(posedge sys_clk or negedge sys_rst_n)
if(sys_rst_n == 1'b0)
bit_flag <= 1'b0;
else if(baud_cnt == BAUD_CNT_MAX/2 - 1)
bit_flag <= 1'b1;
else
bit_flag <= 1'b0;
//bit_cnt:��Ч���ݸ�������������8����Ч���ݣ�������ʼλ��ֹͣλ��
//��������ɺ����������
always@(posedge sys_clk or negedge sys_rst_n)
 if(sys_rst_n == 1'b0)
 bit_cnt <= 4'b0;
 else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
 bit_cnt <= 4'b0;
 else if(bit_flag ==1'b1)
 bit_cnt <= bit_cnt + 1'b1;

 //rx_data:�������ݽ�����λ
 always@(posedge sys_clk or negedge sys_rst_n)
 if(sys_rst_n == 1'b0)
 rx_data <= 8'b0;
 else if((bit_cnt >= 4'd1)&&(bit_cnt <= 4'd8)&&(bit_flag == 1'b1))
 rx_data <= {rx_reg3, rx_data[7:1]};

 //rx_flag:����������λ���ʱrx_flag����һ��ʱ�ӵĸߵ�ƽ
 always@(posedge sys_clk or negedge sys_rst_n)
 if(sys_rst_n == 1'b0)
 rx_flag <= 1'b0;
 else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
 rx_flag <= 1'b1;
 else
 rx_flag <= 1'b0;

 //RX_DATA:���������8λ��Ч����
 always@(posedge sys_clk or negedge sys_rst_n)
 if(sys_rst_n == 1'b0)
 RX_DATA <= 8'b0;
 else if(rx_flag == 1'b1)
 RX_DATA <= rx_data;

 //po_flag:���������Ч��־����rx_flag�Ӻ�һ��ʱ�����ڣ�Ϊ�˺�po_dataͬ����
 always@(posedge sys_clk or negedge sys_rst_n)
 if(sys_rst_n == 1'b0)
 po_flag <= 1'b0;
 else
 po_flag <= rx_flag;

 endmodule
