//DUAL PORT RAM TEST BENCH
`timescale 1ns/1ns
module dp_ram_tb;

//declaration of data bus and address bus parameters
parameter data_width_tb=4;
parameter addr_width_tb=4;

//Declaration of Design ports as reg and wires
wire [data_width_tb-1:0]data_out_dp_ram_tb;
reg [data_width_tb-1:0]data_in_dp_ram_tb;
reg rd_clk_dp_ram_tb;
reg wt_clk_dp_ram_tb;
reg wt_rst_n_dp_ram_tb;
reg rd_rst_n_dp_ram_tb;
reg rd_en_dp_ram_tb;
reg wt_en_dp_ram_tb;
reg [addr_width_tb-1:0]wt_addr_tb;
reg [addr_width_tb-1:0]rd_addr_tb;

//mapping to Design
dp_ram DUT(.data_out_dp_ram(data_out_dp_ram_tb),.data_in_dp_ram(data_in_dp_ram_tb),.rd_clk_dp_ram(rd_clk_dp_ram_tb),.wt_clk_dp_ram(wt_clk_dp_ram_tb),.rd_en_dp_ram(rd_en_dp_ram_tb),.wt_en_dp_ram(wt_en_dp_ram_tb),.wt_addr(wt_addr_tb),.rd_addr(rd_addr_tb),.wt_rst_n_dp_ram(wt_rst_n_dp_ram_tb),.rd_rst_n_dp_ram(rd_rst_n_dp_ram));

//write clock generation
initial
begin
	wt_clk_dp_ram_tb=0;
	forever #5 wt_clk_dp_ram_tb=~wt_clk_dp_ram_tb;
end

//read clock generation
initial
begin
	rd_clk_dp_ram_tb=0;
	forever #5 rd_clk_dp_ram_tb=~rd_clk_dp_ram_tb;
end

//initialising reg values
initial
begin
rd_en_dp_ram_tb=0;
wt_en_dp_ram_tb=0;
wt_rst_n_dp_ram_tb = 0;
rd_rst_n_dp_ram_tb =0; 
wt_addr_tb=0;
rd_addr_tb=0;
end

//generating test cases
initial
begin
#2	wt_rst_n_dp_ram_tb = 1;	rd_rst_n_dp_ram_tb = 1;	wt_en_dp_ram_tb=1;	wt_addr_tb=4'b0110;	data_in_dp_ram_tb=4'b1111; //write data in location
#10	wt_en_dp_ram_tb=0;	rd_en_dp_ram_tb=1;	rd_addr_tb=4'b0110; //reading data from that location
end
initial
begin
$monitor($time,"wt_en=%b wt_addr=%d data_in=%d rd_en=%b rd_addr=%d data_out=%d",wt_en_dp_ram_tb,wt_addr_tb,data_in_dp_ram_tb,rd_en_dp_ram_tb,rd_addr_tb,data_out_dp_ram_tb);
#20	$finish;
end
endmodule
