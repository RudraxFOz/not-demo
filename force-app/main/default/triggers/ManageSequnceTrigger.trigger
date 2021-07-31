trigger ManageSequnceTrigger on Contact (before Insert, after Delete, after Undelete,after Update) {
    HelperForManatneSequnceTrigger obj = new HelperForManatneSequnceTrigger();
    
    if(Trigger.Isinsert) {
            obj.forInsertRecord(Trigger.New);
    }
    
    if(Trigger.IsDelete) {
       if(ConditionCheak.runOnce()) {
            obj.forDeleteRecord(Trigger.old);
       }  
    }
    
    if(Trigger.Isundelete) {
        if( ConditionCheak.runOnce()){
            obj.forUndeleteRecord(Trigger.New);
        }
    }
    
     if(Trigger.Isupdate)
    {
        System.debug(ConditionCheak.runOnce());
        if( ConditionCheak.runOnce() )
        { 
            System.debug(ConditionCheak.runOnce());
            for(Contact onenewrecord : Trigger.new )
            {
                for(Contact oneoldrecord : Trigger.old )//the name of the record is that  your work
                {
                    if(onenewrecord.Sequence_Number__c != oneoldrecord.Sequence_Number__c && onenewrecord.account.id == oneoldrecord.account.id)
                    {
                        obj.forupdateRecord(onenewrecord,oneoldrecord );
                    }
                    if(onenewrecord.account.id != oneoldrecord.account.id )
                    {
                        System.debug(onenewrecord.account.id != oneoldrecord.account.id);
                        obj.forupdateRecordwhenaccountisdiff(trigger.new,trigger.old);
                        
                        
                    }
                    break;    
               }  
            }  
        }
    } 
}