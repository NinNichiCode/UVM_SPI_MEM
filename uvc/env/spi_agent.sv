                 
class spi_agent extends uvm_agent;
`uvm_component_utils(spi_agent)
  
  spi_config cfg;
 
function new(input string inst = "spi_agent", uvm_component parent = null);
super.new(inst,parent);
endfunction
 
 spi_driver drv;
 uvm_sequencer#(transaction) seqr;
 spi_monitor mon;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
   cfg =  spi_config::type_id::create("cfg"); 
   mon = spi_monitor::type_id::create("mon",this);
  
  if(cfg.is_active == UVM_ACTIVE)
   begin   
    drv = spi_driver::type_id::create("drv",this);
    seqr = uvm_sequencer#(transaction)::type_id::create("seqr", this);
   end
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  if(cfg.is_active == UVM_ACTIVE) begin  
    drv.seq_item_port.connect(seqr.seq_item_export);
  end
endfunction
 
endclass
 