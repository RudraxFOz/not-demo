@isTest
public with sharing class AProductHomeController1Test {
    static testMethod void testAccountList (){
    Product2 pro = new Product2();
    pro.Name = 'Test Name';
    insert pro;

    Product_Attribute_Value__c  proValue = new Product_Attribute_Value__c();
    proValue.Value__c = 'Test';
     Test.startTest();
       ProductHomeController1.fetchParentRecords();
        ProductHomeController1.fetchChildRecords('4545fg4534543');
    Test.stopTest();
    // Account ACC1 = [select Name from Account LIMIT 1];
    //     System.assertEquals ( String.valueOf(acc1.Name) ,'Test Name');
    }
}