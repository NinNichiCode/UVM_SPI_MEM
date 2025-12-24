
`include "uvm_macros.svh"
import uvm_pkg::*;
import spi_pkg::*;

module top;
    
  spi_if vif();
  
  spi_mem dut (.clk(vif.clk), .rst(vif.rst), .cs(vif.cs), .miso(vif.miso), .ready(vif.ready), .mosi(vif.mosi), .op_done(vif.op_done));
  
  initial begin
    vif.clk <= 0;
  end
 
  always #10 vif.clk <= ~vif.clk;
  
  
  initial begin
    uvm_config_db#(virtual spi_if)::set(null, "*", "vif", vif);
    run_test("");
   end
  
endmodule