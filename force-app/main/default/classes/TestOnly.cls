public class TestOnly {
    set<Id> accountrecordids = new set<Id>();
    list<Account> accountsrecords = new list<Account>();
    public void forInsertRecordInSequenceField( List<Contact> contactallNewRecord) 
  {                
  	for(Contact singlerecordofcontact:contactallnewrecord)
    {           
    	accountrecordids.add(singlerecordofcontact.accountID); 
    }
    if( accountrecordids.size() > 0){
    	accountsrecords=[Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts ) from Account where Id in :accountrecordids];            
    }
      
   if(accountsrecords.size()> = 0){
   		Decimal count=0;
      	System.debug('++'+ count);
        for(Account accountsinglercords:accountsrecords){
        	count=accountsinglercords.contacts.size();
        	for(Contact selectedrecords:contactallNewRecord){
                if(accountsinglercords.Id == selectedrecords.AccountId ){
            	selectedrecords.Sequence_Number__c =count+1; 
                }
              
            }
        }	  
     }
         
 }

}