`timescale 1ns / 1ps


module rs232(
    input wire clk_50 ,        //ϵͳʱ��50MHz
    input wire rst_n ,      
    input wire rx ,             //���ڴ��н�������
    input wire [7:0] TX_DATA,   //�����͵�����
    
    output wire [7:0] RX_DATA,  //���յ�������
    output wire tx              //���ڴ��з�������
    );

    parameter UART_BPS = 14'd9600;         //������
    parameter CLK_FREQ = 26'd50_000_000;   //ʱ��Ƶ��
    

    wire po_flag;              //��ת����������Ч��־λ


    uart_rx
    #(
        .UART_BPS (UART_BPS),         
        .CLK_FREQ (CLK_FREQ)         
    )
    uart_rx_inst
    (
        .clk_50 (clk_50 ), 
        .rst_n (rst_n ), 
        .rx (rx ), 
        .RX_DATA (RX_DATA ), 
        .po_flag (po_flag ) 
    );
    
     
    uart_tx
    #(
        .UART_BPS (UART_BPS), 
        .CLK_FREQ (CLK_FREQ) 
    )
    uart_tx_inst
    (
        .clk_50 (clk_50 ), 
        .rst_n (rst_n ), 
        .TX_DATA (TX_DATA ), 
        .pi_flag (po_flag ),      //���ڽ���������Ч��ʼ����  
        .tx (tx ) 
    );
    
endmodule