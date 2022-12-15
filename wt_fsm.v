//WRITE FSM
module wt_fsm #(parameter s0=0,
		parameter s1=1)
	       (output wt_en_fsm,
		input wt_clk_fsm,
		input full_fsm,
		input push_on_full_error_fsm,
		input rst_n_in_wt_fsm);
reg ps;
wire ns;
always@(posedge wt_clk_fsm or negedge rst_n_in_wt_fsm)
begin
	if(!rst_n_in_wt_fsm)	ps<=s0;
	else			ps<=ns;
end
assign wt_en_fsm = ps;	// if ps = s0 wt_en_fsm = 0 which is s0 else wt_en_fsm = 1 which is s1. So, simply wt_en_fsm=ps
assign ns=(!full_fsm && !push_on_full_error_fsm) ? s1: s0;
endmodule
