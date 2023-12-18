// class coverage_collector extends uvm_subscriber #(transaction);
//   `uvm_component_utils(coverage_collector)
  
//  uvm_analysis_imp #(transaction,coverage_collector) aport;

//     transaction trans;

//   covergroup cg;
//     data_in_cp: coverpoint trans.data_in{bins b_data_in[]={[0:255]};}
//     wr_en_cp: coverpoint trans.wr_en{bins b_wr_en[]={0,1};}
//     rd_en_cp: coverpoint trans.rd_en{bins b_rd_en[]={0,1};}
    
//   endgroup
    
//   virtual function void sample(transaction trans);
//     this.trans = trans;
//     cg.sample();
//   endfunction
  
//   function new(string name="coverage_collector",uvm_component parent=null);
//     super.new(name,parent);
//     cg=new();
//   endfunction
  
//    function void build_phase(uvm_phase phase);
   
//     //Instantiate analysis port
// aport = new("aport",this);
//   endfunction 
  
//  virtual function void write(input transaction trans);
//     sample(trans);
//     `uvm_info ("COVERAGE", $sformatf ("Coverage=%0d ",cg.get_inst_coverage (), UVM_MEDIUM);
    
//   endfunction
// endclass