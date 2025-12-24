
class spi_env extends uvm_env;
`uvm_component_utils(spi_env)
 
function new(input string inst = "spi_env", uvm_component c);
super.new(inst,c);
endfunction
 
spi_agent agent;
spi_scoreboard scb;
spi_coverage cov;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  agent = spi_agent::type_id::create("agent",this);
  scb = spi_scoreboard::type_id::create("scb", this);
  cov = spi_coverage::type_id::create("cov", this);
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  agent.mon.item_send_port.connect(scb.item_recv_imp);
  agent.mon.item_send_port.connect(cov.analysis_export);
endfunction
 
endclass