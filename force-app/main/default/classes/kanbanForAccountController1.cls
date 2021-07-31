public with sharing class kanbanForAccountController1 {

    @AuraEnabled
	public static List<Account> getKanbanAccList(){
		List<Account>lstOfAccount = [Select Id, Name from Account Limit 50];		
		return lstOfAccount;
	}
}