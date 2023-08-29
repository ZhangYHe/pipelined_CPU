`timescale 1ns / 1ps


module uart_rx
// paramater list
#(
    parameter UART_BPS = 'd9600,        //串口波特率
    parameter CLK_FREQ = 'd50_000_000   //串口时钟频率
)
(
    input wire clk_50 ,               
    input wire rst_n ,
    input wire rx ,                     //串口串行接收数据
    output reg [7:0] RX_DATA ,          //rx串转并
    output reg po_flag                  //串转并后数据有效标志位
);

    localparam BAUD_CNT_MAX = CLK_FREQ/UART_BPS ;
    
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
    
    //两级寄存器数据同步消除亚稳态
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            rx_reg1 <= 1'b1;
        else
            rx_reg1 <= rx;
    
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            rx_reg2 <= 1'b1;
        else
            rx_reg2 <= rx_reg1;
    
    //下降沿检测
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            rx_reg3 <= 1'b1;
        else
            rx_reg3 <= rx_reg2;
    
    //检测到下降沿start_nedge产生一个时钟的高电平
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            start_nedge <= 1'b0;
        else if((~rx_reg2) && (rx_reg3))
            start_nedge <= 1'b1;
        else
            start_nedge <= 1'b0;
    
    //接收数据工作使能信号work_en
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            work_en <= 1'b0;
        else if(start_nedge == 1'b1)
            work_en <= 1'b1;
        else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
            work_en <= 1'b0;
    
    //波特率计数器
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
                baud_cnt <= 13'b0;
        else if((baud_cnt == BAUD_CNT_MAX - 1) || (work_en == 1'b0))
                baud_cnt <= 13'b0;
        else if(work_en == 1'b1)
                baud_cnt <= baud_cnt + 1'b1;
    
    //bit_flag标志计数到中间数，采样数据最稳定
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            bit_flag <= 1'b0;
        else if(baud_cnt == BAUD_CNT_MAX/2 - 1)
            bit_flag <= 1'b1;
        else
            bit_flag <= 1'b0;
    
    //串行有效数据接受个数标志位
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            bit_cnt <= 4'b0;
        else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
            bit_cnt <= 4'b0;
        else if(bit_flag ==1'b1)
            bit_cnt <= bit_cnt + 1'b1;
    
     //串行数据移位转并行
     always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            rx_data <= 8'b0;
        else if((bit_cnt >= 4'd1)&&(bit_cnt <= 4'd8)&&(bit_flag == 1'b1))
            rx_data <= {rx_reg3, rx_data[7:1]};
    
     //输入数据移位完成时标记位rx_flag
     always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            rx_flag <= 1'b0;
        else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
            rx_flag <= 1'b1;
        else
            rx_flag <= 1'b0;
    
     //rx串转并后的数据RX_DATA
     always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            RX_DATA <= 8'b0;
        else if(rx_flag == 1'b1)
            RX_DATA <= rx_data;
    
     //输出数据有效标志po_flag
     always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            po_flag <= 1'b0;
        else
            po_flag <= rx_flag;

 endmodule
