public class AllInOneControl1 {
	public AllInOne__c c { get; set; }

    public List<AllInOne__c> samepage { get; set; }
    
    public AllInOneControl1(){
       c=new AllInOne__c();
    }
    public void showrec() {
       insert c;  
       // PageReference pr = new PageReference('apex/SecondPage');
      samepage= [select id,First_Name__c,Last_Name__c,EmailId__c,Phone_No__c from AllInOne__c where id=:c.id];
     // pr.setRedirect(true);
       // return null;
    }
}