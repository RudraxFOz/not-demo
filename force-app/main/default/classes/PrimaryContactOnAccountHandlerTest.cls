@IsTest
public with sharing class PrimaryContactOnAccountHandlerTest {
   
 public static boolean isExecuting = false;
    static testMethod void insertConLst () {
        List<Contact> testCon = new List<Contact>();
        List<Account> accountToUpdate = new List<Account>();
        List<Contact> lst = [SELECT Id,Name,ConditionCheack__c FROM Contact ];
        Account acc = new Account();
        //acc.Id = '0016F00003M9r81';
        acc.Name = 'suresh';
        insert acc ;
        for( Integer i=0; i<4; i++ ) {
            Contact con = new Contact();
            
            if ( con.accountId != null ) {
                con.accountId = acc.Id ;
                con.lastName = 'khadda' ;
                con.ConditionCheack__c = true ;
            } else {
                con.accountId = acc.Id ;
                con.lastName = 'khadda' ;
                con.ConditionCheack__c = true ;
            }
            testCon.add(con);
        }  

       
        test.startTest();
            insert testCon;
            PrimaryContactOnAccountHandler.isExecuting = false; 
            update testCon;  
        test.stopTest();
    } 



    static testMethod void deleteConLst () {
        List<Contact> testCon = new List<Contact>();
        List<Account> accountToUpdate = new List<Account>();
        List<Contact> lst = [SELECT Id,Name,ConditionCheack__c FROM Contact ];
        Account acc = new Account();
        //acc.Id = '0016F00003M9r81';
        acc.Name = 'suresh';
        insert acc ;
        for( Integer i=0; i<4; i++ ) {
            Contact con = new Contact();
            con.accountId = acc.Id ;
            con.lastName = 'khadda' ;
            if ( i == 1 ) {
                con.ConditionCheack__c = true ;
            }
            con.ConditionCheack__c = false ;
            testCon.add(con);
        }  

        for( Contact con : lst ) {
            if(con.ConditionCheack__c == true) {
                con.addError('can not deltee');
            }
        }

        
        test.startTest();
            insert testCon;
            delete testCon;
        test.stopTest();


    }

    
}