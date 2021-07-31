@isTest
public class AllInOneTest {
    static testMethod void cheackValid() {
        AllInOne__c c = new AllInOne__c(First_Name__c='Namo');
         Test.startTest();
         insert c;
         Test.stopTest();
          c = [SELECT First_Name__c FROM AllInOne__c WHERE Id =:c.Id];
    }

}