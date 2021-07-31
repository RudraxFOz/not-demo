/* Description  : This is Batch Class For VF Page UploadCsvFiles 
* Created by   : Suresh kumar
* 
* Created date : 2-jan-2019
* 
* Version      : V1.0 Created 
*/
public  class BatchApexForContact implements Database.Batchable<sObject>, Database.Stateful {
    
    public String queryString = 'SELECT ID, Name FROM Account LIMIT 6';
    public integer numberofDirectCustomers = 0;
    public List<Account> conList = new List<Account>();
    public Set<Id> conSet = new Set<Id>();


    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('==come==in==Batch==');
        return Database.getQueryLocator(queryString);
    }

    /**
        @description :   This methd is used to update the status .if any status is not approval then this method is work
     *
     *  @args        :   Two Arrguments. 1.Database.BatchableContext bc   2.List<Contact> scope
     *
     *  @return      :   void
     * 
     *  @revision Logs:   V1.0 - Suresh Kumar - 02/01/2019 - Created
     *
     **/
     public void execute(Database.BatchableContext bc, List<Account> scope){
        
        for(Account c : scope) {
            //if(c.Status__c != 'Approval') {
               // c.Status__c = 'Approval';
            	if(numberofDirectCustomers == 1) {
					c.Name = 'Aa A'+numberofDirectCustomers;           	
                }else {   
                    c.Name = 'Aa '+numberofDirectCustomers;
                    c.Active__c = 'No';
                }
                
                conList.add(c);
             	numberofDirectCustomers++;
            	conSet.add(c.Id);
            //}
        }
        //update conList;
         Database.SaveResult[] srList = Database.update(conList, true);
        System.debug('===conList==='+conList.Size());
         System.debug('===conList==='+conList);
         System.debug('===numberofDirectCustomers==='+numberofDirectCustomers);
         List<Account> conList1 = [SELECT ID, Name FROM Account LIMIT 8];
         System.debug('===conList1==='+conList1);
         //DeletedAttemptOnAccountHelper.deleteRecordOnAfter11(conSet); 
     }

    /**
        @description :   This methd is used to sent the mail 
     *
     *  @args        :   one Arrguments. 1.Database.BatchableContext bc  
     *
     *  @return      :   void
     * 
     *  @revision Logs:   V1.0 - Suresh Kumar - 02/01/2019 - Created
     *
     **/
    public void finish(Database.BatchableContext BC) {
        //System.debug('My Test');
        try {
            //DeletedAttemptOnAccountHelper.deleteRecordOnAfter(conSet); 
        } catch(Exception e) {
            
        } 
    }
    
    
     public void execute1(Database.BatchableContext bc, List<Account> scope){
         System.debug('My Test');
         
     }
    
    public void execute2(){
         System.debug('My Test====2===');
         
     }
}