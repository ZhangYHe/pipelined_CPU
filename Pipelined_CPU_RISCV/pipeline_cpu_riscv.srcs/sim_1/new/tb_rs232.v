`timescale 1ns / 1ps

module tb_rs232();

    reg clk_50;
    reg rst_n;
    reg rx_en;
    reg tx_en;
    reg rx;
    reg [7:0] RX_DATA;
    reg [7:0] TX_DATA = 8'b1111_1111;

    wire tx;

    initial begin
        clk_50 = 1'b1;
        rst_n <= 1'b0;
        rx_en <= 1'b1;
        tx_en <= 1'b1;
        rx <= 1'b1;
        //  TX_DATA <= 8'd8;
        #20;
        rst_n <= 1'b1;
    end

    // ��������������
    initial begin
        #200
        rx_byte();
    end

    // 50MHzʱ��
    always #10 clk_50 = ~clk_50;

    
    // ����0-7��8������
    task rx_byte(); 
        integer j;
        for(j=0; j<8; j=j+1) 
            rx_bit(j);
    endtask

    // �������񣬷�����ʼλ��ֹͣλ���м��λ����
    task rx_bit(
        input [7:0] data
        );

        integer i;
        for(i=0; i<10; i=i+1) begin
            case(i)
                0: rx <= 1'b0;      //��ʼλ
                1: rx <= data[0];
                2: rx <= data[1];
                3: rx <= data[2];
                4: rx <= data[3];
                5: rx <= data[4];
                6: rx <= data[5];
                7: rx <= data[6];
                8: rx <= data[7];
                9: rx <= 1'b1;      //ֹͣλ
            endcase

            #(5208*20);             //����ʱ����
        end
    endtask

    rs232 rs232_inst(
        .clk_50 (clk_50 ), 
        .rst_n (rst_n ), 
        .rx (rx ), 
        .TX_DATA(TX_DATA),
        .RX_DATA(RX_DAtA),
        .tx (tx ) 
    );

 endmodule
