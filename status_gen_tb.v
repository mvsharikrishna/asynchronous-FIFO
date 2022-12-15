//STATUS SIGNAL GENERATOR TEST BENCH
module status_gen_tb;

//parameter declaration of address bus width
parameter addr_width_tb=4;

//Declaration of Design ports as reg and wires
reg [addr_width_tb:0]rd_addr_st_gen_tb;
reg [addr_width_tb:0]wt_addr_st_gen_tb;
wire full_st_gen_tb;
wire empty_st_gen_tb;
wire almost_full_st_gen_tb;
wire almost_empty_st_gen_tb;
wire pop_on_empty_error_st_gen_tb;
wire push_on_full_error_st_gen_tb;

//mapping DUT to Design
status_gen DUT(.rd_addr_st_gen(rd_addr_st_gen_tb),.wt_addr_st_gen(wt_addr_st_gen_tb),.full_st_gen(full_st_gen_tb),.empty_st_gen(empty_st_gen_tb),.almost_full_st_gen(almost_full_st_gen_tb),.almost_empty_st_gen(almost_empty_st_gen_tb),.pop_on_empty_error_st_gen(pop_on_empty_error_st_gen_tb),.push_on_full_error_st_gen(push_on_full_error_st_gen_tb));

//Test cases generation
initial
begin
	rd_addr_st_gen_tb=5'b0_0000;	wt_addr_st_gen_tb=5'b0_0000; //empty status check at 0th location
#5	rd_addr_st_gen_tb=5'b0_0000;	wt_addr_st_gen_tb=5'b1_0000; //full status check at 0th location
#5	rd_addr_st_gen_tb=5'b0_0000;	wt_addr_st_gen_tb=5'b1_0010;
#5	rd_addr_st_gen_tb=5'b0_0001;	wt_addr_st_gen_tb=5'b0_0001; //empty status check at some other location
#5	rd_addr_st_gen_tb=5'b0_1001;	wt_addr_st_gen_tb=5'b1_1001; //full status check at some other location
	rd_addr_st_gen_tb=5'b0_0001;	wt_addr_st_gen_tb=5'b0_1100; //almost full status check --> rd_addr < wt_addr
#5	rd_addr_st_gen_tb=5'b0_0001;	wt_addr_st_gen_tb=5'b0_1110; //almost full status check --> rd_addr == rd_addr
#5	rd_addr_st_gen_tb=5'b0_0110;	wt_addr_st_gen_tb=5'b0_0001; //almost full status check --> rd_addr > wt_addr
#5	rd_addr_st_gen_tb=5'b0_1010;	wt_addr_st_gen_tb=5'b0_0000; //almost empty status check --> rd_addr > wt_addr
#5	rd_addr_st_gen_tb=5'b0_0000;	wt_addr_st_gen_tb=5'b0_0000; //almost empty status check --> rd_addr == wt_addr
#5	rd_addr_st_gen_tb=5'b0_0001;	wt_addr_st_gen_tb=5'b1_0101; //almost empty status check --> rd_addr < wt_addr
#5	rd_addr_st_gen_tb=5'b0_0001;	wt_addr_st_gen_tb=5'b0_0000; //pop on empty error status check at 0th location
#5	rd_addr_st_gen_tb=5'b0_0000;	wt_addr_st_gen_tb=5'b1_0001; //push on full error status check at 0th location
#5	rd_addr_st_gen_tb=5'b0_0010;	wt_addr_st_gen_tb=5'b0_0001; //pop on empty error status check at some other location
#5	rd_addr_st_gen_tb=5'b0_1001;	wt_addr_st_gen_tb=5'b1_1010; //push on full error status check at some other location


end

//monitoring values
initial
begin
$monitor("wt_addr=%d rd_addr=%d full_status=%b empty_status=%b alomst_full=%b almost_empty=%b pop_on_empty_error=%b push_on_full_error=%b",wt_addr_st_gen_tb,rd_addr_st_gen_tb,full_st_gen_tb,empty_st_gen_tb,almost_full_st_gen_tb,almost_empty_st_gen_tb,pop_on_empty_error_st_gen_tb,push_on_full_error_st_gen_tb);
#80 $finish;
end
endmodule
