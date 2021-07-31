public class DeletedAttemptOnAccountHelper {
    
     public Static void deleteRecordOnBefore(Map<Id,Account> oldMapObject){
         

         List<Account> updateAccList = new List<Account>();
         List<Account> listofaccts1 = [SELECT Id, Name,Deleted_Attempt__c, (SELECT Id, Name FROM Contacts )
                           FROM Account where id IN :oldMapObject.keyset()]; 
         for(Account accObj : listofaccts1) { 
               System.debug('==accObj=='+accObj); 
                   System.debug('==accObj.Contacts.size()=='+accObj.Contacts.size());
               Decimal delValueCount = 0;
              //AccountProcessor1.countContacts(accObj.Id);
               //delValueCount = accObj.Deleted_Attempt__c + 1;
               //Account aux = new Account();
               //aux.Id = accObj.Id; 
               //accObj.Deleted_Attempt__c = accObj.Deleted_Attempt__c + 1;
               //updateAccList.add(new Account(Id=accObj.Id, Deleted_Attempt__c=delValueCount));
               //updateAccList.add(accObj);
               //update updateAccList;
               
               if(accObj.Contacts.size()!=0) {
                   
                	Account actualRecord = oldMapObject.get(accObj.Id); 
        			//actualRecord.adderror('Cant Delete');
        			//System.debug('==Account Delete==');
        	   }
          }
          
         try{
             if(updateAccList.size()>=1){
                 //System.debug('==updateAccList=='+updateAccList);
                 //update updateAccList;
             } 
         }
         catch(Exception e){
             system.debug('Exception: '+e.getMessage());
         } 
          
         
         List<Account> listofaccts = [SELECT Id, Name,Deleted_Attempt__c, (SELECT Id, Name FROM Contacts)
                           FROM Account where id IN :oldMapObject.keyset()]; 
         //System.debug('==listofaccts=='+listofaccts); 
     }
    
    @future	
    public Static void deleteRecordOnAfter(Set<Id> oldMapObject){
        
         System.debug('My Test==In=FutureMethod==');
       //database.executeBatch(new BatchApexForContact(),100);
       //deleteRecordOnAfter11(oldMapObject);
        
     }
    
    public Static void deleteRecordOnAfter11(Set<Id> oldMapObject){
        
         System.debug('My Test==In=FutureMethod==111===');
       //database.executeBatch(new BatchApexForContact(),100);
       deleteRecordOnAfter(oldMapObject);
        
     }

}