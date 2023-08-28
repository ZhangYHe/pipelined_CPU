`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/25 20:00:29
// Design Name: 
// Module Name: rs232
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


module rs232(
    input wire sys_clk , //ϵͳʱ��50MHz
    input wire sys_rst_n , //ȫ�ָ�λ
    input wire rx , //���ڽ�������
    input wire [7:0] TX_DATA,
//    input wire rx_en,
//    input wire tx_en,
    
    output wire [7:0] RX_DATA,
    output wire tx //���ڷ�������
    );
    
    ////
     //\* Parameter and Internal Signal \//
     ////
    
     //parameter define
     parameter UART_BPS = 14'd9600; //������
     parameter CLK_FREQ = 26'd50_000_000; //ʱ��Ƶ��
    
     //wire define
     //wire [7:0] RX_DATA;
     wire po_flag;
     //reg pi_flag = 1'b1;
     ////
     //\* Instantiation \//
     ////

     //------------------------uart_rx_inst------------------------
     uart_rx
     #(
     .UART_BPS (UART_BPS), //���ڲ�����
     .CLK_FREQ (CLK_FREQ) //ʱ��Ƶ��
     )
     uart_rx_inst
     (
     .sys_clk (sys_clk ), //input sys_clk
     .sys_rst_n (sys_rst_n ), //input sys_rst_n
     .rx (rx ), //input rx
    
     .RX_DATA (RX_DATA ), //output [7:0] RX_DATA
     .po_flag (po_flag ) //output po_flag
     );
    
     //------------------------uart_tx_inst------------------------
     uart_tx
     #(
     .UART_BPS (UART_BPS), //���ڲ�����
     .CLK_FREQ (CLK_FREQ) //ʱ��Ƶ��
     )
     uart_tx_inst
     (
     .sys_clk (sys_clk ), //input sys_clk
     .sys_rst_n (sys_rst_n ), //input sys_rst_n
     .TX_DATA (TX_DATA ), //input [7:0] TX_DATA
     .pi_flag (po_flag ), //input pi_flag   // ������
    
     .tx (tx ) //output tx
     );
    
endmodule