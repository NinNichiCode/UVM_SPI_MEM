class reset_dut_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(reset_dut_seq)
  
  transaction tr;
 
  function new(string name = "reset_dut_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)
      begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        start_item(tr);
        assert(tr.randomize());
        tr.op = rstdut;
        finish_item(tr);
      end

 
  endtask
  
 
endclass