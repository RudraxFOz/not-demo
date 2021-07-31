@isTest
public class CreateInvitationTest {
      public static testMethod void ProcessApplicantTest(){
            Test.startTest();
        Event__c ev = new Event__c();
          ev.name = 'Holi';
          insert ev;
        Account testAccount = new Account();
        testAccount.Name='Test Account' ;
          //testAccount.OpenDate__c = Date.newInstance(2016, 12, 9);
        insert testAccount;
        
        Contact cont = new Contact();
        cont.FirstName='Test';
        cont.LastName='Test';
        cont.City__c = 'Jaipur';
        cont.Contact_Type__c = 'VIP';
        cont.Email = 'suresh.kumar@briskmimds.com';
        cont.Accountid= testAccount.id;
        insert cont;
        Invitation__c invitation = new Invitation__c();
        invitation.Name = ' Invitation';
        invitation.Contact__c = cont.Id;
        invitation.Event__c = ev.Id;
        insert invitation;
           Test.stopTest(); 
      }
}