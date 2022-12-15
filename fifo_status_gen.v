//STATUS SIGNAL GENERATOR
module status_gen#(parameter addr_width=4)			(input [addr_width:0]rd_addr_st_gen, //read address bus to status generator			 
                                                 input [addr_width:0]wt_addr_st_gen, //write address bus to status generator			 
                                                 output full_st_gen, // full status signal from status generator			 
                                                 output empty_st_gen, //empty status signal from status generator			 
                                                 output almost_full_st_gen, //almost full status signal from status generator			 
                                                 output almost_empty_st_gen, //almost empty status signal from status generator			 
                                                 output push_on_full_error_st_gen, //push on full error status signal from status generator			 
                                                 output pop_on_empty_error_st_gen); //pop on error error signal from status generator
parameter full_threshold=5;parameter empty_threshold=5;integer mem_depth=(2**addr_width);
//Conditon for Assertion of full status signal
  assign full_st_gen=((wt_addr_st_gen[addr_width] != rd_addr_st_gen[addr_width]) && (wt_addr_st_gen[addr_width-1:0]==rd_addr_st_gen[addr_width-1:0]));
//condition for Assertion of empty status signal
  assign empty_st_gen=(wt_addr_st_gen == rd_addr_st_gen);
//condition for Assertion of almost full status signal
  assign almost_full_st_gen = (wt_addr_st_gen[addr_width-1:0] > rd_addr_st_gen[addr_width-1:0]) ? (((mem_depth + rd_addr_st_gen[addr_width-1:0]) - wt_addr_st_gen[addr_width-1:0]) <= full_threshold) : (wt_addr_st_gen[addr_width-1:0] < rd_addr_st_gen[addr_width-1:0] ? ((rd_addr_st_gen[addr_width-1:0] - wt_addr_st_gen[addr_width-1:0]) <= full_threshold) : 0);
  //assign almost_full_st_gen=(wt_addr_st_gen>rd_addr_st_gen) ? ((mem_depth - wt_addr_st_gen)+rd_addr_st_gen)<= full_threshold : (wt_addr_st_gen < rd_addr_st_gen)? ((rd_addr_st_gen-wt_addr_st_gen)<= full_threshold) : 0;
//condition for Assertion of almost empty status signal
  assign almost_empty_st_gen = (rd_addr_st_gen[addr_width-1:0] >= wt_addr_st_gen[addr_width-1:0]) ? (((mem_depth + wt_addr_st_gen[addr_width-1:0]) - rd_addr_st_gen[addr_width-1:0]) <= empty_threshold) : ((wt_addr_st_gen[addr_width-1:0] - rd_addr_st_gen[addr_width-1:0]) <= empty_threshold);
//conditon for Assertion of push_on_full_error
  assign push_on_full_error_st_gen = ((wt_addr_st_gen[addr_width] != rd_addr_st_gen[addr_width]) && (wt_addr_st_gen[addr_width-1:0]>rd_addr_st_gen[addr_width-1:0]));
//condtion for Assertion of pop_on_empty_error
  assign pop_on_empty_error_st_gen = ((wt_addr_st_gen[addr_width] == rd_addr_st_gen[addr_width]) && (wt_addr_st_gen[addr_width-1:0] < rd_addr_st_gen[addr_width-1:0]));endmodule
