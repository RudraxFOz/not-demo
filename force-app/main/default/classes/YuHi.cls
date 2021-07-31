public class YuHi {
public void afterUndelete(List<Contact> newRecord)
     {
        // if(RecursiveController.recursionControllerMethod())
        // { 
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
         //}
     }

}