global class SendEmailEveryDay implements Schedulable {

   global void execute(SchedulableContext SC) {
   
      sendmail();
      
   }
   public void sendmail()
       {
           Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
           string [] toaddress= New string[]{'ravikant@briskminds.com'};
           email.setSubject('Please fill your portal Att');
           email.setPlainTextBody('Welcome in your company');
           email.setToAddresses(toaddress);
           Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
       }
}