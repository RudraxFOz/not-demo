//this class is used for handler class for SequenceNumber Trigger.

public class JaiHo {   //  Sequence_Number__c
      
    Set<Id> accountrecordids = new Set<Id>();
    List<Account> accountsrecords = new List<Account>();
    List<Contact> forcontactoldrecordlist = new List<Contact>();
    List<Contact> forcontactrecordlist = new List<Contact>();
    
    // this method is used for insert case and update the sequance number. 
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
            for(Account accountsinglercords: accountsrecords){
                count=accountsinglercords.contacts.size();
                for(Contact selectedrecords:contactallNewRecord){
                    if(accountsinglercords.Id == selectedrecords.AccountId ){
                        selectedrecords.Sequence_Number__c =count+1;
                        count++;
                    }
                    
                }
            }	  
        }
        
    }
    
    
//this method for undelete time update the sequance number.    
    
    public void forundeletRecordIn( List<Contact> contactallNewRecord) {
        
        for(Contact singlerecordofcontact:contactallnewrecord){
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        if( accountrecordids.size() >= 0){
            accountsrecords=[Select  ID,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by CreatedDate   Asc ) from Account where Id in :accountrecordids];            
        }
        if(accountsrecords.size()> = 0){
            Decimal count = 0;   
            for(Account singleaccountrecord:accountsrecords){
                count= singleaccountrecord.contacts.size()-contactallNewRecord.size();
                for(Contact selectedrecords: contactallNewRecord){
                    Contact force =new Contact(Id= selectedrecords.id);
                    count=force.Sequence_Number__c = count+1 ;
                    
                    forcontactrecordlist.add(force);
                }
            }	
            update    forcontactrecordlist;
        }
        
    }
    
    
    
 //this method is used for delete case.   
    
    public void forDeleterec( List<Contact> contactalloldRecord) {
        List<Account> accountofoldcontact= new List<Account>();
        for(Contact singlerecordofcontact:contactalloldrecord) {
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        
        System.debug(accountrecordids.size());    
        
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
            
            System.debug(forcontactrecordlist);
            update  forcontactoldrecordlist ;
        }
        
    }
    
//this method is used for before update case.
    
    public void forbefupdate(List<contact>contactnewlist ,Map<Id,Contact>oldvaluecontact) {
        Map<Id ,Account> accountofoldcontact= new map<ID ,Account>();
        List<Account> accountofnewcontact= new List<Account>();
        Map<Id ,Contact> contactoldrecordupdate= new map<ID ,Contact>();
        Set<Id>accountofnewcontactIds=new set<Id>();
        System.debug(contactnewlist+','+oldvaluecontact);
        if(contactnewlist.size()>0){
            for(Contact con:contactnewlist){
                accountrecordIds.add(oldvaluecontact.get(con.Id).AccountId);
                accountofnewcontactIds.add(con.AccountId);
            }
        }   
        if( accountrecordids.size() > 0){
            accountofoldcontact= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountrecordids]);
        }
        if(accountofnewcontactIds.size()>0){  
            accountofnewcontact= [Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountofnewcontactIds];            
        }
         Decimal sequn=0;
      
        for(Account acc:accountofnewcontact){
            sequn=acc.contacts.size();
            
        for(Contact con:acc.contacts) {
            
            system.debug('Line 206');
            
          //  if(con.accountId<>oldvaluecontact.get(con.Id).accountId && con.accountId<>null){
                
                system.debug('accountofoldcontact.get(con.AccountId).Contacts.size()');
                
                
                sequn=con.Sequence_Number__c=sequn+1;
            }    
                
            
            
            
        }  
        CheackRev.run=true; 
        
        
    }
    
//for update the sequance number in after update case.

    public void forafupdate(List<Contact>contactoldrecord,Map<id,Contact>contactallnewrecord) {
        Map<id,Account> accountofoldcontact=new Map<id,Account>(); 
        Map<id,Account> accountofnewcontact=new Map<id,Account>();
        Set<Id>accountallnewrecordids=new Set<Id>(); 
        System.debug('after update'+contactallnewrecord);
        
        for(Contact con:contactoldrecord) {
            accountrecordids.add(con.AccountId);
            accountallnewrecordids.add(contactallnewrecord.get(con.Id).accountId);
        }
        if( accountrecordids.size() > 0){
            accountofoldcontact= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountrecordids]);
            accountofnewcontact= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by Sequence_Number__c Asc ) from Account where Id in :accountallnewrecordids]);               
        }
        for( Contact con:contactoldrecord){
            
            if(con.accountid!=null && contactallnewrecord.get(con.id).accountid==null ){
                Decimal sequn=0;
                for(Contact con2:accountofoldcontact.get(con.accountId).Contacts){
                    sequn=con2.Sequence_Number__c=sequn+1;
                    System.debug('con2.Sequence_Number__c'+con2.Sequence_Number__c);
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
            //for sequnce number this loopis working.
             else if(con.Sequence_Number__c <> contactallnewrecord.get(con.Id).Sequence_Number__c && con.accountId==contactallnewrecord.get(con.Id).accountid ){
               
               if(con.Sequence_Number__c>contactallnewrecord.get(con.Id).Sequence_Number__c){
                    for(Contact con3: accountofoldcontact.get(con.accountid).Contacts){
                        System.debug('series sequnce number'+con3.Sequence_Number__c+'contactallnewrecord.get(con.Id).Sequence_Number__c'+contactallnewrecord.get(con.Id).Sequence_Number__c);
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
            else if(con.AccountId==null && contactallnewrecord.get(con.id).accountid<>null){
                Decimal sequn=0;
                for(Contact con3 : accountofnewcontact.get(contactallnewrecord.get(con.id).accountid).Contacts){
                    sequn=con3.Sequence_Number__c=sequn+1;
                     forcontactrecordlist.add(con3);
                }
                
            } 
        }      
        
        update    forcontactrecordlist;
    
    
      }
}