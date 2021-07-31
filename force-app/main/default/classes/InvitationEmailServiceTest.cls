@isTest
private class InvitationEmailServiceTest {
    
      public static testMethod void ProcessApplicantTest(){
       
       
        // Create a new email, envelope object and Attachment
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
        //Position__c position = [select Id,name from Position__c limit 1];
        Test.startTest();
        Event__c ev = new Event__c();
          ev.name = 'Holi';
          //insert ev;
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
        //invitation.Event__c = ev.Id;
        insert invitation;
           Test.stopTest(); 
        email.subject = 'Test subject';
        //email.fromName = 'test test';
        email.plainTextBody = 'suresh.kumar@briskmimds.com';
        Messaging.InboundEmail.BinaryAttachment[] binaryAttachments = new Messaging.InboundEmail.BinaryAttachment[1]; 
        Messaging.InboundEmail.BinaryAttachment binaryAttachment = new Messaging.InboundEmail.BinaryAttachment();
        binaryAttachment.Filename = 'test.txt';
        String algorithmName = 'HMacSHA1';
        Blob b = Crypto.generateMac(algorithmName, Blob.valueOf('test'),
        Blob.valueOf('test_key'));
        binaryAttachment.Body = b;
        binaryAttachments[0] =  binaryAttachment ;
        email.binaryAttachments = binaryAttachments ;
        envelope.fromAddress = 'suresh.kumar@briskmimds.com';
       


        // setup controller object
        InvitationEmailService catcher = new InvitationEmailService();
        Messaging.InboundEmailResult result = catcher.handleInboundEmail(email, envelope);
        System.assertEquals( result.success  ,true);   
          
          InvitationController obj = new InvitationController();
          obj.getInvitationList();

    }

}