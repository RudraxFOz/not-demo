Trigger SeqTrigger on Contact (before Insert ,after delete,before update,after undelete,after update) 
{ 
    
    HelperForConTrigger obj = new HelperForConTrigger();
    
    if(Trigger.Isinsert)
    {
        
        obj.forInsertRecordInSequenceField(Trigger.new);
    }
    
    if(Trigger.IsDelete )
    { 
     if( RecursiveClass.runOnce()){
                  
         obj.forDeleterec(Trigger.old);
     }  
    }
    
    
    
    if(Trigger.Isundelete)
    {
        if( RecursiveClass.runOnce()) {
            obj.forundeletRecordIn(Trigger.new);
        }
        
    }
    if(Trigger.isbefore && Trigger.Isupdate )
    {
        if( RecursiveClass.runOnce() ) {
           obj.forbefupdate(trigger.new,trigger.oldmap);                
        }        
       
    }
    if(trigger.isafter && trigger.isupdate) {
       
        if( RecursiveClass.runOnce() ) {
            obj.forafupdate(trigger.old,trigger.newMap);
        }
       
    }
}