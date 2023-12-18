class transaction extends uvm_sequence_item;
  
  rand bit rd_en,wr_en;
  rand bit [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out,data_out_monin;
  logic full,empty;
  logic full_monin,empty_monin;
  int al_addr;
   bit count;
  
  
    constraint valid {data_in inside {[0:((2**(DATA_WIDTH+1))-1)]};
                    if(wr_en==0) rd_en!=0;
                    if(wr_en==1)rd_en!=1;
  if(count==0) {
  wr_en==1;
  rd_en==0;
   }
 else {
 wr_en==0;
 rd_en==1;
 }
 }
   
  function void post_randomize();
        if(count==1) 
          if(al_addr==MEM_SIZE) al_addr=0;
	  else		       al_addr=al_addr+1;	
       else               al_addr=al_addr;
	count = ~count;
  endfunction

  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(data_in,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(wr_en,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(rd_en,UVM_ALL_ON|UVM_DEC)
  `uvm_field_int(data_out,UVM_ALL_ON|UVM_DEC)
  `uvm_object_utils_end
     
//      virtual function string convert2string();
//        return $sformatf("data_out=%0d",data_out);
//      endfunction
     
     virtual function string input2string();
       return $sformatf("data_in=%0d wr_en=%0d rd_en=%0d",data_in,wr_en,rd_en);
     endfunction
     
     
  
  function new(string name="transaction");
  super.new(name);
  endfunction
endclass

class transaction_wr_rd extends transaction;
  
  int l_addr;
  bit count;
                    
  constraint valid {data_in inside {[0:((2**(DATA_WIDTH+1))-1)]};
                                    if(wr_en==0) rd_en!=0;
                                    if(wr_en==1)rd_en!=1;
  if(count==0) 
  {
  wr_en==1;
  rd_en==0;
  }
  else {
  wr_en==0;
  rd_en==1;
  }
  }
  
       
   function void post_randomize();
    if(l_addr<MEM_SIZE)
    count=count;
    else
    count=~count;
                                    
    if(l_addr<MEM_SIZE)
    l_addr=l_addr+1;
    else
    l_addr=0;
    endfunction
                    
  `uvm_object_utils_begin(transaction_wr_rd)
  `uvm_field_int(data_in,UVM_ALL_ON|UVM_NOCOMPARE)
  `uvm_field_int(wr_en,UVM_ALL_ON|UVM_NOCOMPARE)
  `uvm_field_int(rd_en,UVM_ALL_ON|UVM_NOCOMPARE)
  `uvm_field_int(data_out,UVM_ALL_ON)
  `uvm_object_utils_end
     
//      virtual function string convert2string();
//        return $sformatf("data_out=%0d",data_out);
//      endfunction
     
     virtual function string input2string();
       return $sformatf("data_in=%0d wr_en=%0d rd_en=%0d",data_in,wr_en,rd_en);
     endfunction
     
     
  
  function new(string name="transaction");
  super.new(name);
  endfunction
endclass

                  
class transaction_wr0_rd0 extends transaction;
//    int al_addr;
//    bit count;
   
  constraint valid {data_in inside {[0:((2**(DATA_WIDTH+1))-1)]};
                    if(wr_en==0) rd_en!=0;
                    if(wr_en==1)rd_en!=1;
}
   
  
                  
                    
  `uvm_object_utils_begin(transaction_wr0_rd0)
  `uvm_field_int(data_in,UVM_ALL_ON|UVM_NOCOMPARE)
  `uvm_field_int(wr_en,UVM_ALL_ON|UVM_NOCOMPARE)
  `uvm_field_int(rd_en,UVM_ALL_ON|UVM_NOCOMPARE)
  `uvm_field_int(data_out,UVM_ALL_ON)
  `uvm_object_utils_end
     
//      virtual function string convert2string();
//        return $sformatf("data_out=%0d",data_out);
//      endfunction
     
     virtual function string input2string();
       return $sformatf("data_in=%0d wr_en=%0d rd_en=%0d",data_in,wr_en,rd_en);
endfunction
  
  function new(string name="transaction_wr0_rd0");
  super.new(name);
  endfunction
endclass
