class fifo_env extends uvm_env;
  `uvm_component_utils(fifo_env)
  
  
   master_agent m_agent;
   slave_agent s_agent;
   scoreboard scb;
//   coverage_collector sub;
  
  int no_of_trans;
  
  function new(string name="fifo_env",uvm_component parent=null);
    super.new(name,parent);
  endfunction    
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	 m_agent = master_agent::type_id::create("m_agent", this);
     s_agent = slave_agent::type_id::create("s_agent", this);
     scb= scoreboard::type_id::create("scb", this);
//      sub=coverage_collector::type_id::create("sub",this);

   uvm_config_db#(int)::get(this,"","no_of_trans",no_of_trans);


  endfunction
  
   function void connect_phase(uvm_phase phase);
     
     m_agent.ap.connect(scb.ap_imp_imon);
     s_agent.ap.connect(scb.ap_imp_omon);
//       s_agent.aport.connect(sub.aport);
     
   endfunction: connect_phase
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    wait(2*no_of_trans == scb.imon_recvd);
    begin
      #2;
      $display("we have reached the end of test");
    end
    phase.drop_objection(this);
  endtask
  
  
endclass