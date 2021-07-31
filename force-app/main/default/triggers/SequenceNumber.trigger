Trigger SequenceNumber on Contact (before Insert ,after delete,after update,after undelete ) {

 // HelpClassForSequenceNumberTrigger callFunctionForInsert=new HelpClassForSequenceNumberTrigger();
    HelpClassForSequenceNumberTrigger1 obj = new HelpClassForSequenceNumberTrigger1();
   //TestOnly o = new TestOnly();
     if(Trigger.isBefore) {
         if(Trigger.isInsert) {
             obj.beForeInsertContact(Trigger.new);
             //o.forInsertRecordInSequenceField(Trigger.New);
         }
         
     }    
    
       /*  if(Trigger.Isdelete) {
             
             callFunctionForInsert.beForeDeleteContact(Trigger.old);
         }
        
     
    /* if(Trigger.Isundelete)
     {
             callFunctionForInsert.beForeInsertContact(Trigger.Old);
     }*/
     if(Trigger.Isupdate)
     {
        System.debug(NewClassForContact.runWk());
       //  if( NewClassForContact.runWk() )
       // { 
             for(Contact onenewrecord : Trigger.new )
             {
                 for(Contact oneoldrecord : Trigger.old )
                 {
                     System.debug(onenewrecord.Sequence_Number__c != oneoldrecord.Sequence_Number__c && onenewrecord.account.id == oneoldrecord.account.id);
                     if(onenewrecord.Sequence_Number__c != oneoldrecord.Sequence_Number__c && onenewrecord.account.id == oneoldrecord.account.id)
                     {
                        obj.forupdateRecordInSequenceField(onenewrecord,oneoldrecord);
                     }
                     else
                     {
                       obj.forupdateRecordwhenaccountisdiff(trigger.new,trigger.old);
                       
                      }
                    break;    
                 }    
             }
             
               
                  
               
               
            //if(Trigger.old.size()==0 && Trigger.new.size() >0){
                // callfunctionforinsert.forupdateRecordwhenaccountisdiff(Trigger.new);
             //}
             
            // callfunctionforinsert.fornoparent(Trigger.new);
          //}        
    }
}