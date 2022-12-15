//CONTROL PATH TEST BENCH
module top_cu_tb;
//Declaration of wires and registers
wire rd_en_cu_tb;
wire wt_en_cu_tb;
reg rd_clk_cu_tb;
reg wt_clk_cu_tb;
reg full_cu_tb;
reg empty_cu_tb;
reg almost_full_cu_tb;
reg almost_empty_cu_tb;
reg push_on_full_error_cu_tb;
reg pop_on_empty_error_cu_tb;
reg rst_n_in_wt_cu_tb;
reg rst_n_in_rd_cu_tb;

//Mapping Design with testbench via name mapping
top_cu DUT(.rd_en_cu(rd_en_cu_tb),
		.wt_en_cu(wt_en_cu_tb),
		.rd_clk_cu(rd_clk_cu_tb),
		.wt_clk_cu(wt_clk_cu_tb),
		.full_cu(full_cu_tb),
		.empty_cu(empty_cu_tb),
		.almost_full_cu(almost_full_cu_tb),
		.almost_empty_cu(almost_empty_cu_tb),
		.push_on_full_error_cu(push_on_full_error_cu_tb),
		.pop_on_empty_error_cu(pop_on_empty_error_cu_tb),
		.rst_n_in_wt_cu(rst_n_in_wt_cu_tb),
		.rst_n_in_rd_cu(rst_n_in_rd_cu_tb));

//Write Clock Generation
initial
begin	wt_clk_cu_tb=0;
forever	#5	wt_clk_cu_tb=~wt_clk_cu_tb;
end
//Read Clock Generation
initial
begin	rd_clk_cu_tb=0;
forever #5	rd_clk_cu_tb=~rd_clk_cu_tb;
end

//Test cases
initial
begin
	//Initialise all Inputs
	rst_n_in_wt_cu_tb=1;	rst_n_in_rd_cu_tb=1;	full_cu_tb=0;			empty_cu_tb=0;
	almost_full_cu_tb=0;	almost_empty_cu_tb=0;	push_on_full_error_cu_tb=0;	pop_on_empty_error_cu_tb=0;

	//Asynchronous Reset Condition
#2	rst_n_in_wt_cu_tb=0;	rst_n_in_rd_cu_tb=0;
	//Disabling Reset
#10	rst_n_in_wt_cu_tb=1;	rst_n_in_rd_cu_tb=1;

								                                    // full	push_on_full_error	empty	pop_on_empty_error	wt_en	rd_en
								                                    //  0	        0			          0	          0			        1	    1
#10	empty_cu_tb=0;		pop_on_empty_error_cu_tb=1;	  //  0	        0			          0	          1			        1	    0
#10	empty_cu_tb=1;		pop_on_empty_error_cu_tb=0;	  //  0	        0			          1	          0			        1	    0
#10	full_cu_tb=0;		push_on_full_error_cu_tb=1;
	empty_cu_tb=0;		pop_on_empty_error_cu_tb=0;	    //  0	        1			          0	          0			        0	    1
#10	empty_cu_tb=0;		pop_on_empty_error_cu_tb=1;	  //  0	        1			          0	          1			        0	    0
#10	empty_cu_tb=1;		pop_on_empty_error_cu_tb=0;	  //  0	        1			          1	          0			        0	    0
#10	full_cu_tb=1;		push_on_full_error_cu_tb=0;
	empty_cu_tb=0;		pop_on_empty_error_cu_tb=0;	    //  1	        0			          0	          0			        0	    1	
#10	empty_cu_tb=0;		pop_on_empty_error_cu_tb=1;	  //  1	        0			          0	          1			        0	    0
#10	empty_cu_tb=1;		pop_on_empty_error_cu_tb=0;	  //  1	        0			          1	          0			        0	    0
end

initial
begin
//Monitoring Values
$monitor($time,"rst_n_wt=%b rst_n_rd=%b full=%b empty=%b almost_full=%b almost_empty=%b push_on_full_error=%b pop_on_empty_error=%b wt_en=%b rd_en=%b",rst_n_in_wt_cu_tb,rst_n_in_rd_cu_tb,full_cu_tb,empty_cu_tb,almost_full_cu_tb,almost_empty_cu_tb,push_on_full_error_cu_tb,pop_on_empty_error_cu_tb,wt_en_cu_tb,rd_en_cu_tb);
//Ending Simulation
#200	$finish;
end
endmodule
