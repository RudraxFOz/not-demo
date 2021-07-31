global  class InvitationController {
	public Id invitationId {get;set;}
    public static String invitationIdSS {get;set;}
    public List<Invitation__c> getInvitationList() { 
    
    	List<Invitation__c> invList = [SELECT Id, Name, Contact__c, Event__r.Start_Date__c, Event__r.End_Date__c, Event__r.Description__c FROM Invitation__c WHERE Id =: invitationId];
        return invList;
        
    }
    
    @RemoteAction
    global  static String sayHello(){
        System.debug('==Come hehre ====');
        invitationIdSS = 'testtststs';
        return invitationIdSS;

    }
}