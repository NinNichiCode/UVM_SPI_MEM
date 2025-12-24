
class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    function new (string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    spi_env env;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = spi_env::type_id::create("env", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            run_test_seq();
        phase.drop_objection(this);
    endtask

    virtual task run_test_seq();

    endtask

    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction

    function void report_phase(uvm_phase phase);
        int err_cnt;
        uvm_report_server server;
        super.report_phase(phase);

        server = uvm_report_server::get_server();
        err_cnt = server.get_severity_count(UVM_FATAL) + server.get_severity_count(UVM_ERROR);

        if (err_cnt == 0) begin
            `uvm_info("BASE_TEST", "*** TEST PASSED ***", UVM_NONE)
        end else begin 
            `uvm_info("BASE_TEST", "*** TEST FAILED ***", UVM_NONE)
        end
    endfunction
endclass

