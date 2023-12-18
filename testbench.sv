// Code your testbench here
// or browse Examples

`include "fifo_interface.sv"
`include "fifo_program.sv"
// `include "design.sv"
module top;
  
  
  bit clk;
  
  always #5 clk=~clk;
  
  
  fifo_interface  fifoif(clk);
               
  fifo  duv(.clk(clk),
            .rst(fifoif.rst),
            .rd_en(fifoif.rd_en),
            .wr_en(fifoif.wr_en),
            .data_in(fifoif.data_in),
            .full(fifoif.full),
            .empty(fifoif.empty),
            .data_out(fifoif.data_out));
               
  fifo_program pgb();
    
endmodule