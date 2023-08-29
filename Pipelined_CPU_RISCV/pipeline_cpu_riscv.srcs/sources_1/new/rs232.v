`timescale 1ns / 1ps


module rs232(
    input wire clk_50 ,        //系统时钟50MHz
    input wire rst_n ,      
    input wire rx ,             //串口串行接收数据
    input wire [7:0] TX_DATA,   //待发送的数据
    
    output wire [7:0] RX_DATA,  //接收到的数据
    output wire tx              //串口串行发送数据
    );

    parameter UART_BPS = 14'd9600;         //波特率
    parameter CLK_FREQ = 26'd50_000_000;   //时钟频率
    

    wire po_flag;              //串转并后数据有效标志位


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
        .pi_flag (po_flag ),      //串口接收数据有效后开始发送  
        .tx (tx ) 
    );
    
endmodule