@IsTest
public with sharing class AObjectAuraControllerTest {
    
        @testSetup static void setup() {
        // Create common test accounts
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;        
    }

    static testMethod void testAccountList () {
        Account acc = new Account();
        acc.Name = 'Test Name';
        insert acc;
        Test.startTest();
            ObjectAuraController.getAccountData(1,10);   
            //ObjectAuraController.saveAccount(acc,1,10);  
        Test.stopTest();
    }


    static testMethod void saveAccountTest () {
        Account acc = new Account();
        acc.Name = 'Test Name';
        //insert acc;
        Test.startTest();
            //ObjectAuraController.getAccountData(1,10); 
            //Account ac = new Account();  
            ObjectAuraController.saveAccount(acc,1,10);   
        Test.stopTest();

    }


   /* static testMethod void editAccountOneTest () {
        Account acc = new Account();
        acc.Name = 'Test Name';
        //insert acc;
        Test.startTest();
            //ObjectAuraController.getAccountData(1,10); 
            //Account ac = new Account();  
            ObjectAuraController.editAccountOne(acc,'104345dfd');    
            //update acc;
        Test.stopTest();

    }*/


    static testMethod void saveContactTest () {
        Account acc = [SELECT id FROM Account LIMIT 1];
        Contact con  = new Contact();
        con.FirstName = 'conatactName';
        con.LastName = 'conatactName';
        Test.startTest();    
            ObjectAuraController.saveContact(con,acc.Id);     
        Test.stopTest();

    }


    
    static testMethod void delteAccountByIdTest () {
        Account acc = [SELECT id FROM Account LIMIT 1];
        // Contact con  = new Contact();
        // con.FirstName = 'conatactName';
        // con.LastName = 'conatactName';
        Test.startTest();    
            ObjectAuraController.delteAccountById(acc.Id,1,10);     
        Test.stopTest();

    }

    static testMethod void saveUpdateRecordTest () {
        Account acc = [SELECT id FROM Account LIMIT 1];
        // Contact con  = new Contact();
        // con.FirstName = 'conatactName';
        // con.LastName = 'conatactName';
        Test.startTest();    
            ObjectAuraController.saveUpdateRecord(acc.Id,1,10);     
        Test.stopTest();

    }


    
}