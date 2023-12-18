class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)
   
   fifo_env env;
   trans_seq1 seq;
//    int no_of_trans;

  function new(string name="fifo_test", uvm_component parent=null);
     super.new(name, parent);
   endfunction
  
   
  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
   
     seq=trans_seq1::type_id::create("seq");
    uvm_config_db#(virtual fifo_interface.DRIVER)::set(this,"env.m_agent","drv_if",top.fifoif.DRIVER);
    uvm_config_db#(virtual fifo_interface.IMON)::set(this,"env.m_agent","imon_if",top.fifoif.IMON);
    uvm_config_db#(virtual fifo_interface.OMON)::set(this,"env.s_agent","omon_if",top.fifoif.OMON);
    uvm_config_db#(int)::set(this,"env.m_agent.sqr","no_of_trans",64);
    

             //set_type_override_by_type(transaction::get_type(),transaction_wr0_rd0::get_type());

//     uvm_config_db#(int)::set(null,"*","no_of_trans",no_of_trans);

   endfunction

     
//    task run_phase(uvm_phase phase);
//      phase.raise_objection(this);
//      super.run_phase(phase);
//     seq.start(env.m_agent.sqr);
//      phase.phase_done.set_drain_time(this,50ns);
//      phase.drop_objection(this);
//    endtask 
  
  function void end_of_elaboration_phase(uvm_phase phase);
    super.final_phase(phase);
    uvm_top.print_topology();
  endfunction
  
endclass


class my_test1 extends fifo_test;
  `uvm_component_utils(my_test1);
  
  
  function new(string name="fifo_test", uvm_component parent=null);
     super.new(name, parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
   //  set_type_override_by_type(transaction::get_type(),transaction_wr_rd::get_type());
     env = fifo_env::type_id::create("env", this);
   endfunction
  
  
   task run_phase(uvm_phase phase);
     phase.raise_objection(this);
     super.run_phase(phase);
    seq.start(env.m_agent.sqr);
     phase.phase_done.set_drain_time(this,50ns);

     //      $display("main phase");
     phase.drop_objection(this);
   endtask 
  
//   function void end_of_elaboration_phase(uvm_phase phase);
//     super.final_phase(phase);
//     uvm_top.print_topology();
//      endfunction
  
endclass


class my_test2 extends fifo_test;
  `uvm_component_utils(my_test2);
  
  
  function new(string name="fifo_test", uvm_component parent=null);
     super.new(name, parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
    
     super.build_phase(phase);
      set_type_override_by_type(transaction::get_type(),transaction_wr_rd::get_type());
     env = fifo_env::type_id::create("env", this);
   endfunction
  
   task run_phase(uvm_phase phase);
     phase.raise_objection(this);
     super.run_phase(phase);
    seq.start(env.m_agent.sqr);
     phase.phase_done.set_drain_time(this,50ns);

     //      $display("main phase");
     phase.drop_objection(this);
   endtask 
  
//   function void end_of_elaboration_phase(uvm_phase phase);
//     super.final_phase(phase);
//     uvm_top.print_topology();
//      endfunction
  
endclass

class my_test3 extends fifo_test;
  `uvm_component_utils(my_test3);
  
  
  function new(string name="fifo_test", uvm_component parent=null);
     super.new(name, parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
     super.build_phase(phase);
     set_type_override_by_type(transaction::get_type(),transaction_wr0_rd0::get_type());
     env = fifo_env::type_id::create("env", this);
   endfunction
  
   task run_phase(uvm_phase phase);
     phase.raise_objection(this);
     super.run_phase(phase);
    seq.start(env.m_agent.sqr);
     phase.phase_done.set_drain_time(this,50ns);

     //      $display("main phase");
     phase.drop_objection(this);
   endtask 
  
//   function void end_of_elaboration_phase(uvm_phase phase);
//     super.final_phase(phase);
//     uvm_top.print_topology();
//      endfunction
  
endclass



  
  
  
  
  
  