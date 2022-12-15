//READ FSM
module rd_fsm #(parameter s0=0,
		parameter s1=1)
	       (output rd_en_fsm,
		input rd_clk_fsm,
		input empty_fsm,
		input pop_on_empty_error_fsm,
		input rst_n_in_rd_fsm);
reg ps;
wire ns;
always@(posedge rd_clk_fsm or negedge rst_n_in_rd_fsm)
begin
	if(!rst_n_in_rd_fsm)	ps<=s0;
	else			ps<=ns;
end
assign rd_en_fsm = ps;	// if ps = s0 rd_en_fsm = 0 which is s0 else rd_en_fsm = 1 which is s1. So, simply rd_en_fsm=ps
assign ns=(!empty_fsm && !pop_on_empty_error_fsm) ? s1: s0;
endmodule
