public class HelpClassForSequenceNumberTrigger {
    
  /*  public static List<Contact> returnContactList( List<Contact> contactallNewRecord) {
        Set<Id> accountRecordIdsSet = new Set<Id>();
        List<Contact> forcontactrecordlist = new List<Contact>();
        List<Contact> forContactOldList = new List<Contact>();
        List<Account> forAccountList = new  List<Account>();
        //Map<Id,List<Contact>> mapContact = new  Map<Id,List<Contact>> ();
        for(Contact singlerecordofcontact : contactallNewRecord){
            accountRecordIdsSet.add(singlerecordofcontact.accountID);
        }
        
       /* for(Contact singlerecordofcontact : contactAllOldRecord){
            accountRecordIdsSet.add(singlerecordofcontact.accountID);
        }*/
       /* if(accountRecordIdsSet.size() > 0){
            forcontactrecordlist = [SELECT Id, Name, Sequence_Number__c FROM Contact WHERE AccountId =: accountRecordIdsSet];
        }
        /*if(accountRecordIdsSet.size() > 0){
            forContactOldList = [SELECT Id, Name, Sequence_Number__c FROM Contact WHERE AccountId =: accountRecordIdsSet];
        }
        
        if(accountRecordIdsSet.size() > 0){
            forAccountList = [SELECT Id, Name, (SELECT Id,Sequence_Number__c FROM Contacts) FROM Account WHERE Id =: accountRecordIdsSet];
        
            return forcontactrecordlist;
       
            //return forContactOldList;
        
       
    }*/
     Set<Id> accountRecordIdsSet = new Set<Id>();
        List<Contact> forcontactrecordlist = new List<Contact>();
        List<Contact> forContactOldList = new List<Contact>();
        List<Account> forAccountList = new  List<Account>();
    public void  beForeInsertContact( List<Contact> contactallNewRecord) {
        
       // Map<Account,List<Contact>> mapContact = new  Map<Account,List<Contact>> ();
        for(Contact singlerecordofcontact : contactallNewRecord){
            accountRecordIdsSet.add(singlerecordofcontact.accountID);
        }
         //Map<Id,List<Contact>> mapContact = new  Map<Id,List<Contact>> ();
         if(accountRecordIdsSet.size() > 0){
            forAccountList = [SELECT Id, Name, (SELECT Id,Sequence_Number__c FROM Contacts) FROM Account WHERE Id=: accountRecordIdsSet];
         }
        
        System.debug(forAccountList);
      /*  for(Account acc : forAccountList) {
                    mapContact.put(acc,acc.Contacts);
        }
         for(Account acc : forAccountList) {
        	//mapContact.get(contactallNewRecord.accountId).size();
        	contactallNewRecord.Sequence_Number__c
         }
         System.debug(mapContact);
    }*/
     if(accountRecordIdsSet.size() > 0) {
        Decimal count = 0;
     	for(Account acc : forAccountList) {
            // Decimal count = 0;
            count=acc.contacts.size();
            System.debug(count);
            for(Contact con : contactallNewRecord) {
                if(acc.Id == con.AccountId) {
                	con.Sequence_Number__c = count + 1;
                 	//count++;
                }
            }
        }
     }
     }
   public void beForeDeleteContact(List<Contact> contactAllOldRecord) {
       // List<Contact> forContactOldList = returnContactList(contactAllOldRecord);
        List<Contact> conList = [Select Id, Name, Sequence_Number__c From Contact Where AccountId =: accountRecordIdsSet];
       /* List<Contact> updateContactLit = new List<Contact>();
        for( Contact oldCon : contactAllOldRecord ) {
            for( Contact con : conList ) {
                if(con.Sequence_Number__c > oldCon.sequence_number__c) {
                    con.sequence_number__c = con.sequence_number__c - 1;
                    updateContactLit.add(con);
                }
            }
        }*/
       
       if(accountRecordIdsSet.size() > 0) {
        Decimal count = 0;
     	for(Account acc : forAccountList) {
            // Decimal count = 0;
            count=acc.contacts.size();
            System.debug(count);
            for(Contact con : contactAllOldRecord) {
                if(acc.Id == con.AccountId) {
                	con.Sequence_Number__c = count - 1;
                 	//count++;
                }
            }
        }
     }
       // update updateContactLit; 
   }
        
  /*      for(Contact singlerecordofcontact:contactallnewrecord){
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        if( accountrecordids.size() > 0){
            accountsrecords=[Select  ID,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by CreatedDate Asc ) from Account where Id in :accountrecordids];            
        }
        if(accountsrecords.size()>  0){
            Decimal seqnum = 0;
            for(Account singleaccountrecord:accountsrecords){
                for(Contact selectedrecords:singleaccountrecord.Contacts ){
                    Contact cc = [SELECT Id,name,Sequence_Number__c FROM Contact WHERE Id In :trigger.old ALL ROWS];
                    if(selectedrecords.Sequence_Number__c > cc.Sequence_Number__c){
                        selectedrecords.Sequence_Number__c =selectedrecords.Sequence_Number__c-1;
                    }
                    
                    forcontactrecordlist.add(selectedrecords); 
                }
            }	
            update    forcontactrecordlist;
        } 

} 
    
    /*  public  void forUpdateRecordInSequenceField( Contact contactAllNewRecord , Contact contactAllOldRecord ) {
Decimal lmt=1;

accountrecordids.add(contactallnewrecord.accountID);

List<Contact> contactsameaccountrecord = [Select id,name,Sequence_Number__c from Contact where accountid = :accountrecordids];
if(contactallnewrecord.Sequence_Number__c > contactalloldrecord.Sequence_Number__c) {
lmt=contactallnewrecord.Sequence_Number__c - contactalloldrecord.Sequence_Number__c;
}
if(contactalloldrecord.Sequence_Number__c > contactallnewrecord.Sequence_Number__c) {
lmt=contactalloldrecord.Sequence_Number__c - contactallnewrecord.Sequence_Number__c;
}    


List<Contact> forupdatecontactrecord = new List<Contact>(); 

for(Contact singlerecordofcontact : contactsameaccountrecord ) {

if(singlerecordofcontact.Sequence_Number__c > contactalloldrecord.Sequence_Number__c  && singlerecordofcontact.Sequence_Number__c <= contactallnewrecord.Sequence_Number__c && singlerecordofcontact.id != contactallnewrecord.id)  {

for( ;i<=lmt;i++) {
singlerecordofcontact.Sequence_Number__c= singlerecordofcontact.Sequence_Number__c-1;
System.debug(singlerecordofcontact.Sequence_Number__c);
forupdatecontactrecord.add(singlerecordofcontact);
break;
}  
}
else if(singlerecordofcontact.Sequence_Number__c < contactalloldrecord.Sequence_Number__c  && singlerecordofcontact.Sequence_Number__c >= contactallnewrecord.Sequence_Number__c && singlerecordofcontact.id != contactallnewrecord.id)  {

for( ;i<=lmt;i++){
singlerecordofcontact.Sequence_Number__c= singlerecordofcontact.Sequence_Number__c+1;
System.debug(singlerecordofcontact.Sequence_Number__c);
forupdatecontactrecord.add(singlerecordofcontact);
break;

}  
} 
}


update forupdatecontactrecord;


}
public  void forupdateRecordwhenaccountisdiff(List<Contact> contactallnewrecord,List<Contact> contactalloldrecord ){
List<contact> lst=new list<contact>();
for(Contact temp: contactallnewrecord){
lst.add(temp);
}
for(Contact temp: contactalloldrecord){
lst.add(temp);
}
for(contact singlerecordofcontact : lst){
AccountRecordIds.add(singlerecordofcontact.accountId);
}
if( accountrecordids.size() >= 0){
accountsrecords=[Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by LastModifiedDate Asc  ) from Account where Id in :accountrecordids];            
}
if(accountsrecords.size()>=0){
Decimal seqnum=0;
for(Account singleaccountrecord:accountsrecords){
seqnum=0;
for(Contact selectedrecords:singleaccountrecord.Contacts ){
seqnum=selectedrecords.Sequence_Number__c=seqnum+1;
forcontactrecordlist.add(selectedrecords); 
}
}	
update  forcontactrecordlist;
}  
} 


}
public  void forundeleteRecordIn( List<Contact> contactallNewRecord) {
for(Contact singlerecordofcontact:contactallnewrecord){
accountrecordids.add(singlerecordofcontact.accountID);
}
if( accountrecordids.size() >= 0){
accountsrecords=[Select  ID,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by LastModifiedDate Asc ) from Account where Id in :accountrecordids];            
}
if(accountsrecords.size()> = 0){
Decimal seqnum = 0;
for(Account singleaccountrecord:accountsrecords){
for(Contact selectedrecords:singleaccountrecord.Contacts ){
seqnum = selectedrecords.Sequence_Number__c = seqnum+1;
forcontactrecordlist.add(selectedrecords); 
}
}	
update    forcontactrecordlist;
}

}

}*/
    


}