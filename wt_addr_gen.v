//WRITE ADDRESS GENERATOR
module wt_addr_gen#(parameter addr_width_wt_gen=4)			
                   (output [addr_width_wt_gen:0]wt_addr_gen,			 
                   input wt_en_gen,			 
                   input wt_clk_gen,			 
                   input rst_n_wt_gen_in);
reg [addr_width_wt_gen:0]wt_addr1;
wire [addr_width_wt_gen:0]wt_addr_2;
always@(posedge wt_clk_gen, negedge rst_n_wt_gen_in)	
//Squential part
  begin
    if(!rst_n_wt_gen_in)	
      wt_addr1<=0; //reset	
    else
      wt_addr1<=wt_addr_2;	//Hold State
end
//Combinational Part
assign wt_addr_2=wt_en_gen?wt_addr1+1:wt_addr1;		//A Multiplexer that allows incremented o/p or same o/p based on write enable
assign wt_addr_gen=wt_addr1;
endmodule
