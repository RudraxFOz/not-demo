public with sharing class SendEmailForInvitation {
    public static void CaseLegalmethod(List<Invitation__c> newLegal) {
        List<Id> legalId = new List<Id>();
		for(Invitation__c lg : newLegal)
		{
			if(lg.Id!=NULL)
			{
				legalId.add(lg.Id);
			}
		}
        List<Invitation__c> updateInvitationList = [SELECT Id, Name, Decision__c, Contact__r.Email FROM Invitation__c WHERE Id IN:legalId];
        List<String> emailList = new List<String>();
        for(Invitation__c inv : updateInvitationList) {
            emailList.add(inv.Contact__r.Email);
        }
        String emailString = String.join(emailList,', ');

		System.debug('==emailString=='+emailString);
        //List<EmailTemplate> emt = [Select Id from EmailTemplate where DeveloperName = 'Invitation_Email'];
         EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where DeveloperName = 'Invitation_Email'];
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
       
        message.optOutPolicy = 'FILTER';
        message.subject = 'Subject Test Message@@@@';
        message.plainTextBody = 'This is the message body.';
        message.setTemplateID(emailTemplate.Id); 
        message.setReplyTo('invitationemail@7-1zdrklg432tw30vce2d61p7r01re6fy6ll5dvv8q41kyey2f3e.6f-2yzk6uag.ap4.apex.salesforce.com');
         message.toAddresses = new String[] { emailString };
        //message.getInReplyTo('invitationemail@7-1zdrklg432tw30vce2d61p7r01re6fy6ll5dvv8q41kyey2f3e.6f-2yzk6uag.ap4.apex.salesforce.com');
        //message.setReplyTo = 'invitationemail@7-1zdrklg432tw30vce2d61p7r01re6fy6ll5dvv8q41kyey2f3e.6f-2yzk6uag.ap4.apex.salesforce.com';
        //message.setInReplyTo('invitationemail@7-1zdrklg432tw30vce2d61p7r01re6fy6ll5dvv8q41kyey2f3e.6f-2yzk6uag.ap4.apex.salesforce.com');
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
    }

   
}