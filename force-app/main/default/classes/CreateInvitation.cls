public class CreateInvitation {
    public static void createInvitationForContact(List<Event__c> newEvent) {
        List<Invitation__c> invitationLst = new List<Invitation__c>();
        List<Contact> contactLst = [SELECT Id, Name, Email, Contact_Type__c FROM Contact WHERE Contact_Type__c = 'VIP' LIMIT 50000];
        for(Event__c evt : newEvent){
            for(Contact contact : contactLst){
                Invitation__c invitation = new Invitation__c();
                invitation.Name = evt.Name+' Invitation';
                invitation.Contact__c = contact.Id;
                invitation.Event__c = evt.Id;
            	invitationLst.add(invitation);
            }
        }
        if(invitationLst.size() > 0){
            insert invitationLst;
        }	
        
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where DeveloperName = 'Invitation_Email'];
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        for(Contact contact : contactLst) {
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.subject = 'Give the Decision';
            message.setTemplateId(emailTemplate.Id); 
            message.setReplyTo('invitationemail@7-1zdrklg432tw30vce2d61p7r01re6fy6ll5dvv8q41kyey2f3e.6f-2yzk6uag.ap4.apex.salesforce.com');
            message.setTargetObjectId(contact.Id);
            //message.toAddresses = new String[] { 'sureshkumar04799@gmail.com','suresh.kumar@briskminds.com' };
            message.setSaveAsActivity(false);
            messages.add(message);	
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }          
    }
}