//this class is used for handler class for SequenceNumber Trigger.

public class HelperForConTrigger {
    
    Set<Id> accountrecordids = new Set<Id>();
    List<Account> accountsrecords = new List<Account>();
    List<Contact> forcontactoldrecordlist = new List<Contact>();
    List<Contact> forcontactrecordlist = new List<Contact>();
    
    // this method is used for insert case and update the sequance number. 
    public void forInsertRecordInSequenceField( List<Contact> contactallNewRecord ) 
    {                
        for(Contact singlerecordofcontact : contactallNewRecord)
        {           
            accountrecordids.add(singlerecordofcontact.accountID); 
        }
        //Sequence_Number__c
        if( accountrecordids.size() > 0){
            accountsrecords=[Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts ) from Account where Id in :accountrecordids];            
        } 
        if(accountsrecords.size()> = 0){
            Decimal count=0;
           
            for(Account accountsinglercords: accountsrecords){
                count=accountsinglercords.contacts.size();
                for(Contact selectedrecords:contactallNewRecord){
                    if(accountsinglercords.Id == selectedrecords.AccountId ){
                        selectedrecords.Sequence_Number__c =count+1;
                        System.debug('selectedrecords : ' + selectedrecords);
                        count++;
                    }
                }
            }	  
        }
        
        
    }
    
    
    //this method for undelete time update the sequance number.    
    
    public void forundeletRecordIn( List<Contact> contactallNewRecord) {
        
        for(Contact singlerecordofcontact:contactallnewrecord){
            accountrecordids.add(singlerecordofcontact.accountId);
        }
        if( accountrecordids.size() >= 0){
            accountsrecords=[Select  ID,Name,(Select Id,Name,Sequence_Number__c from Contacts  Order by Sequence_Number__c   Asc ) from Account where Id in :accountrecordids];            
        }
        if(accountsrecords.size()> = 0){
            Decimal count = 0;   
            for(Account singleaccountrecord:accountsrecords){
                count= singleaccountrecord.contacts.size()-contactallNewRecord.size();
               
                for(Contact selectedrecords: contactallNewRecord){
                    Contact force =new Contact(Id= selectedrecords.id);
                    count++;
                    force.Sequence_Number__c = count ;
                    
                    forcontactrecordlist.add(force);
                }
            }	
            update forcontactrecordlist;
        }
        
    }
    
    
    
    /*public void forundeletRecordIn(List<Contact> newRecord)
     {
         if(RecursiveClass.runOnce())
        { 
            Set<ID> uId = new Set<ID>();
             for(Contact cont : newRecord)
             {
                 uId.add(cont.AccountId);
             }
             List<Account> allParentRec = [select Id, (select AccountId , lastName , Sequence_Number__c from contacts ORDER BY Sequence_Number__c asc) from Account where ID IN :(uId)];
             
             Integer maxSize = 0;
             Map<ID , Integer> sizeOfRelatedRec = new Map<ID , Integer>();
             Map<ID , Integer> sizeOfNewRec = new Map<ID , Integer>();
             
             for(Account acc : allParentRec)
             {
                 sizeOfRelatedRec.put(acc.Id , acc.contacts.size());
                 //system.debug('Id is : ' + acc.id + ' Size of Related record is : ' + acc.contacts.size());
             }             
             for(ID newId : uId) 
             {             
                 for(Contact cont : newRecord)
                 {
                     if(newId == cont.AccountId)
                     {
                         maxSize++;
                     }
                 }    
                 sizeOfNewRec.put(newId , maxSize);
                 maxSize = 0;
             }
             List<Contact> temp = new List<Contact>();             
             
             for(Contact cont : newRecord)
             {                     
                 //system.debug('sizeOfNewRec.get(cont.AccountId) : ' + sizeOfRelatedRec.get(cont.AccountId));                
				 //System.debug(' sizeOfNewRec.get(cont.AccountId)  : ' +  sizeOfNewRec.get(cont.AccountId) );                 
                 maxSize =  sizeOfRelatedRec.get(cont.AccountId) - sizeOfNewRec.get(cont.AccountId) + 1;                                                      
                 system.debug('maxSize : ' + maxSize);                 
                 
                 Contact con=new Contact(Id = cont.id , AccountId = cont.AccountId);                 
                 con.Sequence_Number__c = maxSize;                                                               
                 temp.add(con);
                 
                 maxSize = sizeOfNewRec.get(cont.AccountId);
                 sizeOfNewRec.remove(cont.AccountId);
                 //Reduce the size by 1 from newRecord who have already updated
                 sizeOfNewRec.put(cont.AccountId , (maxSize-1));                                                               
             }
             update temp;
         }
     }*/


    
    //this method is used for delete case.   
    
    public void forDeleterec( List<Contact> contactalloldRecord) {
        List<Account> accountofoldcontact= new List<Account>();
        for(Contact singlerecordofcontact:contactalloldrecord) {
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        
        
        
        if( accountrecordids.size() > 0){
            accountofoldcontact= [Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountrecordids];            
        }
        
        System.debug(accountofoldcontact.size());
        if(accountrecordids.size()>  0) {
            Decimal seqnum = 0;
            for(Account acc:accountofoldcontact) {
                for(Contact selectedrecords: acc.contacts) {
                    seqnum=selectedrecords.Sequence_Number__c=seqnum+1;
                    forcontactoldrecordlist.add(selectedrecords); 
                }
            }	
            
        
            update  forcontactoldrecordlist ;
        }
        
    }
    
    //this method is used for before update case.
    
    public void forbefupdate(List<Contact>contactnewlist ,Map<Id,Contact>oldvaluecontact) {
        Map<Id ,Account> accountofoldcontact= new map<ID ,Account>();
        List<Account> accountofnewcontact= new List<Account>();
        Set<Id>accountofnewcontactIds=new set<Id>();
       
        if(contactnewlist.size()>0){
            for(Contact con:contactnewlist){
                accountrecordids.add(oldvaluecontact.get(con.Id).AccountId);
                accountofnewcontactIds.add(con.AccountId);
            }
        }   
        if( accountrecordids.size() > 0){
            accountofoldcontact= new map<id ,Account>([Select  Id,Name,(Select Id,FirstName,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountrecordids]);
        }
        if(accountofnewcontactIds.size()>0){  
            accountofnewcontact= [Select  Id,Name,(Select Id,FirstName,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountofnewcontactIds];            
        }
        Decimal sequn=0;
        
        for(Account acc:accountofnewcontact){
           
            sequn=acc.Contacts.size();
           
            for(Contact con:contactnewlist ) {
                if(con.id==oldvaluecontact.get(con.id).id && con.AccountId <> oldvaluecontact.get(con.id).accountid){      
              
                if(acc.id==con.AccountId){
                  
                   
                    sequn=con.Sequence_Number__c=sequn+1;
                    
                }
             }     
            }
         
        }  
        
        RecursiveClass.run=true;
        
    }
    
    //for update the sequance number in after update case.
    
    public void forafupdate(List<Contact>contactoldrecord,Map<id,Contact>contactallnewrecord) {
        Map<id,Account> accountofoldcontact=new Map<id,Account>(); 
        Map<id,Account> accountofnewcontact=new Map<id,Account>();
        Set<Id>accountallnewrecordids=new Set<Id>(); 
       
        
        for(Contact con:contactoldrecord) {
            accountrecordids.add(con.AccountId);
            accountallnewrecordids.add(contactallnewrecord.get(con.Id).accountId);
        }
        if( accountrecordids.size() > 0){
            accountofoldcontact= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountrecordids]);
            accountofnewcontact= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountallnewrecordids]);               
        }
        for( Contact con:contactoldrecord){
            
            if(con.accountid<>null && contactallnewrecord.get(con.id).accountid==null ){
                Decimal sequn=0;
                for(Contact con2:accountofoldcontact.get(con.accountId).Contacts){
                    sequn=con2.Sequence_Number__c=sequn+1;
                    
                    forcontactrecordlist.add(con2);
                }
                
            }        
            else if(con.accountId<>null && con.AccountId<>contactallnewrecord.get(con.Id).accountid) {      
                Decimal sequn=0;
                for(Contact con1:accountofoldcontact.get(con.AccountId).Contacts){
                    sequn=con1.Sequence_Number__c=sequn+1;
                    forcontactrecordlist.add(con1);
                }
            }
            //for sequnce number this loop is working.
             else if(con.Sequence_Number__c <> contactallnewrecord.get(con.Id).Sequence_Number__c && con.accountId==contactallnewrecord.get(con.Id).accountid ){
               
               if(con.Sequence_Number__c>contactallnewrecord.get(con.Id).Sequence_Number__c){
                    for(Contact con3: accountofoldcontact.get(con.accountid).Contacts){
                        if(con3.Sequence_Number__c>=contactallnewrecord.get(con.Id).Sequence_Number__c&& con3.Sequence_Number__c<con.Sequence_Number__c && con3.Id <> con.id){
                            con3.Sequence_Number__c= con3.Sequence_Number__c+1;
                            forcontactrecordlist.add(con3);

                        }
                    }  
               }
               else if(con.Sequence_Number__c<contactallnewrecord.get(con.Id).Sequence_Number__c){
                    for(Contact con3: accountofoldcontact.get(contactallnewrecord.get(con.Id).accountid).Contacts){
                        if(con3.Sequence_Number__c>con.Sequence_Number__c&& con3.Sequence_Number__c<=contactallnewrecord.get(con.Id).Sequence_Number__c && con3.Id<>con.id){
                            con3.Sequence_Number__c= con3.Sequence_Number__c-1;
                            forcontactrecordlist.add(con3);
                        }   
                    }
               }
            } 
         
        }      
        
        update    forcontactrecordlist;
        
        
    }
}