+ Overview

This project implements a UVM-based verification environment for an SPI memory controller (spi_mem.v).

The goal is to verify correct SPI functionality under various scenarios such as reset, read, write, and bulk transfers, while collecting functional coverage using QuestaSim, executed via Cygwin on Windows.



+ Implemented Tests

reset_dut_test –> Verifies DUT reset behavior

write_test –> SPI write transaction verification

read_test –> SPI read transaction verification

wr_bulk_rd_bulk_test –> Continuous write/read (stress test)

spi_test –> Integrated SPI functionality test



+ Functional Coverage

Functional coverage is collected using UCDB

HTML coverage reports are automatically generated and available at:  sim/cov/html/index.html




+ Key Features

Fully UVM-compliant verification environment

Transaction-based SPI verification

Multiple directed and bulk transfer test scenarios

Per-test logging and coverage collection

Clean and modular structure, easy to extend with new tests or sequences


<img width="302" height="150" alt="image" src="https://github.com/user-attachments/assets/2dca58e1-8f2c-4ec9-8fef-6e2ec7d69bd1" />


<img width="537" height="347" alt="image" src="https://github.com/user-attachments/assets/274fb296-6476-405d-ac02-1d65b5ddf0b0" />

