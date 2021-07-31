@IsTest
public with sharing class PicklistActiveOrNotOnAccHandlerTest {


    static testMethod void insertConLst () {
        
        List<Contact> testCon = new List<Contact>();
        List<Account> accountToUpdate = new List<Account>();
        Account acc = new Account();
        //acc.Id = '0016F00003M9r81';
        acc.Name = 'Tttesttt';
        acc.BillingCity = 'Jaipurrr';
        acc.Statuss__c = 'Not Active';
        insert acc ;
        Opportunity op = new Opportunity();
        op.Name='Deee';
        op.AccountId = acc.Id ;
        op.StageName = 'Prospecting';
        insert op;
        //test.startTest();
           // insert testCon;
            //if(testCon.size() > 0) {
              //  update testCon;  
            //}
        //test.stopTest();

    }
    
}