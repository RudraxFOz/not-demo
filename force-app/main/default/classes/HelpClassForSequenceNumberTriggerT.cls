public class HelpClassForSequenceNumberTriggerT {
    public static boolean isexecuted = true;    
    HelpClassForSequenceNumberTriggerT ob = new HelpClassForSequenceNumberTriggerT();
    List<Contact> forupdatecontactrecord = new List<Contact>(); //
    Set<Id> accountRecordIds = new Set<Id>();                   //In This set all Account id is store
    List<Account> accountsrecords = new List<Account>();
    List<Contact> forcontactoldrecordlist = new List<Contact>();
 //   Map<Set<Id>,List<
  
    public List<Contact> forcontactrecordlist = new List<Contact>();
    public Integer i=1;  
    public void forInsertRecordInSequenceField( List<Contact> contactallNewRecord) //This method is work for Insert the new Record In Contact Object
    {                
        for(Contact singlerecordofcontact:contactallNewRecord)
        {           
            accountRecordIds.add(singlerecordofcontact.accountID); //Here all Account Object Id is store
        }
        if( accountRecordIds.size() > 0){   //Here cheak this condition if in Contact Object have not any  Account So this qurey is not work
            // Map<String ,Account> accMap = new Map<String, Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts ) from Account where Id in :accountrecordids]);
            accountsrecords=[Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts ORDER BY Sequence_Number__c ASC ) from Account where Id in :accountRecordIds];            
        }
        
        if(accountsrecords.size()> = 0){
            Decimal count=0;
            for(Account accountsinglercords: accountsrecords){  //we find the the Account object related All Contact Object
                count=accountsinglercords.contacts.size();      //in count we find the size of Contact Object in one Account Object
                for(Contact selectedrecords:contactallNewRecord){
                    if(accountsinglercords.Id == selectedrecords.AccountId ){
                        selectedrecords.Sequence_Number__c =count+1;
                        count++;
                    }
                    
                }
            }	 
        }
        
    }
    
    
    
    
    public void forUpdateRecordInSequenceField( Contact contactallnewrecord , Contact contactalloldrecord ) {
        Decimal lmt=1;
       
       accountrecordids.add(contactallnewrecord.accountID);
        List<Contact> contactsameaccountrecord = [Select id,name,Sequence_Number__c from Contact where accountid = :accountrecordids];
     
        if(contactallnewrecord.Sequence_Number__c > contactalloldrecord.Sequence_Number__c) {
            lmt=contactallnewrecord.Sequence_Number__c - contactalloldrecord.Sequence_Number__c;
        }
        
        if(contactalloldrecord.Sequence_Number__c > contactallnewrecord.Sequence_Number__c) {
            lmt=contactalloldrecord.Sequence_Number__c - contactallnewrecord.Sequence_Number__c;
        }    
      
        
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
    
    
    
    
    
    public void forupdateRecordwhenaccountisdiff(List<Contact> contactallnewrecord,List<Contact> contactalloldrecord ){
        List<contact> lst=new list<contact>();
        for(Contact temp: contactallnewrecord) {
            lst.add(temp);
        }
        for(Contact temp: contactalloldrecord){
            lst.add(temp);
        }
        for(contact singlerecordofcontact : lst){
            AccountRecordIds.add(singlerecordofcontact.accountId);
        }
        if( accountrecordids.size() >= 0){
            accountsrecords=[Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by LastModifiedDate Asc  ) from Account where Id in :AccountRecordIds];            
        }
         if(accountsrecords.size()> = 0) {
            Decimal count=0;
            
             
            for(Account accountsinglercords: accountsrecords){  //we find the the Account object related All Contact Object
                count=accountsinglercords.contacts.size();      //in count we find the size of Contact Object in one Account Object
                for(Contact selectedrecords:contactallnewrecord){
                    if(accountsinglercords.Id == selectedrecords.AccountId ){
                        selectedrecords.Sequence_Number__c =count-1;
                        count--;
                    }
                    else if(accountsinglercords.Id != selectedrecords.AccountId ) {
                         selectedrecords.Sequence_Number__c =count+1;
                        	count++;
                    }
                    
                }
            }	 
        }
        /*if(accountsrecords.size()>=0){
            Decimal seqnum=0;
            for(Account singleaccountrecord:accountsrecords){
                seqnum=0;
                for(Contact selectedrecords:singleaccountrecord.Contacts ){
                    seqnum=selectedrecords.Sequence_Number__c=seqnum+1;
                    forcontactrecordlist.add(selectedrecords); 
                }
            }	
            update  forcontactrecordlist;
        }  */
    }
    
    public void forundeletRecordIn( List<Contact> contactAllNewRecord) {
  
        Map<ID ,Account> accMap= new map<ID ,Account>();
        for(Contact singlerecordofcontact:contactAllNewRecord) {
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        System.debug('------>' +accountrecordids.size());      
        if( accountrecordids.size() >= 0){
            accMap= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by CreatedDate Asc ) from Account where Id in :accountrecordids]);            
        }
        System.debug(accountsrecords.size());
        if(accountsrecords.size()> = 0) {
            
            //Decimal count = 0;
            for(Contact con:contactAllNewRecord) {
                System.debug(con.Sequence_Number__c);
                for(Contact selectedrecords:accMap.get(con.Accountid).Contacts ) {
                    System.debug(selectedrecords.Sequence_Number__c);
                    System.debug(selectedrecords.Sequence_Number__c > con.Sequence_Number__c);
                    
                    if(selectedrecords.Sequence_Number__c >= con.Sequence_Number__c) {
                       
                       	
                         selectedrecords.Sequence_Number__c = selectedrecords.Sequence_Number__c + 1;
                       
                             forcontactoldrecordlist.add(selectedrecords);                        
                    }
                }
            }	
            update  forcontactoldrecordlist ;
        }
        
        
       /* for(Contact singlerecordofcontact:contactallNewRecord) {
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        System.debug(accountrecordids.size());      
        if( accountrecordids.size() >= 0){
            accMap= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by CreatedDate Asc ) from Account where Id in :accountrecordids]);            
        }
         if(accountsrecords.size()> = 0) {
            Decimal seqnum = 0;
            for(Contact con:contactallNewRecord) {
                System.debug(con.Sequence_Number__c);
                for(Contact selectedrecords:accMap.get(con.Accountid).Contacts ) {
                    System.debug(selectedrecords.Sequence_Number__c);
                    System.debug(selectedrecords.Sequence_Number__c > con.Sequence_Number__c);
                    if(selectedrecords.Sequence_Number__c >= con.Sequence_Number__c){
                        selectedrecords.Sequence_Number__c=(selectedrecords.Sequence_Number__c+1);
                        forcontactoldrecordlist.add(selectedrecords);
                    }
                }
            }	
            update  forcontactoldrecordlist ;
         }
        
        /*for(Contact singlerecordofcontact:contactallnewrecord){
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        if( accountrecordids.size() >= 0){
            accountsrecords=[Select  ID,Name,(Select Id,Name,Sequence_Number__c from Contacts ORDER BY Sequence_Number__c Asc ) from Account where Id in :accountrecordids];            
        }
        if(accountsrecords.size()> = 0){
            Decimal count = 0;   
            for(Account singleaccountrecord:accountsrecords){
                   for(Contact selectedrecords:singleaccountrecord.contacts){
                //for(Contact selectedrecords : contactallNewRecord) {
              //  for(Contact selectedrecords : contactallNewRecord) {
              // if(singleaccountrecord.Id == selectedrecords.AccountId ){
                   // selectedrecords.Sequence_Number__c =count+1;
                    count=selectedrecords.Sequence_Number__c = count+1;
                   // count++;
                    forcontactrecordlist.add(selectedrecords);
                }
              //  }
            }	
            update    forcontactrecordlist;
        }*/
        
    }
    
    
    
    
    
    public void forDeleterec( List<Contact> contactalloldRecord) {
        Map<ID ,Account> accMap= new map<ID ,Account>();
        
        for(Contact singlerecordofcontact:contactalloldrecord) {
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        System.debug(accountrecordids.size());      
        if( accountrecordids.size() >= 0){
            accMap= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by CreatedDate Asc ) from Account where Id in :accountrecordids]);            
        }
        System.debug(accMap.size());
        if(accountsrecords.size()> = 0) {
            Decimal seqnum = 0;
            for(Contact con:contactalloldRecord) {
                System.debug(con.Sequence_Number__c);
                for(Contact selectedrecords:accMap.get(con.Accountid).Contacts ) {
                    System.debug(selectedrecords.Sequence_Number__c);
                    System.debug(selectedrecords.Sequence_Number__c > con.Sequence_Number__c);
                    if(selectedrecords.Sequence_Number__c > con.Sequence_Number__c){
                        selectedrecords.Sequence_Number__c=(selectedrecords.Sequence_Number__c-1);
                        forcontactoldrecordlist.add(selectedrecords);
                    }
                }
            }	
            update  forcontactoldrecordlist ;
        }
    }    
}