/**
* @ description : This is AccountTeamBatchApex class for use if any child account role is match to custome label than checkbox true on parent account.
* @ author      : suresh kumar
* @ date        : 27/08/2019
**/

global class AccountTeamBatchApex implements Database.Batchable<sObject> {

	global Database.querylocator start(Database.BatchableContext BC) {
        // * Return all the child account and AccountTeamMember of account object
        return Database.getQueryLocator([SELECT Id,Name,National_Account__c,(SELECT Id, AccountId , TeamMemberRole , UserId  FROM AccountTeamMembers ), (SELECT Id,Name,National_Account__c, parentId FROM Accounts__r) FROM Account]);
        //return Database.getQueryLocator([SELECT Id, AccountId , TeamMemberRole , Account.Name FROM AccountTeamMember]);
	}

	global void execute(Database.BatchableContext BC, List<Account> scope) {

        Map<Id, Account> parentAccToUpdate = new Map<Id, Account>();
        Map<Id, Account> childAccToUpdate = new Map<Id, Account>();  
        Map<String, AccountTeamMember> parentAccTeamMap = new Map<String, AccountTeamMember>();  
        Map<Id, Account> chAccToUpdate = new Map<Id, Account>();  
        Map<Id, Account> childAccMap = new Map<Id, Account>();
        Map<Id, Account> accTest = new Map<Id, Account>();
        Map<Id, Account> accTest1 = new Map<Id, Account>();

        
        String customLabelValue = System.Label.TestAccount1;
        List<String> lstOfCustomLabelValue = customLabelValue.split(',');
        Boolean f1 = false ;
        //if(f1 == false) {
        for (Account parentAcc : scope) {   
            for (AccountTeamMember accTeam : parentAcc.AccountTeamMembers) {
                parentAccTeamMap.put(accTeam.TeamMemberRole,accTeam);
                //for (Integer i = 0; i<lstOfCustomLabelValue.size(); i++ ) {
                    System.debug('==accTeam.TeamMemberRole=='+accTeam.TeamMemberRole);
                    //System.debug('==lstOfCustomLabelValue=='+lstOfCustomLabelValue[i]); 
                    if ( accTeam.TeamMemberRole.contains(customLabelValue)) { 
                        System.debug('==rtytry==');
                        f1 = true ;
                        parentAcc.National_Account__c = true ; 
                        parentAccToUpdate.put(parentAcc.Id,parentAcc);
                        break;
                    } else {
                        
                        parentAcc.National_Account__c = false ;
                        parentAccToUpdate.put(parentAcc.Id,parentAcc);
                    }
                //}
               
            }

            
                for (Account childAcc : parentAcc.Accounts__r) {
                   // for (Integer i = 0; i<lstOfCustomLabelValue.size(); i++ ) {
                    //groupProgram.keySet().retainAll(groupDefinitionIds.keySet());
                    //parentAccTeamMap.containsKey(customLabelValue)
                    if ( parentAccTeamMap.containsKey(customLabelValue)) {  
                       System.debug('==if part=='+childAcc.Name);
                        childAcc.National_Account__c = true ;
                        
                        break;
                        
                    } else {
                        System.debug('else part=='+childAcc.Name);
                        childAcc.National_Account__c = false ; 
                        childAccMap.put(childAcc.Id, childAcc);
                           
                    }
                //}

                accTest1.put(childAcc.Id,childAcc);
            }
        //}
        }

        System.debug('######chAccToUpdate==1234'+accTest1);
        if (!parentAccToUpdate.Values().isEmpty()) {
            update parentAccToUpdate.Values();
        }
   

        if(!accTest1.Values().isEmpty()) {
            update accTest1.Values();
        }
        //* set the Id of all child account 
        SET<ID> keys = childAccMap.keyset();
        
            // * Return all the child account and AccountTeamMember
            
           // if(f1!= true) {
                Boolean flag = false ;
                List<Account> childAccLstWithTeam = [SELECT Id,Name,National_Account__c,Parent_Account__c, (SELECT Id, AccountId , TeamMemberRole  FROM AccountTeamMembers) FROM Account WHERE Id IN: keys ];  
            for (Account childAcc : childAccLstWithTeam) {
                Account parAcc = new Account();
                System.debug(childAcc);
                for (AccountTeamMember accTeam : childAcc.AccountTeamMembers) {
                    //for (Integer i = 0; i<lstOfCustomLabelValue.size(); i++ ) {
                       // if (accTeam.TeamMemberRole.contains(string.valueof(lstOfCustomLabelValue[i]))) {   
                            flag = true ;  
                        //}  
                    //} 
                }
                parAcc.Id = childAcc.Parent_Account__c;
                parAcc.National_Account__c = flag ;
                childAcc.National_Account__c = flag ;
                childAccToUpdate.put(parAcc.Id,parAcc);
                accTest.put(childAcc.Id,childAcc);
            }  
            //}
       // }

        if (!childAccToUpdate.Values().isEmpty()) {
            update childAccToUpdate.Values();
        }

        if (!accTest.Values().isEmpty()) {
            update accTest.Values();
        }

            //}

	}

	global void finish(Database.BatchableContext BC) {

	}
}