`timescale 1ns / 1ps


module uart_rx
// paramater list
#(
    parameter UART_BPS = 'd9600,        //���ڲ�����
    parameter CLK_FREQ = 'd50_000_000   //����ʱ��Ƶ��
)
(
    input wire clk_50 ,               
    input wire rst_n ,
    input wire rx ,                     //���ڴ��н�������
    output reg [7:0] RX_DATA ,          //rx��ת��
    output reg po_flag                  //��ת����������Ч��־λ
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
    
    //�����Ĵ�������ͬ����������̬
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
    
    //�½��ؼ��
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            rx_reg3 <= 1'b1;
        else
            rx_reg3 <= rx_reg2;
    
    //��⵽�½���start_nedge����һ��ʱ�ӵĸߵ�ƽ
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            start_nedge <= 1'b0;
        else if((~rx_reg2) && (rx_reg3))
            start_nedge <= 1'b1;
        else
            start_nedge <= 1'b0;
    
    //�������ݹ���ʹ���ź�work_en
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            work_en <= 1'b0;
        else if(start_nedge == 1'b1)
            work_en <= 1'b1;
        else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
            work_en <= 1'b0;
    
    //�����ʼ�����
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
                baud_cnt <= 13'b0;
        else if((baud_cnt == BAUD_CNT_MAX - 1) || (work_en == 1'b0))
                baud_cnt <= 13'b0;
        else if(work_en == 1'b1)
                baud_cnt <= baud_cnt + 1'b1;
    
    //bit_flag��־�������м����������������ȶ�
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            bit_flag <= 1'b0;
        else if(baud_cnt == BAUD_CNT_MAX/2 - 1)
            bit_flag <= 1'b1;
        else
            bit_flag <= 1'b0;
    
    //������Ч���ݽ��ܸ�����־λ
    always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            bit_cnt <= 4'b0;
        else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
            bit_cnt <= 4'b0;
        else if(bit_flag ==1'b1)
            bit_cnt <= bit_cnt + 1'b1;
    
     //����������λת����
     always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            rx_data <= 8'b0;
        else if((bit_cnt >= 4'd1)&&(bit_cnt <= 4'd8)&&(bit_flag == 1'b1))
            rx_data <= {rx_reg3, rx_data[7:1]};
    
     //����������λ���ʱ���λrx_flag
     always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            rx_flag <= 1'b0;
        else if((bit_cnt == 4'd8) && (bit_flag == 1'b1))
            rx_flag <= 1'b1;
        else
            rx_flag <= 1'b0;
    
     //rx��ת���������RX_DATA
     always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            RX_DATA <= 8'b0;
        else if(rx_flag == 1'b1)
            RX_DATA <= rx_data;
    
     //���������Ч��־po_flag
     always@(posedge clk_50 or negedge rst_n)
        if(rst_n == 1'b0)
            po_flag <= 1'b0;
        else
            po_flag <= rx_flag;

 endmodule
