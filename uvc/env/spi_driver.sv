class spi_driver extends uvm_driver #(transaction);
  `uvm_component_utils(spi_driver)
  
  virtual spi_if vif;
  transaction tr;
  logic [15:0] data; ////<- din , addr ->
  logic [7:0] datard;
  
  
  function new(input string path = "spi_driver", uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
 virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     tr = transaction::type_id::create("tr");
      
      if(!uvm_config_db#(virtual spi_if)::get(this,"","vif",vif))
      `uvm_error("drv","Unable to access Interface");
  endfunction
  
  
  
  ////////////////////reset task
  task reset_dut(); 
    begin
    vif.rst      <= 1'b1;  ///active high reset
    vif.miso     <= 1'b0;
    vif.cs       <= 1'b1;
   `uvm_info("DRV", "System Reset", UVM_MEDIUM);
    repeat(2) @(posedge vif.clk);
      vif.rst      <= 1'b0;  
    end
  endtask
  
  ///////////////////////write 
  task write_d();
  ////start of transaction
  vif.rst  <= 1'b0;
  vif.cs   <= 1'b0;
  vif.miso <= 1'b0;
  data     = {tr.din, tr.addr};
  `uvm_info("DRV", $sformatf("DATA WRITE addr : %0d din : %0d",tr.addr, tr.din), UVM_MEDIUM); 
  @(posedge vif.clk);
  vif.miso <= 1'b1;  ///write operation
  @(posedge vif.clk);
  
  for(int i = 0; i < 16 ; i++)
   begin
   vif.miso <= data[i];
   @(posedge vif.clk);
   end
  
  @(posedge vif.op_done);
  
  endtask 
  
 //////////////////read operation 
  task read_d();
  ////start of transaction
  vif.rst  <= 1'b0;
  vif.cs   <= 1'b0;
  vif.miso <= 1'b0;
  data     = {8'h00, tr.addr};
  @(posedge vif.clk);
  vif.miso <= 1'b0;  ///read operation
  @(posedge vif.clk);
  
  ////send addr
  for(int i = 0; i < 8 ; i++)
   begin
   vif.miso <= data[i];
   @(posedge vif.clk);
   end
   
   ///wait for data ready
  @(posedge vif.ready);
  
  ///sample output data
   for(int i = 0; i < 8 ; i++)
   begin
   @(posedge vif.clk);
   datard[i] = vif.mosi;
   end
   `uvm_info("DRV", $sformatf("DATA READ addr : %0d dout : %0d",tr.addr,datard), UVM_MEDIUM);  
  @(posedge vif.op_done);
  
  endtask 
  
  //////////////////////////
 
  
 
  virtual task run_phase(uvm_phase phase);
    forever begin
     
         seq_item_port.get_next_item(tr);
     
     
                   if(tr.op ==  rstdut)
                          begin
                          reset_dut();
                          end
 
                  else if(tr.op == writed)
                          begin
                          write_d();
                          end
                else if(tr.op ==  readd)
                          begin
					      read_d();
                          end
                          
       seq_item_port.item_done();
     
   end
  endtask
 
  
endclass