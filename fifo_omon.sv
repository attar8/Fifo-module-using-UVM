class omonitor extends uvm_monitor;
`uvm_component_utils(omonitor)
  
virtual fifo_interface.OMON vif_omon;
transaction trans;
int no_of_trans_recvd;
  uvm_analysis_port #(transaction) analysis_port;
  
    //analysis port for subscriber
//   uvm_analysis_port #(transaction) aport;     


//   covergroup fifo_omon_cg;
//    //option.per_instance = 1;
//   cp_DATA_OUT: coverpoint trans.data_out   {bins b_data_out ={[0:255]};}
// endgroup

function new (string name ="omonitor",uvm_component parent);
super.new(name,parent);
    //fifo_omon_cg = new();
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
  void'(uvm_config_db#(virtual fifo_interface.OMON)::get(get_parent(),"","omon_if",vif_omon));
  assert(vif_omon !=null) else
    `uvm_fatal(get_type_name(),"virtual interface in omonitor is null");
  analysis_port= new("omon_analysis_port",this);
endfunction

task run_phase(uvm_phase phase);
repeat(2)
// @(vif_omon.omon_cb);
forever 
  begin
@(vif_omon.omon_cb);
//     `uvm_info("OMON","imonitor started....",UVM_MEDIUM);
trans = transaction::type_id::create("trans",this);
    trans.data_out = vif_omon.omon_cb.data_out;
trans.rd_en = vif_omon.omon_cb.rd_en;
trans.full = vif_omon.omon_cb.full;
trans.empty = vif_omon.omon_cb.empty;

    

// if(vif_omon.omon_cb.rd_en ==1)
// begin

  `uvm_info("MONOUT_READ",$sformatf(" TR %0d data_out=%0d",no_of_trans_recvd,trans.data_out),UVM_MEDIUM);


//   end
      `uvm_info("full_empty",$sformatf(" full =%0d empty=%0d",trans.full,trans.empty),UVM_MEDIUM);

      no_of_trans_recvd++;

analysis_port.write(trans);
// aport.write(trans);	   

   // fifo_omon_cg.sample();
 end
endtask
endclass