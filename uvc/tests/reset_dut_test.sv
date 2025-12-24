class reset_dut_test extends base_test;
    `uvm_component_utils(reset_dut_test)
    
    function new(input string inst = "reset_dut_test", uvm_component c);
        super.new(inst,c);
    endfunction
    
    reset_dut_seq seq;
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq  = reset_dut_seq::type_id::create("seq");
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            seq.start(env.agent.seqr);
        
        phase.drop_objection(this);
    endtask
endclass