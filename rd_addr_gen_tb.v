//READ ADDRESS GENERATOR TEST BENCH
module rd_addr_gen_tb;
//Declaration of parameter
  parameter addr_width_rd_gen_tb=4;
//Declaration of Design ports as reg and wires
  wire [addr_width_rd_gen_tb:0]rd_addr_gen_tb;
  reg rd_en_gen_tb;
  reg rd_clk_gen_tb;
  reg rst_n_rd_gen_in_tb;
//Mapping Test bench to Design
  rd_addr_gen2 DUT(.rd_addr_gen(rd_addr_gen_tb),
                   .rd_en_gen(rd_en_gen_tb),
                   .rd_clk_gen(rd_clk_gen_tb),
                   .rst_n_rd_gen_in(rst_n_rd_gen_in_tb));
//clock generation
  initial
    begin
      rd_clk_gen_tb=0;
      rd_en_gen_tb=0;
      forever #5 rd_clk_gen_tb=~rd_clk_gen_tb;
    end
initial
  begin	rst_n_rd_gen_in_tb=1;	//initial condtion
    #2	rst_n_rd_gen_in_tb=0;	rd_en_gen_tb=1;	//reset condtion and read_enable is asserted	
    //at time=5ns, posedge(clk) is observed and counter is reseted//
    #10	rst_n_rd_gen_in_tb=1;	//reset signal is asserted	
    //at time=15ns, posedge(clk) is observed and counter starts incrementing//
    #90	rst_n_rd_gen_in_tb=0;	//after some cycles of exection reset condition is applied (not mandatory)
    end
  initial
    begin
      $monitor($time,"rst=%b rd_en=%b add1=%d add=%d",rst_n_rd_gen_in_tb,rd_en_gen_tb,DUT.rd_addr,rd_addr_gen_tb);
#150 $finish;
endendmodule
