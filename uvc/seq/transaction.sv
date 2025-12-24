
typedef enum bit [1:0]   {readd = 0, writed = 1, rstdut = 2} oper_mode;
 
 
class transaction extends uvm_sequence_item;
    rand bit [7:0] addr;
    rand bit [7:0] din;
         bit [7:0] dout;
    rand oper_mode   op;
         bit rst;
    rand bit miso;
         bit cs;     
         bit done;
         bit err;
         bit ready;
         bit mosi;
         
//   constraint addr_c { addr <= 31;}
 constraint addr_c { 
    addr dist { [0:31] :/ 90, [32:255] :/ 10 }; 
}
        `uvm_object_utils_begin(transaction)
        `uvm_field_int (addr,UVM_ALL_ON)
        `uvm_field_int (din,UVM_ALL_ON)
        `uvm_field_int (dout,UVM_ALL_ON)
        `uvm_field_int (ready,UVM_ALL_ON)
        `uvm_field_int (rst,UVM_ALL_ON)
        `uvm_field_int (done,UVM_ALL_ON)
        `uvm_field_int (miso,UVM_ALL_ON)
        `uvm_field_int (mosi,UVM_ALL_ON)
        `uvm_field_int (cs,UVM_ALL_ON)
        `uvm_field_int (err,UVM_ALL_ON)
        `uvm_field_enum(oper_mode, op, UVM_DEFAULT)
        `uvm_object_utils_end
  
 
  function new(string name = "transaction");
    super.new(name);
  endfunction
 
endclass : transaction