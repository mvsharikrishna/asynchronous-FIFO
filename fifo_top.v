//FIRST IN FIRST OUT TOP MODULE
module fifo_top#(parameter addr_width=4,
		 parameter data_width=4)
		(output [data_width-1:0]data_out,
		 output full_out,
		 output empty_out,
		 output almost_full_out,
		 output almost_empty_out,
		 output push_on_full_error_out,
		 output pop_on_empty_error_out,
		 input [data_width-1:0]data_in,
		 input rd_clk_in,
		 input wt_clk_in,
		 input rst_n_wt_in,
		 input rst_n_rd_in);
wire wt_en, rd_en;

//control Unit Initialisation
top_cu g1(.rd_en_cu(rd_en),
		.wt_en_cu(wt_en),
		.rd_clk_cu(rd_clk_in),
		.wt_clk_cu(wt_clk_in),
		.full_cu(full_out),
		.empty_cu(empty_out),
		.almost_full_cu(almost_full_out),
		.almost_empty_cu(almost_empty_out),
		.push_on_full_error_cu(push_on_full_error_out),
		.pop_on_empty_error_cu(pop_on_empty_error_out),
		.rst_n_in_wt_cu(rst_n_wt_in),
		.rst_n_in_rd_cu(rst_n_rd_in));

//Datapath Initialisation
fifo_dp_top g2(.data_out_dp(data_out),
		.full_st_dp(full_out),
		.empty_st_dp(empty_out),
		.almost_full_dp(almost_full_out),
		.almost_empty_dp(almost_empty_out),
		.pop_on_empty_error_dp(push_on_full_error_out),
		.push_on_full_error_dp(pop_on_empty_error_out),
		.data_in_dp(data_in),
		.rd_clk_dp(rd_clk_in),
		.wt_clk_dp(wt_clk_in),
		.rd_en_dp(rd_en),
		.wt_en_dp(wt_en),
		.rst_n_in_wt_dp(rst_n_wt_in),
		.rst_n_in_rd_dp(rst_n_rd_in));
endmodule
