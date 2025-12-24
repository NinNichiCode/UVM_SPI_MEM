
package spi_pkg;

    `include "uvm_macros.svh"
    import uvm_pkg::*;

    `include "transaction.sv"
    `include "write_seq.sv"
	`include "read_seq.sv"
	`include "reset_dut_seq.sv"
	`include "wr_bulk_rd_bulk_seq.sv"
    `include "spi_seq.sv"


    `include "spi_config.sv"
    `include "spi_driver.sv"
    `include "spi_monitor.sv"
    `include "spi_agent.sv"
    `include "spi_scoreboard.sv"
    `include "spi_coverage.sv"
    `include "spi_env.sv"

    `include "base_test.sv"
    `include "write_test.sv"
	`include "read_test.sv"
	`include "reset_dut_test.sv"
	`include "wr_bulk_rd_bulk_test.sv"
    `include "spi_test.sv"

endpackage
