class wr_bulk_rd_bulk_test extends base_test;
    `uvm_component_utils(wr_bulk_rd_bulk_test)
    
    function new(input string inst = "wr_bulk_rd_bulk_test", uvm_component c);
        super.new(inst,c);
    endfunction
    
    wr_bulk_rd_bulk_seq seq;
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq  = wr_bulk_rd_bulk_seq::type_id::create("seq");
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            seq.start(env.agent.seqr);
        
        phase.drop_objection(this);
    endtask
endclass