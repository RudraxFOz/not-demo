@IsTest
public class AccountProcessorTest {
    public static testmethod void TestAccountProcessorTest() 
    {
        Account acc = new Account();
        acc.Name = 'Test Account';
        Insert acc;

        Contact cont = New Contact();
        cont.FirstName ='Bob';
        cont.LastName ='Masters';
        cont.AccountId = acc.Id;
        Insert cont;
        
        set<Id> setAccId = new Set<ID>();
        setAccId.add(acc.id);
 
        Test.startTest();
            AccountProcessor.countContacts(setAccId);
        Test.stopTest();
        
        Account accList = [select Number_of_Contacts__c from Account where id = :acc.id LIMIT 1];
        System.assertEquals ( Integer.valueOf(accList.Number_of_Contacts__c) ,1);
  }
  
}