//FIRST IN FIRST OUT DATA PATH TEST BENCH
`timescale 1ns/1ns
module fifo_dp_top_tb;

//parameters declaration
parameter data_width_tb=4;
parameter addr_width_tb=4;

//Declaration of Design ports as reg and wires
wire	[data_width_tb-1:0]data_out_dp_tb;
wire	full_st_dp_tb;
wire	empty_st_dp_tb;
wire	almost_full_dp_tb;
wire	almost_empty_dp_tb;
wire	pop_on_empty_error_dp_tb;
wire	push_on_full_error_dp_tb;
reg	[data_width_tb-1:0]data_in_dp_tb;
reg	rd_clk_dp_tb;
reg	wt_clk_dp_tb;
reg	rd_en_dp_tb;
reg	wt_en_dp_tb;
reg	rst_n_in_wt_dp_tb;
reg	rst_n_in_rd_dp_tb;

//additional varaiables
integer i;

//Mapping DUT with design
fifo_dp_top DUT(.data_out_dp(data_out_dp_tb),
                .full_st_dp(full_st_dp_tb),
                .empty_st_dp(empty_st_dp_tb),
                .data_in_dp(data_in_dp_tb),
                .rd_clk_dp(rd_clk_dp_tb),
                .wt_clk_dp(wt_clk_dp_tb),
                .rd_en_dp(rd_en_dp_tb),
                .wt_en_dp(wt_en_dp_tb),
                .rst_n_in_wt_dp(rst_n_in_wt_dp_tb),
                .rst_n_in_rd_dp(rst_n_in_rd_dp_tb),
                .almost_full_dp(almost_full_dp_tb),
                .almost_empty_dp(almost_empty_dp_tb),
                .pop_on_empty_error_dp(pop_on_empty_error_dp_tb),
                .push_on_full_error_dp(push_on_full_error_dp_tb));

//clock generation
initial
begin
	rd_clk_dp_tb=0;
	rd_en_dp_tb=0;
	wt_en_dp_tb=0;
forever	#5	rd_clk_dp_tb=~rd_clk_dp_tb;
end
initial
begin
		wt_clk_dp_tb=0;
forever	#5	wt_clk_dp_tb=~wt_clk_dp_tb;
end

//test cases generation
//reset condition
initial
begin
	rst_n_in_wt_dp_tb=1;
	rst_n_in_rd_dp_tb=1;
#2	rst_n_in_wt_dp_tb=0;
	rst_n_in_rd_dp_tb=0;	
#10	rst_n_in_wt_dp_tb=1;
	rst_n_in_rd_dp_tb=1;
end

//write operation
initial
begin
	wt_en_dp_tb=0;
#12	wt_en_dp_tb=1;
	data_in_dp_tb=0;
	for(i=1;i<16;i=i+1)
	begin
	#10	data_in_dp_tb=i;
	end
end

//read operation
initial
begin
	rd_en_dp_tb=0;
//#22	rd_en_dp_tb=1;
#20	rd_en_dp_tb=1;
end

//monitoring values
initial
begin
	$monitor($time," reset_wt=%b reset_rd=%b read enable=%b write enable=%b data_in=%d data_out=%d full=%b empty=%b rd addr=%d wt addr=%d almost_full=%b almost_empty=%b push_on_full_error=%b pop_on_empty_error=%b"/* memory=%p"*/,rst_n_in_wt_dp_tb,rst_n_in_rd_dp_tb,rd_en_dp_tb,wt_en_dp_tb,data_in_dp_tb,data_out_dp_tb,full_st_dp_tb,empty_st_dp_tb,DUT.rd_addr_dp,DUT.wt_addr_dp,almost_full_dp_tb,almost_empty_dp_tb,push_on_full_error_dp_tb,pop_on_empty_error_dp_tb,/*DUT.g4.mem*/);
#200	$finish;
end
endmodule
