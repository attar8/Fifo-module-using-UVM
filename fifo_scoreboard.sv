`uvm_analysis_imp_decl(_from_omon)
`uvm_analysis_imp_decl(_from_imon)

class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
  
  
  uvm_analysis_imp_from_imon #(transaction,scoreboard) ap_imp_imon;
  uvm_analysis_imp_from_omon #(transaction,scoreboard) ap_imp_omon;
  
int total_trans_recvd;  
transaction  imon_trans;
transaction  omon_trans;
transaction trans;
  
int imon_recvd;
int omon_recvd;
int item_count;

int match,mismatch;
event compare_trans;
  

function new( string name ="scoreboard",uvm_component parent=null);
super.new(name,parent);
endfunction

virtual function void build_phase (uvm_phase phase);
 super.build_phase(phase);

	ap_imp_imon = new("ap_imp_imon",this);
	ap_imp_omon = new("ap_imp_omon",this);
    uvm_config_db#(int)::get(null,"uvm_test_top.env.m_agent.sqr","no_of_trans",item_count);


endfunction
  
virtual function void write_from_imon(input transaction trans);
imon_trans=trans;
  `uvm_info("IMON2SCB",$sformatf("imon_recvd=%0d",imon_trans.data_out_monin),UVM_MEDIUM);
    omon_recvd=omon_recvd+1;

endfunction

virtual function void write_from_omon(input transaction trans);
  omon_trans=trans;
  `uvm_info("OMON2SCB",$sformatf("omon_recvd=%0d",omon_trans.data_out),UVM_MEDIUM);
  omon_recvd=omon_recvd+1; 
  if(omon_recvd<=(2*item_count)+1)
    ->compare_trans;
endfunction

 

task run_phase(uvm_phase phase);
forever begin
  @(compare_trans)
        if(imon_trans.data_out_monin==omon_trans.data_out)
			begin
              `uvm_info("SCB",$sformatf("@%0t [SCB] PASS TB_data:%0d\tDUT_data:%0d",$time,imon_trans.data_out_monin,omon_trans.data_out),UVM_MEDIUM);
		   		match=match+1;
		     end
        else if(imon_trans.data_out_monin!=omon_trans.data_out)
			begin
              `uvm_info("SCB",$sformatf("@%0t [SCB] FAIL TB_data:%0d\tDUT_data:%0d",$time,imon_trans.data_out_monin,omon_trans.data_out),UVM_MEDIUM);
		  		mismatch=mismatch+1;
			end
  else if((imon_trans.empty_monin==1) && (omon_trans.empty==1))
    `uvm_info("[Scb]"," FIFO  Empty",UVM_MEDIUM)
  else if((imon_trans.full_monin==1) && (omon_trans.full==1))
    `uvm_info("[Scb]"," FIFO  Full",UVM_MEDIUM)
end 
endtask
endclass




