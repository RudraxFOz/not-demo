public class HelperClassForSequenceNumber1 {
    
       public static Boolean apptSequenceNo = true;
    set<Id> AccountRecordIds=new set<Id>();
    List<Account>AccountRecord=new List<Account>();
    List<contact> contactRecord=new List<contact>();
    Map<id,List<Contact>> AccountContactMap = new Map<id,List<Contact>>();
    Integer conatactsequence;
    Contact c;
   // Integer AccountRecordIds;
    //String fieldValue = Contact.getFieldValue(Sequence_Number__c);
    public HelperClassForSequenceNumber1() {
        Contact c = new Contact();
    }
     public void updateContacts(list<Contact> contactsToUpdate){
      AccountRecord=[SELECT ID, Name, (select Id, Name, Sequence_Number__c from Contacts ORDER BY CreatedDate ASC ) FROM Account Where  Id IN :AccountRecordIds]; 
        
    } 
    public void ForInsertRecordInSequenceField(List<contact> ContactRec) {
        
        for(contact SingleRecordOfContact:ContactRec){
            AccountRecordIds.add(SingleRecordOfContact.accountID);
            // AccountRecordIds = AccountContactMap.get(SingleRecordOfContact.AccountId).size())
        }
        
        if( AccountRecordIds.size() > 0){
            AccountRecord=[Select  ID,Name,(Select Id,Name,sequence_number__c from contacts ORDER BY CreatedDate ASC) from Account where ID in :AccountRecordIds];            
        }
      
        //System.debug('AccountRecord');
        
        if(AccountRecord.size()>0){
            Decimal Seqnum=0;
            for(Account SingleAccountRecord:AccountRecord) {
                for(Contact SelectedRecords:SingleAccountRecord.Contacts ) {
                    //if()
                    Seqnum=SelectedRecords.sequence_number__c=Seqnum+1;
                    contactRecord.add(SelectedRecords); 
                }
            }	
           Update contactRecord;
        }    
    }
    public void ForDeleteRecordInSequenceField(List<contact> ContactRec) {
        /* if(HelperClassForSequenceNumber1.apptSequenceNo == true){ // global flag to stop recursive trigger
HelperClassForSequenceNumber1.apptSequenceNo = false;*/
        for(Contact con: ContactRec){
            AccountRecordIds.add(con.AccountId);
        }
        
        if(AccountRecordIds.size() >0) {    
            AccountRecord=[SELECT ID, Name, (select Id, Name, Sequence_Number__c from Contacts ORDER BY CreatedDate ASC ) FROM Account Where  Id IN :AccountRecordIds]; 
        }
        
        if(AccountRecord.size() >0) {
            for(Account leadObj: AccountRecord) {
                for(Contact app: leadObj.Contacts) {
                    Contact cc = [SELECT Id, Name, Sequence_Number__c FROM Contact WHERE Id  IN:trigger.old ALL ROWS];
                    if(app.Sequence_Number__c > cc.Sequence_Number__c) {
                        app.Sequence_Number__c = app.Sequence_Number__c - 1;
                    }
                    contactRecord.add(app);      
                }
            }
            /*if(Trigger.isUpdate) {
for(Account leadObj: AccountRecord) {
for(Contact app: leadObj.Contacts) {
Contact cc = [SELECT Id, Name, Sequence_Number__c FROM Contact WHERE Id  IN:trigger.old ALL ROWS];
if(app.Sequence_Number__c = cc.Sequence_Number__c) {
app.Sequence_Number__c = app.Sequence_Number__c - 1;
}
contactRecord.add(app);      
}
}*/
            Update contactRecord;
        }
        //  }
        //  HelperClassForSequenceNumber1.apptSequenceNo = true;           
    }
    
    /* public void ForUpdateRecordInSequenceField(List<contact> ContactRec)
{
if(HelperClassForSequenceNumber1.apptSequenceNo == true){ // global flag to stop recursive trigger
HelperClassForSequenceNumber1.apptSequenceNo = false;
for(Contact con: ContactRec){
AccountRecordIds.add(con.AccountId);
}

if(AccountRecordIds.size() >0) {    
AccountRecord=[SELECT ID, Name, (select Id, Name, Sequence_Number__c from Contacts ORDER BY CreatedDate ASC ) FROM Account Where  Id IN :AccountRecordIds]; 
}

if(AccountRecord.size() >0) {
for(Account leadObj: AccountRecord) {
for(Contact app: leadObj.Contacts) {
Contact cc = [SELECT Id, Name, Sequence_Number__c FROM Contact WHERE Id  IN:trigger.old ALL ROWS];
if(app.Sequence_Number__c == cc.Sequence_Number__c) {
app.Sequence_Number__c = app.Sequence_Number__c - 1;
}
contactRecord.add(app);      
}
}
UPDATE contactRecord;
}
}
// HelperClassForSequenceNumber1.apptSequenceNo = true;           
}   */
    public void ForUpdateRecordInSequenceField(Map<Id,Contact> oldMap, Map<Id,Contact> newMap) {
        //Map<Id,Contact> oldMap, Map<Id,Contact> newMap
       /* for(contact SingleRecordOfContact:ContactRec){
            if(SingleRecordOfContact.id != newContMap.get(SingleRecordOfContact.id).Id) {
                AccountRecordIds.add(SingleRecordOfContact.accountID);
            }
        }*/
        
    /*  if( AccountRecordIds.size() > 0){
            AccountRecord=[Select  ID,Name,(Select Id,Name,sequence_number__c from contacts ) from Account where ID in :AccountRecordIds];            
        }*/
         //System.debug(c1);
       // System.debug(c2);
     //  Contact c = new Contact();
       List<Contact> co = new List<Contact>();
         newMap = new Map<Id,Contact>();
        for(Contact c1 : oldMap.values()) {
            //Contact cc = [SELECT Id, Name, Sequence_Number__c FROM Contact WHERE Id  IN:trigger.old ALL ROWS];

            for(Contact c2 : newMap.values()) {
                	Decimal temp;
                if(c1.sequence_number__c <= c2.sequence_number__c) {
                   // c1.sequence_number__c++;
                   c2.sequence_number__c = c1.sequence_number__c;
                }
                   //temp = c1.sequence_number__c;
                //	c1.sequence_number__c = c2.sequence_number__c;
                	//c2.sequence_number__c = temp; 
                    //c1.sequence_number__c = c2.sequence_number__c;
                    //c2.sequence_number__c = c1.sequence_number__c;
               // } 
                // }*/
         //System.debug(c1);
       // System.debug(c2);
       				co.add(c2);
                	//co.add(c1);
            }
        }
        update co;
       
        /*for(Contact con: oldContactRec) {
          ContactRec  = new List<Contact>();
            System.debug( con.Sequence_Number__c);
            System.debug( con.AccountId);
            System.debug( AccountContactMap.get(con.AccountId));
            System.debug(conatactsequence);
             conatactsequence = Integer.valueOf(con.Sequence_Number__c);
            conatactsequence = Integer.valueOf()
            if(newContactRec == conatactsequence) {
                
            }
            if( con.Sequence_Number__c>=0 && con.Sequence_Number__c<=AccountContactMap.get(con.AccountId).size()) {
                contactRecord.addAll(AccountContactMap.get(con.AccountId));
                conatactsequence = Integer.valueOf(con.Sequence_Number__c);
            }
            else {
                con.Sequence_Number__c = AccountContactMap.get(con.AccountId).size()+1;
            }
        
 
            
        }
        if(contactRecord.size()>0) {
            for(Contact c: contactRecord) {
                if(c.Sequence_Number__c!=null && c.Sequence_Number__c>=conatactsequence) {
                    c.Sequence_Number__c++;
                }
            }
            update contactRecord;
            
            if(AccountRecord.size() >0) {
for(Account leadObj: AccountRecord) {
for(Contact app: leadObj.Contacts) {
Contact cc = [SELECT Id, Name, Sequence_Number__c FROM Contact WHERE Id  IN:trigger.old ALL ROWS];
if(app.Sequence_Number__c == cc.Sequence_Number__c) {
app.Sequence_Number__c = app.Sequence_Number__c - 1;
}                                                                                                                                                         
contactRecord.add(app);      
}
}
Update contactRecord;
}
            
        }*/
    }
   
}