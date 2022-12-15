//CONTROL PATH
module top_cu(output rd_en_cu,
		output wt_en_cu,
		input rd_clk_cu,
		input wt_clk_cu,
		input full_cu,
		input empty_cu,
		input almost_full_cu,
		input almost_empty_cu,
		input push_on_full_error_cu,
		input pop_on_empty_error_cu,
		input rst_n_in_wt_cu,
		input rst_n_in_rd_cu);
rd_fsm G1(.rd_en_fsm(rd_en_cu),.rd_clk_fsm(rd_clk_cu),.empty_fsm(empty_cu),.pop_on_empty_error_fsm(pop_on_empty_error_cu),.rst_n_in_rd_fsm(rst_n_in_rd_cu));

wt_fsm G2(.wt_en_fsm(wt_en_cu),.wt_clk_fsm(wt_clk_cu),.full_fsm(full_cu),.push_on_full_error_fsm(push_on_full_error_cu),.rst_n_in_wt_fsm(rst_n_in_wt_cu));

endmodule
