Trigger SequnceT on Contact (before Insert ,after delete,before update,after undelete,after update) 
{ 
    
    JaiHo callFunctionForInsert=new JaiHo();
    if(Trigger.Isinsert)
    {
      
        callFunctionForInsert.forInsertRecordInSequenceField(Trigger.new);
    }
    
    if(Trigger.IsDelete )
    { system.debug('run ');
     if( CheackRev.runOnce()){
         System.debug('old'+Trigger.old);         
         callfunctionforinsert.forDeleterec(Trigger.old);
     }  
    }
    
    
    
    if(Trigger.Isundelete)
    {
        if( CheackRev.runOnce()){
            System.debug(Trigger.old);
            callfunctionforinsert.forundeletRecordIn(Trigger.New);
        }
        
    }
    if(Trigger.isbefore && Trigger.Isupdate )
    {
        if( CheackRev.runOnce() )
        {
            System.debug(Trigger.new+','+Trigger.old);
         
                        callfunctionforinsert.forbefupdate(trigger.new,trigger.oldmap);
                        
        }        
       
    }
    if(trigger.isafter && trigger.isupdate){
       
        if( CheackRev.runOnce() ){
            System.debug('old'+trigger.old);
            callfunctionforinsert.forafupdate(trigger.old,trigger.newMap);
        }
       
    }
}