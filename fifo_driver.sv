class my_driver extends uvm_driver#(transaction);
	`uvm_component_utils(my_driver)

  bit [31:0]pkt;
virtual fifo_interface.DRIVER vif;
  
  // covergroup fifo_drv_cg;
// //    option.per_instance = 1;
//   cp_WRITE:   coverpoint trans.wr_en {bins b_wr[]={0,1};}
//   cp_READ:    coverpoint trans.rd_en  {bins b_rd[]={0,1};}
//   cp_DATA_IN: coverpoint trans.data_in   {bins b_datain ={[0:255]};}

// endgroup




  function new(string name="driver", uvm_component parent=null);
	super.new(name,parent);
    //fifo_drv_cg = new();
endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  void'(uvm_config_db#(virtual fifo_interface.DRIVER)::get(get_parent(),"","drv_if",vif));
  assert(vif !=null) else
    `uvm_fatal(get_type_name(),"virtual interface in driver is null");
endfunction



virtual task run_phase(uvm_phase phase);
  super.run_phase(phase);
forever begin
//  wait(!vif.rst)
        transaction ref_trans;
  
  seq_item_port.get_next_item(ref_trans);
  pkt=pkt+1;
// fifo_drv_cg.sample();
//   `uvm_info("DRV",$sformatf(" Recvd Tr (%0d) from TLM port",pkt),UVM_MEDIUM);
  drive_to_design(ref_trans);
	seq_item_port.item_done();
//   `uvm_info("DRV RUN Phase",$sformatf("Tr %0d drive to design",pkt),UVM_LOW);
  
end
endtask

  virtual task drive_to_design(input transaction ref_trans);
  @(vif.driver_cb);
//   `uvm_info("DRV","Driving Tr strated....",UVM_LOW);
vif.driver_cb.data_in <= ref_trans.data_in;
vif.driver_cb.wr_en <= ref_trans.wr_en;
vif.driver_cb.rd_en <= ref_trans.rd_en;
    `uvm_info("DRv",$sformatf("(%0d) Tr: data_in =%0d,wr_en=%0d,rd_en=%0d",pkt,ref_trans.data_in,ref_trans.wr_en,ref_trans.rd_en),UVM_MEDIUM);
//   `uvm_info("DRV","Driving Tr ended....",UVM_LOW);

endtask
  
  
  task reset_phase(uvm_phase phase);
	phase.raise_objection(this,"RESET raised obj");
  `uvm_info("DRVR:reset_phase","RESET started....",UVM_MEDIUM);
      vif.rst =1;
  repeat(2) @(vif.driver_cb);
	vif.rst =0;
    `uvm_info("DRVR:reset_phase","RESET ended....",UVM_MEDIUM);
phase.drop_objection(this,"RESET dropped obj");
endtask
  
endclass