@isTest
public with sharing class cLookUpComponentControllerTest {

     static testMethod void testAccountList () {
        Account acc = new Account();
        acc.Name = 'Test Name';
        insert acc;
        Test.startTest();
            cLookUpComponentController.fetchValueOfSobject('sur','Account');   
            //ObjectAuraController.saveAccount(acc,1,10);  
        Test.stopTest();
    }
    
}