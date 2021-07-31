public  class LeadProcessor implements  Database.Batchable<sObject>, Database.Stateful {
	public  Database.QueryLocator start(Database.BatchableContext bc) {
		return Database.getQueryLocator(' SELECT ID,Company, Description, Email,LeadSource FROM Lead');
	}
	public void execute(Database.BatchableContext bc, List<Lead> scope) {
		 List<Lead> leadList = new List<Lead>();
		 for(Lead leadObj : scope) {
		 	leadObj.LeadSource = 'Dreamforce';
		 	leadList.add(leadObj);
		 }
		 update leadList;
	}
	 public void finish(Database.BatchableContext bc) { 

	 }
}