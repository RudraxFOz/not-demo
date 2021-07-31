public class SequnceC {
  

  public static boolean isexecuted = true;
    
    
List<Contact> forupdatecontactrecord = new List<Contact>(); 
  
  Set<Id> accountrecordIds = new Set<Id>();
   
 List<Account> accountsrecords = new List<Account>();
 
   List<Contact> forcontactoldrecordlist = new List<Contact>();
  
  List<Contact> forcontactrecordlist = new List<Contact>();
  
  public Integer i=1;  
   
 public void forInsertRecordInSequenceField( List<Contact> contactallNewRecord) //   sequence_number__c   sequence_number__c
 
   {                
      
  for(Contact singlerecordofcontact:contactallnewrecord)
        {    
       
            accountrecordids.add(singlerecordofcontact.accountID); 
   
     }
        if( accountrecordids.size() > 0){
            accountsrecords=[Select  Id,Name,(Select Id,Name,sequence_number__c from Contacts ) from Account where Id in :accountrecordids];            
        }
        
        if(accountsrecords.size()> = 0){
            Decimal count=0;
            System.debug('++'+ count);
            for(Account accountsinglercords: accountsrecords){
                count=accountsinglercords.contacts.size();
                for(Contact selectedrecords:contactallNewRecord){
                    if(accountsinglercords.Id == selectedrecords.AccountId ){
                        selectedrecords.sequence_number__c =count+1;
                        count++;
                    }
                    
                }
            }	  
        }
        
    }
    
    
    

    public void forundeletRecordIn( List<Contact> contactallNewRecord) {
        
        for(Contact singlerecordofcontact:contactallnewrecord){
            accountrecordids.add(singlerecordofcontact.accountID);
        }
        if( accountrecordids.size() >= 0){
            accountsrecords=[Select  ID,Name,(Select Id,Name,sequence_number__c from Contacts Order by createddate Asc ) from Account where Id in :accountrecordids];            
        }
        if(accountsrecords.size()> = 0){
            Decimal count = 0;   
            for(Account singleaccountrecord:accountsrecords){
                for(Contact selectedrecords:singleaccountrecord.contacts){
                    
                    count=selectedrecords.sequence_number__c = count+1;
                    
                    forcontactrecordlist.add(selectedrecords);
                }
            }	
            update    forcontactrecordlist;
        }
        
    }
    
    
    
    
    
    public void forDeleterec( List<Contact> contactalloldRecord) {
       List<Account> accountofoldcontact= new List<Account>();
        	for(Contact singlerecordofcontact:contactalloldrecord) {
            accountrecordids.add(singlerecordofcontact.accountID);
        	}
        
        System.debug(accountrecordids.size());    
        
        if( accountrecordids.size() > 0){
            accountofoldcontact= [Select  Id,Name,(Select Id,Name,sequence_number__c from Contacts Order by sequence_number__c Asc ) from Account where Id in :accountrecordids];            
        }
        
        System.debug(accountofoldcontact.size());
        if(accountrecordids.size()>  0) {
            Decimal seqnum = 0;
            for(Account acc:accountofoldcontact) {
                for(Contact selectedrecords: acc.contacts) {
                        seqnum=selectedrecords.sequence_number__c=seqnum+1;
                        forcontactoldrecordlist.add(selectedrecords); 
                }
            }	
            
            System.debug(forcontactrecordlist);
            update  forcontactoldrecordlist ;
        }
          
    }
    public void forbefupdate(List<contact> contactnewlist ,Map<Id,Contact> oldvaluecontact) {
        //Map<Id ,Account> accountofoldcontact= new map<ID ,Account>();
        Map<Id ,Account> accountofnewcontact= new map<ID ,Account>();
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
         
          //  accountofoldcontact= new map<id ,Account>([Select  Id,Name,(Select Id,Name,sequence_number__c from Contacts Order by sequence_number__c Asc ) from Account where Id in :accountrecordIds]);
            accountofnewcontact= new map<id,Account>([Select  Id,Name,(Select Id,Name,sequence_number__c from Contacts Order by sequence_number__c Asc ) from Account where Id in :accountofnewcontactIds]);            
        }
        for(Contact con:contactnewlist) {
            Decimal sequn=0;
            //system.debug('Line 206');
            if(con.accountId<>oldvaluecontact.get(con.Id).accountId && con.accountId<>null){
                
                //system.debug('accountofoldcontact.get(con.AccountId).Contacts.size()');
                
                sequn=accountofnewcontact.get(con.accountId).Contacts.size();
                con.sequence_number__c=sequn+1;
                
            }   
            
        }  
        CheackRev.run=true;  
    }
    
    
    public void forafupdate(List<Contact>contactoldrecord,Map<id,Contact>contactallnewrecord) {
        Map<id,Account> accountofoldcontact=new Map<id,Account>(); 
         Map<id,Account> accountofnewcontact=new Map<id,Account>();
         Set<Id>accountallnewrecordids=new Set<Id>(); 
        System.debug('after update');
        
        for(Contact con:contactoldrecord) {
            accountrecordids.add(con.AccountId);
            accountallnewrecordids.add(contactallnewrecord.get(con.Id).accountId);
        }
        if( accountrecordids.size() > 0){
            accountofoldcontact= new map<id ,Account>([Select  Id,Name,(Select Id,Name,sequence_number__c from Contacts Order by sequence_number__c Asc ) from Account where Id in :accountrecordids]);
            accountofnewcontact= new map<id ,Account>([Select  Id,Name,(Select Id,Name,sequence_number__c from Contacts Order by sequence_number__c Asc ) from Account where Id in :accountallnewrecordids]);               
        }
        for( Contact con:contactoldrecord){
            if(con.accountid==null){
                Decimal sequn=0;
                for(Contact con2:accountofoldcontact.get(con.accountId).Contacts){
                    sequn=con2.sequence_number__c=sequn+1;
                    System.debug('con2.sequence_number__c'+con2.sequence_number__c);
                    forcontactrecordlist.add(con2);
                }
                
            }        
            else if(con.accountId<>null) {      
                Decimal sequn=0;
                for(Contact con1:accountofoldcontact.get(con.AccountId).Contacts){
                    sequn=con1.sequence_number__c=sequn+1;
                    forcontactrecordlist.add(con1);
                }
            }
            else if(con.sequence_number__c <> contactallnewrecord.get(con.Id).sequence_number__c && con.accountId==contactallnewrecord.get(con.Id).Id ){
               
               if(con.sequence_number__c>contactallnewrecord.get(con.Id).sequence_number__c){
                    for(Contact con3: accountofnewcontact.get(contactallnewrecord.get(con.Id).accountid).Contacts){
                        if(contactallnewrecord.get(con3.Id).sequence_number__c>contactallnewrecord.get(con.Id).sequence_number__c && con3.Id <> con.id){
                            con3.sequence_number__c= con3.sequence_number__c+1;
                            forcontactrecordlist.add(con3);

                        }
                    }  
               }
               else if(con.sequence_number__c<contactallnewrecord.get(con.Id).sequence_number__c){
                    for(Contact con3: accountofnewcontact.get(contactallnewrecord.get(con.Id).accountid).Contacts){
                        if(contactallnewrecord.get(con3.Id).sequence_number__c>con.sequence_number__c && con3.Id<>con.id){
                            con3.sequence_number__c= con3.sequence_number__c-1;
                            forcontactrecordlist.add(con3);
                        }   
                    }
               }
            } 
        }     
        
        update    forcontactrecordlist;
    }
    
}