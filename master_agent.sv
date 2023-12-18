class master_agent extends uvm_agent;
  `uvm_component_utils(master_agent)
  
  
  sequencer  sqr;
  my_driver  drv;
  imonitor imon;
  uvm_analysis_port#(transaction) ap;
  
  function new(string name="master_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     ap=new("ap",this);
     if(is_active==UVM_ACTIVE) begin
         sqr = sequencer::type_id::create("sqr",this);
         drv = my_driver::type_id::create("drv",this);
         imon =imonitor::type_id::create("imon",this);
   end
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
    if(is_active==UVM_ACTIVE) begin
   drv.seq_item_port.connect(sqr.seq_item_export);
   imon.analysis_port.connect(this.ap);
end
  endfunction
  
endclass
