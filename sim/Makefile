
LIB = work_spi

INCDIRS = +incdir+../uvc/seq +incdir+../uvc/env +incdir+../uvc/tests

TESTS = write_test \
		read_test \
		reset_dut_test \
		wr_bulk_rd_bulk_test \
		spi_test
	

all: compile regress coverage summary 

compile:
	vlib $(LIB)
	vmap work $(LIB)
	vlog -work work -sv -cover bcetf ../spi_mem.v ../tb/spi_if.sv $(INCDIRS) ../uvc/env/spi_pkg.sv ../tb/top.sv

regress:
	@mkdir -p logs
	@mkdir -p cov
	@for t in $(TESTS); do \
	vsim -c -coverage top +UVM_TESTNAME=$$t -voptargs="+acc" -l logs/$$t.log -do "coverage save -onexit cov/$$t.ucdb; run -all; quit -f"; \
	done

coverage:
	@echo "==== MERGING COVERAGE ===="
	rm -f cov/merged.ucdb
	vcover merge cov/merged.ucdb cov/*.ucdb
	vcover report -html cov/merged.ucdb -htmldir cov/html
	vcover report -details -file cov/coverage.txt cov/merged.ucdb

summary:
	@echo "========================================="
	@echo "** FILE PASS ** "
	@grep -l "TEST PASSED" logs/*.log | sed 's#.*/##'
	@echo ""
	@echo "** FILE FAIL **"
	@grep -L "TEST PASSED" logs/*.log | sed 's#.*/##'

clean:
	rm -rf $(LIB) transcript logs *.log modelsim.ini cov

.PHONY: all compile regress summary clean 

