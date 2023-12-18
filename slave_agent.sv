class slave_agent extends uvm_agent;
  `uvm_component_utils(slave_agent)
  
  omonitor omon;
  uvm_analysis_port#(transaction) ap;
  
  
  function new(string name="slave_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
//    if(is_active==UVM_ACTIVE) begin
        ap=new("ap",this);

    omon= omonitor::type_id::create("omon",this);
//     end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    omon.analysis_port.connect(this.ap);
  endfunction
endclass
