class write_test extends base_test;
    `uvm_component_utils(write_test)
    
    function new(input string inst = "write_test", uvm_component c);
        super.new(inst,c);
    endfunction
    
    write_seq seq;
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq  = write_seq::type_id::create("seq");
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            seq.start(env.agent.seqr);
        phase.drop_objection(this);
    endtask
endclass