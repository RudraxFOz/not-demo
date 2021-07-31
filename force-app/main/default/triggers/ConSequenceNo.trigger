trigger ConSequenceNo on Contact (after insert, after update, after delete)  {

 list<Contact> apptsToUpdate=new list<Contact>();
    Set<Id> parentIds = new Set<Id>();
    list<Account> parentLeadsById = new list<Account>();
    
    if(trigger.isdelete){
        if(ConSeqRecursive.apptSequenceNo == true){ // global flag to stop recursive trigger
            ConSeqRecursive.apptSequenceNo = false;
            for(Contact con: Trigger.old){
                parentIds.add(con.AccountId);
            }
            
            if(parentIds.size() >0){    
                parentLeadsById=[SELECT ID, Name, (select Id, Name, Sequence_Number__c from Contacts ORDER BY CreatedDate ASC ) FROM Account Where  Id IN :parentIds]; 
            }
            
            if(parentLeadsById.size() >0){
                for(Account leadObj: parentLeadsById){
                    for(Contact app: leadObj.Contacts){
                        Contact cc = [SELECT Id, Name, Sequence_Number__c FROM Contact WHERE Id IN:trigger.old ALL ROWS];
                        if(app.Sequence_Number__c > cc.Sequence_Number__c){
                            app.Sequence_Number__c = app.Sequence_Number__c -1;
                        }
                        apptsToUpdate.add(app);      
                    }
                }
                UPDATE apptsToUpdate;
            }
        }
        ConSeqRecursive.apptSequenceNo = true;
    }
    
    if(trigger.isinsert || trigger.isinsert){
        if(ConSeqRecursive.apptSequenceNo == true){ // global flag to stop recursive trigger
            ConSeqRecursive.apptSequenceNo = false;
            for(Contact fa: Trigger.New){
                parentIds.add(fa.AccountId);
            }
            
            if(parentIds.size() >0){    
                parentLeadsById=[SELECT ID, Name, (SELECT Id, Name FROM Contacts ORDER BY CreatedDate ASC ) FROM Account Where  Id IN :parentIds]; 
            }
            
            if(parentLeadsById.size() >0){
                for(Account leadObj: parentLeadsById){
                    Decimal sqno = 0;
                    for(Contact app: leadObj.Contacts){
                        sqno = app.Sequence_Number__c = sqno+1;
                        apptsToUpdate.add(app);      
                    }
                }
                UPDATE apptsToUpdate;
            }
        }
        ConSeqRecursive.apptSequenceNo = true; 
    }
}