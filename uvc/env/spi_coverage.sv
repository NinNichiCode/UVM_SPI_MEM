class spi_coverage extends uvm_subscriber#(transaction);
    `uvm_component_utils(spi_coverage)

    transaction tr;

    covergroup cov_inst;
        option.per_instance = 1;

        cp_op: coverpoint tr.op {
            bins b_read  = {readd};
            bins b_write = {writed};
            bins b_reset = {rstdut};
        }

        cp_addr: coverpoint tr.addr {
            bins valid_range   = {[0:31]};   // address valid range
            bins invalid_range = {[32:255]}; // address invalid range
     
            bins boundary_min  = {0};
            bins boundary_max  = {31};
        }

        cp_din: coverpoint tr.din {
            bins zero = {8'h00};
            bins max  = {8'hFF};
            bins others = {[8'h01:8'hFE]};
        }

        cp_dout: coverpoint tr.dout {
            bins corners[] = {8'h00, 8'hFF};
            bins others    = {[8'h01:8'hFE]};
        }


        cross_op_addr: cross cp_op, cp_addr {
            ignore_bins reset_ignore = binsof(cp_op) intersect {rstdut};
        }

        cross_op_data: cross cp_op, cp_din {
            ignore_bins read_reset = binsof(cp_op) intersect {readd, rstdut};
        }

    endgroup

    function new (string name = "spi_coverage", uvm_component parent = null);
        super.new(name, parent);
        cov_inst = new();
    endfunction

    virtual function void write(transaction t);
        this.tr = t;
        cov_inst.sample();
    endfunction
endclass