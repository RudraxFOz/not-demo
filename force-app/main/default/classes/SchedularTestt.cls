public class SchedularTestt implements Schedulable{
   
    public void execute(SchedulableContext SC){
        System.debug('==come==in==Schedul==');
        database.executeBatch(new BatchApexForContact(),100);
       //for cron expression
        // String cronexpression = ‘0 0 0 ? * * *’
       // System.schedule(‘Testing’, cronexpression, testobj);        
    } 

}