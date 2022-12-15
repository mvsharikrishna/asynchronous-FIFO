//READ ADDRESS GENERATOR
module rd_addr_gen#(parameter addr_width_rd_gen=4)			
                   (output [addr_width_rd_gen:0]rd_addr_gen,			 
                    input rd_en_gen,			 
                    input rd_clk_gen,			 
                    input rst_n_rd_gen_in);
  reg [addr_width_rd_gen:0]rd_addr1;
  wire [addr_width_rd_gen:0]rd_addr2;
  always@(posedge rd_clk_gen, negedge rst_n_rd_gen_in)	
    //Squential part
    begin	
      if(!rst_n_rd_gen_in)	
        rd_addr1<=0; //reset	
      else				
        rd_addr1<=rd_addr2;	//Hold State
    end
  //Combinational Part
  assign	rd_addr2=rd_en_gen?rd_addr1+1:rd_addr1;		//A Multiplexer that allows incremented o/p or same o/p based on write enable
  assign rd_addr_gen=rd_addr1;
endmodule
