public class HelpClassForSequenceNumberTrigger1 {

        Set<Id> accountRecordIdsSet = new Set<Id>();
        List<Contact> forcontactrecordlist = new List<Contact>();
        List<Contact> forContactOldList = new List<Contact>();
        List<Account> forAccountList = new  List<Account>();
    	Integer i=1;
     public void  beForeInsertContact( List<Contact> contactallNewRecord) {
        
        for(Contact singlerecordofcontact : contactallNewRecord){
            accountRecordIdsSet.add(singlerecordofcontact.accountID);
        }
       
         if(accountRecordIdsSet.size() > 0){
            forAccountList = [SELECT Id, Name, (SELECT Id,Sequence_Number__c FROM Contacts) FROM Account WHERE Id=: accountRecordIdsSet];
         }
        
        System.debug(forAccountList);
     
     if(accountRecordIdsSet.size() > 0) {
        Decimal count = 0;
     	for(Account acc : forAccountList) {
            count=acc.contacts.size();
            System.debug(count);
            for(Contact con : contactallNewRecord) {
                if(acc.Id == con.AccountId) {
                	con.Sequence_Number__c = count + 1;
                 	count++;
                }
            }
        }
     }
  }
    public  void forUpdateRecordInSequenceField(Contact contactAllNewRecord, Contact contactAllOldRecord ) {
    Decimal lmt=1;
     
       // for(Contact singlerecordofcontact : contactAllNewRecord){
          //  accountRecordIdsSet.add(singlerecordofcontact.accountID);
             accountRecordIdsSet.add(contactAllNewRecord.accountID);
       // }
    
    List<Contact> contactsameaccountrecord = [Select id,name,Sequence_Number__c from Contact where accountid = :accountRecordIdsSet];
        System.debug(contactsameaccountrecord);
    if(contactAllNewRecord.Sequence_Number__c > contactAllOldRecord.Sequence_Number__c) {
        lmt=contactAllNewRecord.Sequence_Number__c - contactAllOldRecord.Sequence_Number__c;
    }
    if(contactAllOldRecord.Sequence_Number__c > contactAllNewRecord.Sequence_Number__c) {
        lmt=contactAllOldRecord.Sequence_Number__c - contactAllNewRecord.Sequence_Number__c;
    }    
    
    
    List<Contact> forupdatecontactrecord = new List<Contact>(); 
    
    for(Contact singlerecordofcontact : contactsameaccountrecord ) {
        
        if(singlerecordofcontact.Sequence_Number__c > contactAllOldRecord.Sequence_Number__c  && singlerecordofcontact.Sequence_Number__c <= contactAllNewRecord.Sequence_Number__c && singlerecordofcontact.id != contactAllNewRecord.id)  {
            
            for( ;i<=lmt;i++) {
                singlerecordofcontact.Sequence_Number__c= singlerecordofcontact.Sequence_Number__c-1;
                System.debug(singlerecordofcontact.Sequence_Number__c);
                //forupdatecontactrecord.add(singlerecordofcontact);
                break;
            }  
        }
        else if(singlerecordofcontact.Sequence_Number__c < contactAllOldRecord.Sequence_Number__c  && singlerecordofcontact.Sequence_Number__c >= contactAllNewRecord.Sequence_Number__c && singlerecordofcontact.id != contactAllNewRecord.id)  {
            
            for( ;i<=lmt;i++){
                singlerecordofcontact.Sequence_Number__c= singlerecordofcontact.Sequence_Number__c+1;
                System.debug(singlerecordofcontact.Sequence_Number__c);
               // forupdatecontactrecord.add(singlerecordofcontact);
                break;
                
            }  
        } 
    }
    
    
   // update forupdatecontactrecord;
    
    
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
        accountRecordIdsSet.add(singlerecordofcontact.accountId);
    }
    if( accountRecordIdsSet.size() >= 0){
        forAccountList=[Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by LastModifiedDate Asc  ) from Account where Id in :accountRecordIdsSet];            
    }
    if(forAccountList.size()>=0){
        Decimal seqnum=0;
        for(Account singleaccountrecord:forAccountList){
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