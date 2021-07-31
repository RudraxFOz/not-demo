global class scheduledEmail implements Schedulable {

   global void execute(SchedulableContext SC) {
   
      sendmail();
      
   }
   public void sendmail()
       {
           Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
           string [] toaddress= New string[]{'suresh.kumar@briskminds.com'};
           email.setSubject('Testing Apex Scheduler-Subject');
           email.setPlainTextBody('Testing Apex Scheduler-Body');
           email.setToAddresses(toaddress);
           Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
       }
}