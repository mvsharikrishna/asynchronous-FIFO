//FIRST IN FIRST OUT TEST BENCH
module fifo_top_tb;
parameter data_width_tb=4;

wire [data_width_tb-1:0]data_out_tb;
wire full_out_tb;
wire empty_out_tb;
wire almost_full_out_tb;
wire almost_empty_out_tb;
wire push_on_full_error_out_tb;
wire pop_on_empty_error_out_tb;
reg [data_width_tb-1:0]data_in_tb;
reg rd_clk_in_tb;
reg wt_clk_in_tb;
reg rst_n_wt_in_tb;
reg rst_n_rd_in_tb;
integer i;
//Mapping Design with Test Bench via Name Mapping
fifo_top DUT(.data_out(data_out_tb),
		.full_out(full_out_tb),
		.empty_out(empty_out_tb),
		.almost_full_out(almost_full_out_tb),
		.almost_empty_out(almost_empty_out_tb),
		.push_on_full_error_out(push_on_full_error_out_tb),
		.pop_on_empty_error_out(pop_on_empty_error_out_tb),
		.data_in(data_in_tb),
		.rd_clk_in(rd_clk_in_tb),
		.wt_clk_in(wt_clk_in_tb),
		.rst_n_wt_in(rst_n_wt_in_tb),
		.rst_n_rd_in(rst_n_rd_in_tb));


//Clock Generation
//Write Clock Generation
initial
begin	wt_clk_in_tb=1;
forever	#5	wt_clk_in_tb=~wt_clk_in_tb;
end
//Read Clock Generation
initial
begin	rd_clk_in_tb=0;
forever #5	rd_clk_in_tb=~rd_clk_in_tb;
end

//test cases generation
//reset condition
initial
begin
	rst_n_wt_in_tb=1;
	rst_n_rd_in_tb=1;
#2	rst_n_wt_in_tb=0;
	rst_n_rd_in_tb=0;	
#5	rst_n_wt_in_tb=1;
	rst_n_rd_in_tb=1;
end

//Data_in
initial
begin		
	for(i=0;i<20;i=i+1)
	begin
	#9	data_in_tb=i;
	end
end

//Monitoring Data
initial
begin
$monitor($time,"wt_clk=%b write_rst=%b read_rst=%b wt_en=%d rd_en=%d wt_addrs=%d data_in=%d dp_ram_data_out=%d rd_addrs=%d rd_clk=%b data_out=%d full=%b empty=%b almost_full=%b almost_empty=%b push_on_full_error=%b pop_on_empty_error=%b mem=%p",wt_clk_in_tb,rst_n_wt_in_tb,rst_n_rd_in_tb,DUT.wt_en,DUT.rd_en,DUT.g2.wt_addr_dp,data_in_tb,DUT.g2.g4.data_out,DUT.g2.rd_addr_dp,rd_clk_in_tb,data_out_tb,full_out_tb,empty_out_tb,almost_full_out_tb,almost_empty_out_tb,push_on_full_error_out_tb,pop_on_empty_error_out_tb,DUT.g2.g4.mem);
#200 $finish;
end
endmodule
