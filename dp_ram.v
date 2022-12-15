//DATA_PATH -> DUAL PORT RAM 
module dp_ram#(parameter data_width=4, //declaration of data bus width		
               parameter addr_width=4) //declaration of address bus width		
                //declaration of ports		
                (output [data_width-1:0]data_out_dp_ram,		
                 input [data_width-1:0]data_in_dp_ram,		
                 input rd_clk_dp_ram,		
                 input wt_clk_dp_ram,		
                 input wt_rst_n_dp_ram_in,		
                 input rd_rst_n_dp_ram_in,		
                 input rd_en_dp_ram,		
                 input wt_en_dp_ram,		
                 input [addr_width-1:0]wt_addr,		
                 input [addr_width-1:0]rd_addr);
  integer i;//temp register declaration for data out
  reg [data_width-1:0]data_out;//declaration of memory array
  reg [data_width-1:0]mem[(2**addr_width)-1:0];
//write operation
  always@(posedge wt_clk_dp_ram or negedge wt_rst_n_dp_ram_in)
    begin
      if(!wt_rst_n_dp_ram_in)				// clearing whole memory		
        for(i=0;i<(2**addr_width);i=i+1)			
          mem[i]<=0;
      else if(wt_en_dp_ram)	
        mem[wt_addr]<=data_in_dp_ram; //reads data_in and writes in wt_addr loacation		
      else
        mem[wt_addr]<=mem[wt_addr]; //memory reading will be in hold state
    end
//read operation
  always@(posedge rd_clk_dp_ram or negedge rd_rst_n_dp_ram_in)
    begin
      if(!rd_rst_n_dp_ram_in)	
        data_out <= 0;	
      else if(rd_en_dp_ram)
        data_out<=mem[rd_addr]; //writes data from rd_addr location on to data_out		
      else			
        data_out<=data_out; //data_out is in hold state until next rd_en_dp_ram is triggers
    end
  assign data_out_dp_ram=data_out; //assiging value to data_out_dp_ram from temp register
endmodule
