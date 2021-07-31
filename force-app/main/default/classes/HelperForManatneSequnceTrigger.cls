public class HelperForManatneSequnceTrigger {

     public static boolean isexecuted = true;    
    
    List<Contact> forupdatecontactrecord = new List<Contact>(); 
    Set<Id> accountRecordIds = new Set<Id>();                   
    List<Account> accountRecord = new List<Account>();
    List<Contact> contactRecord = new List<Contact>();
    List<Contact> forcontactrecordlist = new List<Contact>();
    Integer i = 1;
   /* This Method is Use for Insert the New Record */
    public void forInsertRecord( List<Contact> contactAllNewRecord) {
                   
        for( Contact singlerecordofcontact : contactAllNewRecord) {
                 
            accountRecordIds.add(singlerecordofcontact.accountID); 
        }
        if( accountRecordIds.size() > 0) {  
        
            accountRecord=[Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts ORDER BY Sequence_Number__c ASC ) from Account where Id in :accountRecordIds];            
        }
        
        if(accountRecord.size()> = 0){
            Decimal count=0;
            for(Account accountsinglercords: accountRecord) {  
                count=accountsinglercords.contacts.size(); 
                system.debug(count);
                for(Contact selectedrecords:contactAllNewRecord) {
                    if(accountsinglercords.Id == selectedrecords.AccountId ) {
                        selectedrecords.Sequence_Number__c =count+1;
                        count++;
                    }
                }
            }	 
        } 
    }
    
    /* This Method is use For Delete The Record */
    public void forDeleteRecord( List<Contact> contactAllOldRecord) {
        Map<ID ,Account> accMap= new map<ID ,Account>();
        
        for(Contact singlerecordofcontact : contactAllOldRecord) {
            accountrecordids.add(singlerecordofcontact.accountID);
        }
             
        if( accountrecordids.size() >= 0){
            accMap= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by CreatedDate Asc ) from Account where Id in :accountrecordids]);            
        }
       System.debug(accMap);
        if(accountRecord.size()> = 0) {
            Decimal seqnum = 0;
            for(Contact con:contactAllOldRecord) {
                for(Contact selectedrecords:accMap.get(con.Accountid).Contacts ) {
                    if(selectedrecords.Sequence_Number__c > con.Sequence_Number__c){
                        selectedrecords.Sequence_Number__c=(selectedrecords.Sequence_Number__c-1);
                        contactRecord.add(selectedrecords);
                    }
                }
            }	
            update  contactRecord ;
        }
    }    
    
    /* This Method is Work For Undelete The Record */
    public void forUndeleteRecord(List<Contact> undeletedContacts) {
       List<Contact> conList1 = new List<Contact>();
         List<Contact> conList = new List<Contact>();
        //Map<ID ,Account> accMap= new map<ID ,Account>();
       for(Contact delCon : undeletedContacts) {            
            accountRecordIds.add(delCon.accountID);
             system.debug(accountRecordIds);
          system.debug(delCon.accountID);
        }
        
        if( accountrecordids.size() > 0){
            accountRecord=[Select  Id,Name,(Select Id,Name,sequence_number__c from Contacts ) from Account where Id in :accountrecordids];            
        }
        
        if(accountRecord.size()> = 0){
            Decimal count=0;
            System.debug('++'+ count);
            Integer siz = undeletedContacts.size();
            for(Account accountsinglercords: accountRecord){
               // count=accountsinglercords.contacts.size()-undeletedContacts;
                for(Contact selectedrecords:undeletedContacts){
                     count=accountsinglercords.contacts.size()-siz;
                    if(accountsinglercords.Id == selectedrecords.AccountId  ){
                        selectedrecords.sequence_number__c =count+1;
                        count++;
                    }
                    
                }
            }	  
        }
        
        
        /* if( accountrecordids.size() >= 0){
            accMap= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by CreatedDate Asc ) from Account where Id in :accountrecordids]);            
        }
       System.debug(accMap);
        if(accountRecord.size()> = 0) {
            Decimal seqnum = 0;
            for(Contact con:undeletedContacts) {
                for(Contact selectedrecords:accMap.get(con.Accountid).Contacts ) {
                    if(selectedrecords.Id != con.Id && selectedrecords.Sequence_Number__c >= con.Sequence_Number__c){
                        selectedrecords.Sequence_Number__c=selectedrecords.Sequence_Number__c+1;
                       // contactRecord.add(selectedrecords);
                    }
                }
            }	
            update  conList ;
        }*/
       
        //contactRecord
              //  System.debug('____'+contactRecord);

     /* if( accountRecordIds.size() >= 0) {
           // accountRecord=[Select  ID,Name,(Select Id,Name,sequence_number__c from Contacts Order by sequence_number__c Asc ) from Account where Id in :accountRecordIds]; 
        conList = [Select Id, Name, Sequence_Number__c From Contact Where AccountId IN : accountRecordIds];          
        }
      //  System.debug('____'+conList);
        for( Contact delCon : undeletedContacts ) {
            system.debug(delCon);
            for( Contact con : conList ) {
                system.debug(conList);
                	 System.debug(con.sequence_number__c + '-----' + con.Id);
                    System.debug(delCon.sequence_number__c + '-----' + delCon.Id);
                 //System.debug(con.Id != delCon.Id && con.sequence_number__c >= delCon.sequence_number__c);
                if(con.Id != delCon.Id && con.sequence_number__c >= delCon.sequence_number__c) {
                   // System.debug(con.Id != delCon.Id && con.sequence_number__c >= delCon.sequence_number__c);
                   // System.debug(con.sequence_number__c + '-----' + con.Id);
                    //System.debug(delCon.sequence_number__c + '-----' + delCon.Id);
                    //System.debug( '-------------------------------------------' );
                    con.sequence_number__c  = con.sequence_number__c + 1;
                  //  conList.add(con);
                  
                }
                
               contactRecord.add(con);
            }
            
        }
        update contactRecord;
         System.debug('____'+contactRecord);*/
      
    }
    
    
    public void forUpdateRecord( Contact contactallnewrecord, Contact contactalloldrecord ) {
        Decimal lmt=1;
       
       accountrecordids.add(contactallnewrecord.accountID);
        List<Contact> contactsameaccountrecord = [Select id,name,Sequence_Number__c from Contact where accountid = :accountrecordids];
     system.debug(contactsameaccountrecord);
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
            accountRecord=[Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by LastModifiedDate Asc  ) from Account where Id in :AccountRecordIds];            
        }
         System.debug(accountRecord);
         if(accountRecord.size()> = 0) {
            Decimal count=0;
            
             
            for(Account accountsinglercords: accountRecord){  //we find the the Account object related All Contact Object
                count=accountsinglercords.contacts.size();      //in count we find the size of Contact Object in one Account Object
                for(Contact selectedrecords:contactallnewrecord){
                    if(accountsinglercords.Id == selectedrecords.AccountId ){
                        selectedrecords.Sequence_Number__c =count+1;
                        count++;
                         forupdatecontactrecord.add(selectedrecords);
                    }
                    update forupdatecontactrecord;
                }
            }
              for(Account accountsinglercords: accountRecord){  //we find the the Account object related All Contact Object
                count=accountsinglercords.contacts.size();      //in count we find the size of Contact Object in one Account Object
                for(Contact selectedrecords:contactalloldrecord){
                    if(accountsinglercords.Id == selectedrecords.AccountId ){
                        selectedrecords.Sequence_Number__c =count-1;
                        count--;
                         forupdatecontactrecord.add(selectedrecords);
                    }
                       update forupdatecontactrecord;
                    system.debug('');
                    /*else if(accountsinglercords.Id != selectedrecords.AccountId ) {
                         selectedrecords.Sequence_Number__c =count+1;
                        	count++;
                         forupdatecontactrecord.add(selectedrecords);
                    }
                    update forupdatecontactrecord;
                }*/
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
     }
    
}