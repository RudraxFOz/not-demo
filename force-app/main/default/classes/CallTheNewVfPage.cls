public class CallTheNewVfPage {
	
	public static PageReference   saves() {
        AllInOne__c allinone = new AllInOne__c();
		upsert allinone;
        PageReference  pr = new PageReference ('apex/newvfpage');
        pr.setRedirect(true);
        return pr;
	}
}