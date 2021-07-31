/**
* @ description : This is AccountTeamBatchApex class for use if any child account role is match to custome label than checkbox true on parent account.
* @ author      : suresh kumar
* @ date        : 27/08/2019
**/
global class AccountTeamBatchApex1 implements Database.Batchable<sObject> {

    global Database.querylocator start(Database.BatchableContext BC) {
        // * Return all the child account and AccountTeamMember of account object
        return Database.getQueryLocator([SELECT Id,Name,National_Account__c,(SELECT Id, AccountId , TeamMemberRole , UserId  FROM AccountTeamMembers ), (SELECT Id,Name,National_Account__c, parentId FROM Accounts__r) FROM Account]);
        //return Database.getQueryLocator([SELECT Id, AccountId , TeamMemberRole , Account.Name FROM AccountTeamMember]);
	}


    global void execute(Database.BatchableContext BC, List<Account> scope) {

        Map<Id, Account> parentRoleMatchUpdate = new Map<Id, Account>();
        Map<Id, Account> childRoleMatchUpdate = new Map<Id, Account>();  
        Map<Id, Account> childAccMap = new Map<Id, Account>();
        Map<Id, Account> updateParentByChildMap = new Map<Id, Account>();
        Map<Id, Account> updateChildByParentMap = new Map<Id, Account>();
        Map<Id, Account> accTest2 = new Map<Id, Account>();

        
        String customLabelValue = System.Label.TestAccount1;
        List<String> lstOfCustomLabelValue = customLabelValue.split(',');
        
        for (Account parentAcc : scope) {  
            Boolean f1 = false ; 
            System.debug('==parentAcc='+parentAcc);
            for (AccountTeamMember accTeam : parentAcc.AccountTeamMembers) { 
                for (Integer i = 0; i<lstOfCustomLabelValue.size(); i++ ) {   
                    if ( accTeam.TeamMemberRole.contains(string.valueof(lstOfCustomLabelValue[i]))) { 
                        System.debug('==rtytry==');
                        f1 = true ;
                        parentAcc.National_Account__c = true ; 
                        break;
                    } else {
                        parentAcc.National_Account__c = false ;   
                    }
                }
                parentRoleMatchUpdate.put(parentAcc.Id,parentAcc);
                for (Account childAcc : parentAcc.Accounts__r) {
                    if (f1 == true) {  
                        childAcc.National_Account__c = true ;   
                    } else {
                        childAcc.National_Account__c = false ;      
                    }
                    childAccMap.put(childAcc.Id, childAcc);
                    updateChildByParentMap.put(childAcc.Id,childAcc);
                } 
            }
        }
        if (!parentRoleMatchUpdate.Values().isEmpty()) {
            update parentRoleMatchUpdate.Values();
        }
        if(!updateChildByParentMap.Values().isEmpty()) {
            update updateChildByParentMap.Values();
        }

        Boolean flag = false ;
        //* set the Id of all child account 
        SET<ID> keys = childAccMap.keyset();
        Account parAcc = new Account();  
        // * Return all the child account and AccountTeamMember   
        List<Account> childAccLstWithTeam = [SELECT Id,Name,National_Account__c,Parent_Account__c, (SELECT Id, AccountId , TeamMemberRole  FROM AccountTeamMembers) FROM Account WHERE Id IN: keys AND  National_Account__c = false];  
        for (Account childAcc : childAccLstWithTeam) {
            for (AccountTeamMember accTeam : childAcc.AccountTeamMembers) {
                for (Integer i = 0; i<lstOfCustomLabelValue.size(); i++ ) {
                    if (accTeam.TeamMemberRole.contains(string.valueof(lstOfCustomLabelValue[i]))) { 
                        flag = true ;  
                        break;
                    }  
                } 
            }
            parAcc.Id = childAcc.Parent_Account__c;    
        }
        for (Account childAcc : childAccLstWithTeam) { 
            childAcc.National_Account__c = flag;
        }  
        parAcc.National_Account__c = flag ;
        updateParentByChildMap.put(parAcc.Id,parAcc); 

        update childAccLstWithTeam;  

        if (!updateParentByChildMap.Values().isEmpty()) {
            update updateParentByChildMap.Values();
        }
	}

	global void finish(Database.BatchableContext BC) {

	}
}