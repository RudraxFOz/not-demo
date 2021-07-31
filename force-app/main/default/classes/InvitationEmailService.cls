global class InvitationEmailService implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email,Messaging.InboundEnvelope env) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String plainTextBody = email.plainTextBody;
		String Subject = email.Subject;
        String spiltStringYes = plainTextBody.Substring(plainTextBody.indexof('start')+1,plainTextBody.indexof('end')+4);
        String spiltStringNo = plainTextBody.Substring(plainTextBody.indexof('start')+1,plainTextBody.indexof('end')+3);
        String spiltStringMayBe = plainTextBody.Substring(plainTextBody.indexof('start')+1,plainTextBody.indexof('end')+6);
        String updateEventPicklist;
        If(spiltStringYes.equalsIgnoreCase('yes')){
            updateEventPicklist = 'Yes';
        } else if(spiltStringNo.equalsIgnoreCase('No')){
             updateEventPicklist = 'No';
        } else if(spiltStringMayBe.equalsIgnoreCase('Maybe')){
             updateEventPicklist = 'Maybe';
        } 
        System.debug('==plainTextBody='+plainTextBody);
        System.debug('==updateEventPicklist='+updateEventPicklist);
   
        String addColonEventPicklst = updateEventPicklist+', ';
        String contactEmailIdWithoutCom = plainTextBody.SubStringBefore('.com');
        list<String> splitAnswerValue = contactEmailIdWithoutCom.split(addColonEventPicklst);
        String contactEmailId = string.join(splitAnswerValue,'')+'.com';
        System.debug('==contactEmailId1='+contactEmailId);
        List<Invitation__c> updateInvitationList = [SELECT Id, Name, Decision__c, Contact__c, Contact__r.Contact_Type__c FROM Invitation__c WHERE Contact__r.Email =: contactEmailId AND Contact__r.Contact_Type__c = 'VIP'];
        System.debug('==updateInvitationList=='+updateInvitationList);
        updateInvitationList[0].Decision__c = updateEventPicklist;
        update updateInvitationList;
		
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { contactEmailId };
        message.subject = 'Get response';
        message.plainTextBody = 'This user say to '+updateEventPicklist+' for invitation.';
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
         result.success = true; 
  		 return result;
    }
}