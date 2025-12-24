class write_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(write_seq)
  
  transaction tr;
 
  function new(string name = "write_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(100)
      begin
        tr = transaction::type_id::create("tr");
        tr.addr_c.constraint_mode(1);
        start_item(tr);
        assert(tr.randomize());
        tr.op = writed;
        finish_item(tr);
      end
  endtask
endclass