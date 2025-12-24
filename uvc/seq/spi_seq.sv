class spi_seq extends uvm_sequence#(transaction);
  `uvm_object_utils(spi_seq)
  
  transaction tr;

  function new(string name = "spi_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    //  Reset 
    `uvm_info("SEQ", "Starting Reset Sequence", UVM_LOW)
    `uvm_do_with(tr, {op == rstdut;})

    // Cover cp_din and cross_op_data
    `uvm_do_with(tr, {op == writed; addr == 0; din == 8'h00;})
    `uvm_do_with(tr, {op == writed; addr == 31; din == 8'hFF;})

    // Cover cp_dout
    `uvm_do_with(tr, {op == readd; addr == 0;})
    `uvm_do_with(tr, {op == readd; addr == 31;})

    // Cover invalid_range
    `uvm_do_with(tr, {op == writed; addr == 100; din == 8'hAA;})
    `uvm_do_with(tr, {op == readd; addr == 200;})

    //  RANDOM STRESS 
    repeat(100) begin
      tr = transaction::type_id::create("tr");
      start_item(tr);
      if (!tr.randomize() with {
        addr inside {[0:31]}; 
        din  inside {[8'h01:8'hFE]}; 
      }) begin
        `uvm_error("SEQ", "Randomization failed")
      end
      tr.op = (tr.addr % 2 == 0) ? writed : readd;
      finish_item(tr);

        //  idle -> idle ---
       repeat(5) begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        tr.cs = 1; 
        tr.op = readd; 
        finish_item(tr);
       end

    end

    `uvm_info("SEQ", "Finished SPI Sequence", UVM_LOW)
  endtask
endclass