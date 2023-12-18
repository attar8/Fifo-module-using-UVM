class trans_seq1 extends uvm_sequence#(transaction);
  `uvm_object_utils(trans_seq1)

       int no_of_trans_recvd;

  
  function new(string name="trans_seq1");
	super.new(name);
endfunction
  
  task pre_start();
     uvm_config_db#(int)::get(get_sequencer(),"","no_of_trans",no_of_trans_recvd);
  endtask
  
  virtual task body();
    bit [31:0] count;
    transaction ref_trans = transaction::type_id::create("ref_trans");
    repeat(no_of_trans_recvd) begin
      `uvm_create(req);
      assert(ref_trans.randomize());
      req.copy(ref_trans);
      start_item(req);
      finish_item(req);
      count=count+1;
      end
  endtask
endclass
    
  
  
  
  
  
  
  


//   virtual task body;
//    bit [31:0] count;
//    // `uvm_info(get_type_name(),"Body task starting...",UVM_DEBUG);
// //
    
//     uvm_config_db#(int)::get(get_sequencer(),"","no_of_trans",no_of_trans_recvd);
    
//     for (int i = 0; i < no_of_trans_recvd; i++) begin
// 	transaction ref_trans = transaction::type_id::create("ref_trans");
//       assert(ref_trans.randomize());
// //       `uvm_info("SEQ",$sformatf("outputt : %s",ref_trans.convert2string()),UVM_LOW)
//           start_item(ref_trans);
  
//       finish_item(ref_trans);
//      count=count+1;
//       `uvm_info("SEQ",$sformatf("Tr %0d : %s",count,ref_trans.input2string()),UVM_MEDIUM);

//       //`uvm_info("SEQ:Body Task",$sformatf("Transaction= %0d generation done",count),UVM_LOW)
//     end
// //     `uvm_info("SEQ",$sformatf("Body Task Ending......"),UVM_LOW);
//   endtask
// endclass