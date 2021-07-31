@isTest
public class TestClassForContact {
    public testMethod static void cheackValueForInsert() {
         //List<Contact> contactallNewRecord = new List<Contact>(new );
        Account testAcc = new Account(Name='NK');
        insert testAcc;
        
        Contact testCon = new Contact(AccountId=testAcc.Id, FirstName__c='Suresh', LastName='Khadda', City__c='Jaipur');
        
        Test.startTest();
        insert testCon;
        Test.stopTest();
        

       // c.AccountId=a.Id;
        //c.FirstName__c='Suresh';
        //c.LastName__c='Khadda';
       // c.City__c='Jaipur';
       //insert c;
        //System.debug(c.FirstName__c);
        //HelpClassForSequenceNumberTrigger helpObj = new HelpClassForSequenceNumberTrigger();
        //contactallNewRecord.add(c);
       // update contactallNewRecord;
        //helpObj.forInsertRecordInSequenceField(c);
    }
    public testMethod static void cheackValueForDelete() {
        Account a = new Account();
         Account testAcc = new Account(Name='Gbnn');
        insert testAcc;
          Contact c = new Contact();
       list<Contact> testCon = new list<Contact>();
        list<Contact> con = new list<Contact>();
        /*new Contact(AccountId=testAcc.Id, Sequence_Number__c=1, FirstName__c='Shivay', LastName='Kha', City__c='Jaipur'),new Contact(AccountId=testAcc.Id, Sequence_Number__c=2, FirstName__c='Shivay', LastName='Kha', City__c='Jaipur')*/
        for(Integer i=1; i<5; i++) {
                c.Sequence_Number__c = 1;
                c.FirstName__c = 'Shivay';
                c.LastName = 'Khadda';
                c.AccountId=a.Id;
            c.sequence_number__c++;
        }
        //testCon.add(c.AccountId=a.Id, c.Sequence_Number__c=1, c.FirstName__c='Shivay', c.LastName='Kha', c.City__c='Jaipur');
        testCon.add(c);
        insert testCon;
       // set<Id> accountrecordids = new set<Id>();
       /*  Map<ID ,Account> accMap= new map<ID ,Account>();
        
         accMap= new map<id ,Account>([Select  Id,Name,(Select Id,Name,Sequence_Number__c from Contacts Order by CreatedDate Asc ) from Account ]);  
         for(Contact con1 : testCon) {
             for(Contact selectedrecords : accMap.get(con1.Accountid).Contacts ) {
                if(selectedrecords.Sequence_Number__c > con1.Sequence_Number__c){
                   selectedrecords.Sequence_Number__c=(selectedrecords.Sequence_Number__c-1);
                            con.add(selectedrecords);
                 }
             }
        }*/
        try
			{
				Delete 	testCon;
			}
			catch(Exception ee)
			{}
    }
    public testMethod static void cheackValueForUndelete() {
        Account testAcc = new Account(Name='Trump');
        insert testAcc;
        Contact testCon = new Contact(AccountId=testAcc.Id, FirstName__c='Shivay', LastName='Kha', City__c='Jaipur');
         insert testCon;
        try
			{
				Delete 	testCon;
			}
			catch(Exception ee)
			{}
        
        //Contact[] testConUndelete = [SELECT Id, Name FROM Account WHERE Name='Trump' ALL ROWS]; 
        
        undelete testCon;
    }
    public testMethod static void cheackValueForUpdate() {
        Account testAcc = new Account(Name='Trump');
        insert testAcc;
        Contact testCon1 = new Contact(AccountId=testAcc.Id, FirstName__c='Shivay', LastName='Kha', City__c='Jaipur');
        insert testCon1;
        Contact testCon2 = new Contact(AccountId=testAcc.Id, FirstName__c='Shivay', LastName='Kha', City__c='Jaipur');
        insert testCon2;
         Contact testCon3 = new Contact(AccountId=testAcc.Id, FirstName__c='Shivay', LastName='Kha', City__c='Jaipur');
        insert testCon3;
         Contact testCon4 = new Contact(AccountId=testAcc.Id, FirstName__c='Shivay', LastName='Kha', City__c='Jaipur');
        insert testCon4;
        Contact con2 = [Select Id, Name, Sequence_Number__c From Contact Where Id =: testCon2.Id];
        System.debug(con2.Sequence_Number__c);
        con2.Sequence_Number__c = 4;
        update con2;
    }
  /*  public testMethod static void bulkifedInsertaion() {
         Account a = new Account(Name='NK');
        insert a;
          Contact[] contactsToCreate = new Contact[]{};
               for(Integer x=0; x<200;x++){
            Contact ct = new Contact(AccountId=a.Id, FirstName__c='Suresh', LastName__c='Khadda', City__c='Jaipur');
            contactsToCreate.add(ct);
        }
        Test.startTest();
        insert contactsToCreate;
        Test.stopTest();

    }*/
}