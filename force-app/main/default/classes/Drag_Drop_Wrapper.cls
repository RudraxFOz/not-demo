public with sharing class Drag_Drop_Wrapper {
	@AuraEnabled public string Name;
	@AuraEnabled public string Id;
	@AuraEnabled public boolean isSelected;	
	@AuraEnabled public String AccountNumber;
	@AuraEnabled public string Industry;

	public Drag_Drop_Wrapper(String name, string id, String accountNumber, string industry) {
		this.Name = name;
		this.id = id;		
		this.AccountNumber = accountNumber;
		this.Industry = industry;
		isSelected = false;
	}
}