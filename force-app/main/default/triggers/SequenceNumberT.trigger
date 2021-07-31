Trigger SequenceNumberT on Contact (before Insert ,after delete,after update,after undelete ) 
{ 
    
    HelpClassForSequenceNumberTriggerT obj = new HelpClassForSequenceNumberTriggerT();
    if(Trigger.Isinsert)
    {
        System.debug(trigger.old);
        obj.forInsertRecordInSequenceField(Trigger.new);
    }
    
    if(Trigger.IsDelete )
    { system.debug('run ');
     if( NewClassForContact.runWk() ){
         System.debug('old'+Trigger.old);
         System.debug('new'+Trigger.new);
         obj.forDeleterec(Trigger.old);
     }  
    }
    
    
    
    if(Trigger.Isundelete)
    {
        System.debug(Trigger.old);
        System.debug(Trigger.new);
        if( NewClassForContact.runWk() ){
            
            //for( Contact contactallNewRecord : Trigger.New) {
                 obj.forundeletRecordIn(Trigger.New);
            //}
           
       }
        
    }
    if(Trigger.Isupdate)
    {
        if( NewClassForContact.runWk() )
        { 
            for(Contact onenewrecord : Trigger.new )
            {
                for(Contact oneoldrecord : Trigger.old )
                {
                    if(onenewrecord.Sequence_Number__c != oneoldrecord.Sequence_Number__c && onenewrecord.account.id == oneoldrecord.account.id)
                    {
                        obj.forupdateRecordInSequenceField(onenewrecord,oneoldrecord );
                    }
                    if(onenewrecord.account.id != oneoldrecord.account.id )
                    {
                        obj.forupdateRecordwhenaccountisdiff(trigger.new,trigger.old);
                        
                        
                    }
                    break;    
               }  
            }  
        }
    } 
}