//WRITE ADDRESS GENERATOR TEST BENCH
module wt_addr_gen_tb;

//Declaration of parameter
parameter addr_width_wt_gen_tb=4;

//Declaration of Design ports as reg and wires
wire [addr_width_wt_gen_tb:0]wt_addr_gen_tb;
reg wt_en_gen_tb;
reg wt_clk_gen_tb;
reg rst_n_wt_gen_in_tb;

//Mapping Test bench to Design
wt_addr_gen DUT(.wt_addr_gen(wt_addr_gen_tb),.wt_en_gen(wt_en_gen_tb),.wt_clk_gen(wt_clk_gen_tb),.rst_n_wt_gen_in(rst_n_wt_gen_in_tb));

//clock generation
initial
begin
wt_clk_gen_tb=0;
wt_en_gen_tb=0;
rst_n_wt_gen_in_tb=1'b0;
forever #5 wt_clk_gen_tb=~wt_clk_gen_tb;
end

initial
begin
//	rst_n_wt_gen_in_tb=1;	//initial condtion
#7	rst_n_wt_gen_in_tb=1;	wt_en_gen_tb=1;	//reset condtion and read_enable is asserted
	//at time=5ns, posedge(clk) is observed and counter is reseted//
#10	/*rst_n_wt_gen_in_tb=1;*/ wt_en_gen_tb=1'b1;	//reset signal is asserted
	//at time=15ns, posedge(clk) is observed and counter starts incrementing//
#90	rst_n_wt_gen_in_tb=0;	//after some cycles of exection reset condition is applied (not mandatory)
end
initial
begin
$monitor($time,"rst=%b wt_clk_gen_tb=%b wt_en=%b add=%d add1=%d",rst_n_wt_gen_in_tb,wt_clk_gen_tb,wt_en_gen_tb,DUT.wt_addr_2,wt_addr_gen_tb);
#150 $finish;
end
endmodule
