
class spi_scoreboard extends uvm_scoreboard;
`uvm_component_utils(spi_scoreboard)
 
  uvm_analysis_imp#(transaction,spi_scoreboard) item_recv_imp;
  bit [31:0] arr[32] = '{default:0};
  bit [31:0] addr    = 0;
  bit [31:0] data_rd = 0;
 
 
 
    function new(input string inst = "spi_scoreboard", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_recv_imp = new("item_recv_imp", this);
    endfunction
    
    
  virtual function void write(transaction tr);
    
    if (tr.addr > 31) begin
        `uvm_info("SCB", $sformatf("Ignore out-of-bound address: %0d", tr.addr), UVM_LOW)
        return; 
    end
    if(tr.op == rstdut)
              begin
                `uvm_info("SCO", "SYSTEM RESET DETECTED", UVM_NONE);
              end  
    else if (tr.op == writed)
      begin
          arr[tr.addr] = tr.din;
          `uvm_info("SCO", $sformatf("DATA WRITE OP  addr:%0d, wdata:%0d arr_wr:%0d",tr.addr,tr.din,  arr[tr.addr]), UVM_NONE);
      end
 
    else if (tr.op == readd)
                begin
                  data_rd = arr[tr.addr];
                  if (data_rd == tr.dout)
                    `uvm_info("SCO", $sformatf("DATA MATCHED : addr:%0d, rdata:%0d",tr.addr,tr.dout), UVM_NONE)
                         else
                     `uvm_error("SCO",$sformatf("TEST FAILED : addr:%0d, rdata:%0d data_rd_arr:%0d",tr.addr,tr.dout,data_rd)) 
                end
     
  
    $display("----------------------------------------------------------------");
    endfunction
 
endclass
 