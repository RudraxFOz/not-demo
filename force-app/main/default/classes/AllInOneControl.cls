public with sharing class AllInOneControl {

    public AllInOne__c c { get; set; }

    public List<AllInOne__c> samepage { get; set; }
    //	List<AllInOne__c> lt = new List<AllInOne__c>();
    
    public AllInOneControl(apexpages.StandardController stdController) {
       c=new AllInOne__c();
     
    }
    

    public PageReference save() {
        insert c;
       PageReference pr = new PageReference('/apex/SecondPage');
       pr.setRedirect(true);
       return null	;
    }
     public void showrec() {
       
      samepage= [select id,First_Name__c,Last_Name__c,EmailId__c,Phone_No__c from AllInOne__c where LastModifiedById =:c.LastModifiedById];
     
    }
}