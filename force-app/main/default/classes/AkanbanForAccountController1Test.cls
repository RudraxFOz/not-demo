@isTest
public class AkanbanForAccountController1Test {
    
    static testMethod void testAccountList (){
    Account acc = new Account();
    acc.Name = 'Test Name';
    insert acc;
    

     Test.startTest();
       kanbanForAccountController1.getKanbanAccList();
    Test.stopTest();
    Account ACC1 = [select Name from Account LIMIT 1];
    System.assertEquals ( String.valueOf(acc1.Name) ,'Test Name');
  

    }  

}