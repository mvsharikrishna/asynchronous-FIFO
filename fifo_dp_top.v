 //FIRST IN FIRST OUT DATA PATH
module fifo_dp_top#(parameter data_width=4, //declaration of data bus width		
                    parameter addr_width=4) //declaration of address bus width
                   (output	[data_width-1:0]data_out_dp,		 
                    output	full_st_dp,		 
                    output	empty_st_dp,		 
                    output almost_full_dp,		 
                    output almost_empty_dp,		 
                    output pop_on_empty_error_dp,		 
                    output push_on_full_error_dp,		 
                    input	[data_width-1:0]data_in_dp,		 
                    input	rd_clk_dp,		 
                    input	wt_clk_dp,		 
                    input	rd_en_dp,		 
                    input	wt_en_dp,		 
                    input	rst_n_in_wt_dp,		 
                    input	rst_n_in_rd_dp);
//declaration of address buses as wires
 wire [addr_width:0]rd_addr_dp;
 wire [addr_width:0]wt_addr_dp;
//instantation of address generators (Naming mapping)
 wt_addr_gen g1(.wt_en_gen(wt_en_dp),.wt_clk_gen(wt_clk_dp),.rst_n_wt_gen_in(rst_n_in_wt_dp),.wt_addr_gen(wt_addr_dp));
 rd_addr_gen g2(.rd_en_gen(rd_en_dp),.rd_clk_gen(rd_clk_dp),.rst_n_rd_gen_in(rst_n_in_rd_dp),.rd_addr_gen(rd_addr_dp));
//Status signal generator mapping
 status_gen g3(.rd_addr_st_gen(rd_addr_dp),.wt_addr_st_gen(wt_addr_dp),.full_st_gen(full_st_dp),.empty_st_gen(empty_st_dp),.almost_full_st_gen(almost_full_dp),.almost_empty_st_gen(almost_empty_dp),.pop_on_empty_error_st_gen(pop_on_empty_error_dp),.push_on_full_error_st_gen(push_on_full_error_dp));
//dual port RAM mapping
 dp_ram g4(.data_in_dp_ram(data_in_dp),.rd_clk_dp_ram(rd_clk_dp),.wt_clk_dp_ram(wt_clk_dp),.rd_en_dp_ram(rd_en_dp),.wt_en_dp_ram(wt_en_dp),.rd_addr(rd_addr_dp[addr_width-1:0]),.wt_addr(wt_addr_dp[addr_width-1:0]),.data_out_dp_ram(data_out_dp),.wt_rst_n_dp_ram_in(rst_n_in_wt_dp),.rd_rst_n_dp_ram_in(rst_n_in_rd_dp));
endmodule
