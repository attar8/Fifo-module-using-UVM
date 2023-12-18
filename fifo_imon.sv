class imonitor extends uvm_monitor;
	`uvm_component_utils(imonitor)
  
virtual fifo_interface.IMON vif_imon;

int no_of_trans_recvd;
int wr_trans,rd_trans;
int no_of_empty,no_of_full;
  uvm_queue #(int) fifo_queue;
transaction trans;

  
  uvm_analysis_port #(transaction) analysis_port;

function new(string name="imonitor",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
  trans = transaction::type_id::create("trans",this);

  fifo_queue=uvm_queue#(int)::get_global_queue();
  void'(uvm_config_db#(virtual fifo_interface.IMON)::get(get_parent(),"","imon_if",vif_imon));
  assert(vif_imon !=null) else
   `uvm_fatal(get_type_name(),"virtual interface in imonitor is null");
analysis_port= new("imon_analysis_port",this);
endfunction

 virtual task run_phase(uvm_phase phase);
   super.run_phase(phase);
     
// @(vif_imon.imon_cb);

   while(1)

//  forever 
   begin
     full_empty();
   @(vif_imon.imon_cb);
trans= transaction::type_id::create("trans",this);
//      `uvm_info("IMON","imonitor started.....",UVM_LOW);
trans.data_in = vif_imon.imon_cb.data_in;
trans.wr_en =vif_imon.imon_cb.wr_en;
trans.rd_en =vif_imon.imon_cb.rd_en;

     if(vif_imon.imon_cb.wr_en ==1 && vif_imon.imon_cb.rd_en==0 )
	begin
	fifo_queue.push_back(vif_imon.imon_cb.data_in);
      wr_trans++;
      `uvm_info("MONIN_WRITE",$sformatf("TR %0d data_in=%0d size=%0d",no_of_trans_recvd,trans.data_in,fifo_queue.size),UVM_MEDIUM);
     end

     else if( vif_imon.imon_cb.rd_en==1 &&vif_imon.imon_cb.wr_en ==0)
begin
	rd_trans++;
	trans.data_out_monin=fifo_queue.pop_front();
  `uvm_info("MONIN_READ",$sformatf("TR %0d data_out_monin=%0d",no_of_trans_recvd,trans.data_out_monin),UVM_MEDIUM);
end

analysis_port.write(trans);
no_of_trans_recvd++;
end
   $display("@%0t [MONIN] run ended \n",$time);
endtask
  
   task full_empty();
   if(fifo_queue.size==0)
              begin
                trans.full_monin=0;
                trans.empty_monin=1;
                no_of_empty++;
                $display("@%0t [full_emp] full=%0d empty=%0d",$time,trans.full_monin,trans.empty_monin);
              end
     else if(fifo_queue.size==6'd32)
              begin
                trans.full_monin=1;
                trans.empty_monin=0;
                no_of_full++;
                $display("@%0t [full_emp] full=%0d empty=%0d",$time,trans.full_monin,trans.empty_monin);
                
              end
            else
              begin
                trans.full_monin=0;
                trans.empty_monin=0;
                $display("@%0t [full_emp] full=%0d empty=%0d",$time,trans.full_monin,trans.empty_monin);
              end
endtask
endclass