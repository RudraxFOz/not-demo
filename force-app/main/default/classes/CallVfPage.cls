public class CallVfPage {
   // public Boolean showRecords{get;set;}
    //public List<AllInOne__c> paramValueVariable {get;set;} 
 //   AllInOne__c all{get;set;}
    public CallVfPage(apexpages.StandardController stdController){
        /*        all = (AllInOne__c)stdController.getRecord();
        AllInOne__c.all = ApexPages.currentPage().getParameters().get('ordId');*/
 		PageReference  pr = new PageReference('/apex/SVfPage');
    }
    
   //public PageReference  fetchRecords(){
     //PageReference  pr = new PageReference('/apex/SVfPage');
     // PageReference  pr = new PageReference('/apex/SVfPage?param1='+paramValueVariable);
		
       // pr.setRedirect(true);
		//paramValueVariable = [SELECT S_No__c,First_Name__c, Last_Name__c,Gender__c,EmailId__c,Phone_No__c FROM AllInOne__c limit 1000];
		//showRecords = true;*/
        //insert all;
        //return null;
       // return pr;	

//}
}