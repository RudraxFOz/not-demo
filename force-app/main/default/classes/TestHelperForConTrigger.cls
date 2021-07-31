@isTest
public class TestHelperForConTrigger {
   //  HelpClassForSequenceNumberTrigger objectofhelpclass
    // it is check sequance number at the time of insert.
    public static testMethod void  checkInsertRecord(){
        
        Account acct = new Account(Name='shree', Phone='(415)555-1212', NumberOfEmployees=100);                                       
        insert acct;
        Account acct1 = new Account(Name='rajat', Phone='(415)555-1212', NumberOfEmployees=100);
        insert acct1;
        List<Contact>records = new List<Contact>{
                                                 new Contact(FirstName='First',LastName='Smith',Department='Finance',Accountid=acct.Id),
                                                 new Contact(FirstName='Second',LastName='kumar',Department='Finance',Accountid=acct.Id),
                                                 new Contact(FirstName='third',LastName='Sam',Department='Finance',Accountid=acct.Id),    
    									         new Contact(FirstName='Jonatha',LastName='sharma',Department='Finance',Accountid=acct1.Id), 
                                                 new Contact(FirstName='Jonatha',LastName='sharma',Department='Finance',Accountid=acct1.Id)
                                                 };
        Test.startTest();
        	insert records;
        Test.stopTest();
        
        
       //for delete the record
         List<Contact> records1 = [ select Id from Contact where LastName='Smith' ]; 
        delete records1;
        
        RecursiveClass.runOnce();
        RecursiveClass.run=true;
        List<Contact> records2 = [ select Id from Contact where LastName='Smith' All Rows ];
        undelete records2;
        
        
        RecursiveClass.runOnce();
        RecursiveClass.run=true;
        List<Contact> record=[Select id,Accountid,Sequence_Number__c,Lastname From Contact where LastName='Smith' ];
        for(Contact con: record ){
        	con.Accountid=acct1.id;
             
        }
        update record;
        
        RecursiveClass.runOnce();
        RecursiveClass.run=true;
        List<Contact> recordforsequncenumber=[Select id,Accountid,Sequence_Number__c,Lastname From Contact where LastName='Smith' ];
        for(Contact con: record ){
        	con.Sequence_Number__c=1;    
        }
        update record;
        
        RecursiveClass.runOnce();
         RecursiveClass.run=true;
     
        for(Contact con: record ){
        	con.Sequence_Number__c=3;    
        }
        update record;
        
        RecursiveClass.runOnce();
        RecursiveClass.run=true;
        for(Contact con: record ){
        	con.Accountid=null;    
        }
        update record;
        
  
    }
}