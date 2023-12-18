`include "fifo_pkg.sv"


program fifo_program();
//import uvm_pkg::*;
import fifo_pkg::*;
`include "fifo_test.sv"

initial 
  begin
    run_test("my_test1");
  end
endprogram