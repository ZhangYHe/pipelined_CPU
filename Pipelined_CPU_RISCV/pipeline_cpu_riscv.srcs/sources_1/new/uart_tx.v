`timescale 1ns / 1ps


module uart_tx
// paramater list
#(
    parameter UART_BPS = 'd9600,        //串口波特率
    parameter CLK_FREQ = 'd50_000_000   //串口时钟频率
)
(
    input wire clk_50 , 
    input wire rst_n , 
    input wire [7:0] TX_DATA ,          //串口并行发送数据
    input wire pi_flag ,                //并行数据有效标志信号
    
    output reg tx                      //串口串行发送数据
 );

    localparam BAUD_CNT_MAX = CLK_FREQ/UART_BPS ;

    reg [12:0] baud_cnt;                   //波特率计数器
    reg bit_flag;                          //bit_flag标志计数到中间数，采样数据最稳定
    reg [3:0] bit_cnt ;                    //数据位数个数计数，包含起始位和停止位
    reg work_en ;                          //接收数据工作使能信号work_en

    //接收数据工作使能信号work_en
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            work_en <= 1'b0;
        else if(pi_flag == 1'b1)
            work_en <= 1'b1;
        else if((bit_flag == 1'b1) && (bit_cnt == 4'd9))
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
        else if(baud_cnt == 13'd1)
            bit_flag <= 1'b1;
        else
            bit_flag <= 1'b0;

    //数据位数个数计数，包含起始位和停止位
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            bit_cnt <= 4'b0;
        else if((bit_flag == 1'b1) && (bit_cnt == 4'd9))
            bit_cnt <= 4'b0;
        else if((bit_flag == 1'b1) && (work_en == 1'b1))
            bit_cnt <= bit_cnt + 1'b1;

    //bit_flag标志计数到中间数，采样数据最稳定
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            tx <= 1'b1; //空闲状态时为高电平
        else if(bit_flag == 1'b1)
            case(bit_cnt)
                0 : tx <= 1'b0;
                1 : tx <= TX_DATA[0];
                2 : tx <= TX_DATA[1];
                3 : tx <= TX_DATA[2];
                4 : tx <= TX_DATA[3];
                5 : tx <= TX_DATA[4];
                6 : tx <= TX_DATA[5];
                7 : tx <= TX_DATA[6];
                8 : tx <= TX_DATA[7];
                9 : tx <= 1'b1;
                default : tx <= 1'b1;
            endcase

 endmodule
