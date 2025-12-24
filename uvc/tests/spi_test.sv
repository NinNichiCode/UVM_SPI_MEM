class spi_test extends base_test;
    `uvm_component_utils(spi_test)
    
    function new(input string inst = "spi_test", uvm_component c);
        super.new(inst,c);
    endfunction
    
    spi_seq seq;
    reset_dut_seq rst_seq;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq = spi_seq::type_id::create("seq");
        rst_seq = reset_dut_seq::type_id::create("rst_seq");
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
          fork
            begin
                seq.start(env.agent.seqr);
            end

            repeat(5)
            begin
                #5000;
                rst_seq.start(env.agent.seqr);
            end

          join          
        
        phase.drop_objection(this);
    endtask
endclass