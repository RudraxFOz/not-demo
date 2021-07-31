global class AccountTeamBatch implements Database.Batchable<sObject> {

	global Database.querylocator start(Database.BatchableContext BC) {
	
		// string selectedObject  = 'Account';
        // Map<String,sObject> returnValueMap = new Map<String,sObject>();
        // LightningPieChartCls1 obj = new LightningPieChartCls1();
        // obj.childObjLst = new List<String>();
        // Set<String> childObjSet = new Set<String>();
        // Set<String> childRelationShipNameSet = new Set<String>(); 
        // Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
        // Schema.sObjectType objType = globalDescription.get(selectedObject); 
        // String childRelationShipName1 = '';
        // for(Schema.ChildRelationship child : objType.getdescribe().getChildRelationships()) {
        //     DescribeSObjectResult describeSobj = child.getChildSObject().getDescribe();
        //     if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() && describeSobj.isCreateable() && describeSobj.isDeletable() && describeSobj.isUndeletable() ) {
        //         String childObj = ''+child.getChildSObject();
        //         System.debug('==childObj@@=='+childObj);
        //         String childRelationShipName = child.getRelationshipName();
        //         System.debug('==childRelationShipName@@=='+childRelationShipName);
        //         childRelationShipNameSet.add(childRelationShipName);
        //         childObjSet.add(childObj);
        //     } 
        // }
        // System.debug('==set of child obj=='+childObjSet);
        // childRelationShipNameSet.remove(null);
        // System.debug('==set of childRelationShipNameSet obj=='+childRelationShipNameSet);
        // obj.childObjLst.addAll(childRelationShipNameSet);
        // System.debug('childObj=='+obj.childObjLst);
        // String childObjRel = '';
        // for(String oneObj : childRelationShipNameSet) {
        //     if(String.isNotBlank(oneObj) ) {
        //         System.debug('==oneObj=='+oneObj);
        //         childObjRel = childObjRel + ', ' + '(SELECT Id FROM ' + oneObj + ')';  
        //     }  
        // }
        // System.debug('==childRel=='+childObjRel); 
        // String lst = 'SELECT Id, Name '+childObjRel+' FROM '+selectedObject;
        // System.debug('==lst---'+lst);

        // return Database.getQueryLocator(lst);
        return Database.getQueryLocator([SELECT id, name,Role__c,National_Account__c, (SELECT Id  FROM Cases), (SELECT Id, Name FROM Contacts), (SELECT Id, Name FROM Accounts__r), (SELECT Id, Name FROM Opportunities), (SELECT Id, Name FROM ComeTos__r), (SELECT Id, AccountId , TeamMemberRole , UserId  FROM AccountTeamMembers ) FROM Account]);
	}

	global void execute(Database.BatchableContext BC, List<Account> scope) {
        //Account ac ;
       // List<Account> accToUpdate = new List<Account>();
        //List<Account> accToUpdate1 = new List<Account>();
        Map<Id, Account> accToUpdate1 = new Map<Id, Account>();
        Map<Id, Account> accToUpdate = new Map<Id, Account>();
        List<AccountTeamMember> accountTeamLst = new List<AccountTeamMember>();
        Map<String, AccountTeamMember> accountTeamMap = new Map<String, AccountTeamMember>();
        for(Account acc : [SELECT id, name,Role__c,National_Account__c, (SELECT Id,Role__c  FROM Cases), (SELECT Id, Role__c FROM Contacts), (SELECT Id, Role__c FROM Accounts__r), (SELECT Id, Role__c FROM Opportunities), (SELECT Id, Role__c FROM ComeTos__r), (SELECT Id, AccountId , TeamMemberRole , UserId  FROM AccountTeamMembers ) FROM Account]) {
            // System.debug('==--Contacts-==='+acc.Contacts);
            // System.debug('==--Cases-==='+acc.Cases);
            // System.debug('==--Opportunities-==='+acc.Opportunities);
            // System.debug('==--ComeTos__r-==='+acc.ComeTos__r); 
            // System.debug('==--ComeTos__r-==='+acc.AccountTeamMembers);
            // System.debug('==--acc1111-==='+acc);
            //if (acc.Role__c != null) {
            for (AccountTeamMember childObj : acc.AccountTeamMembers) {
                accountTeamMap.put(childObj.TeamMemberRole,childObj);
                System.debug('==accountTeamMap.=='+accountTeamMap);
                // System.debug('==childObj.TeamMemberRole=='+childObj.TeamMemberRole);
                // if (childObj.TeamMemberRole.contains(acc.Role__c) ) {
                //     Account ac = new Account();
                //     System.debug('==acc.National_Account__c=='+acc.National_Account__c);
                //     ac.National_Account__c = true ;
                //     ac.Id = acc.Id;
                //     accToUpdate.add(ac);
                //     System.debug('==accToUpdate=='+accToUpdate);
                // } 
            }

            for (Case childObj : acc.Cases) {
                System.debug(accountTeamMap.containsKey(childObj.Role__c));
                Account ac = new Account();
                if (accountTeamMap.containsKey(childObj.Role__c)) {
                    System.debug('==acc.National_Account__c=='+acc.National_Account__c);
                    ac.National_Account__c = true ;
                    ac.Id = acc.Id;
                    System.debug('=ac.National_Account__c='+ac.National_Account__c);
                    System.debug('==accToUpdate=='+accToUpdate);
                } else {
                    ac.National_Account__c = false ;
                    ac.Id = acc.Id;
                    System.debug('=ac.National_Account__c='+ac.National_Account__c);
                }
                accToUpdate.put(ac.Id, ac);
            }

            for (Opportunity childObj : acc.Opportunities) {
                System.debug(accountTeamMap.containsKey(childObj.Role__c));
                Account ac = new Account();
                if (accountTeamMap.containsKey(childObj.Role__c)) {
                    System.debug('==acc.National_Account__c=='+acc.National_Account__c);
                    ac.National_Account__c = true ;
                    ac.Id = acc.Id;
                    System.debug('=ac.National_Account__c='+ac.National_Account__c);
                    System.debug('==accToUpdate=='+accToUpdate);
                } else {
                    ac.National_Account__c = false ;
                    ac.Id = acc.Id;
                    System.debug('=ac.National_Account__c='+ac.National_Account__c);
                }
                accToUpdate.put(ac.Id, ac);
            }

            for (ComeTo__c childObj : acc.ComeTos__r) {  
                System.debug(accountTeamMap.containsKey(childObj.Role__c));
                Account ac = new Account();
                if (accountTeamMap.containsKey(childObj.Role__c)) {
                    System.debug('==acc.National_Account__c=='+acc.National_Account__c);
                    ac.National_Account__c = true ;
                    ac.Id = acc.Id;
                    System.debug('=ac.National_Account__c='+ac.National_Account__c);
                    System.debug('==accToUpdate=='+accToUpdate);
                } else {
                    ac.National_Account__c = false ;
                    ac.Id = acc.Id;
                    System.debug('=ac.National_Account__c='+ac.National_Account__c);
                }
                accToUpdate.put(ac.Id, ac);
            }

            for (Contact childObj : acc.Contacts) {  
                System.debug(accountTeamMap.containsKey(childObj.Role__c));
                System.debug('==accountTeamLst==='+accountTeamLst);
                Account ac = new Account();
                if (accountTeamMap.containsKey(childObj.Role__c)) {
                    System.debug('team come in conatct');
                    ac.Id = acc.Id;
                    System.debug('==acc.National_Account__c=='+acc.National_Account__c);
                    ac.National_Account__c = true ;
                    System.debug('=ac.National_Account__c='+ac.National_Account__c);
                    System.debug('==accToUpdate=='+accToUpdate);
                } else {
                    ac.National_Account__c = false ;
                    ac.Id = acc.Id;
                    System.debug('=ac.National_Account__c='+ac.National_Account__c);
                }
                accToUpdate.put(ac.Id, ac);
            }

           
            for( Account account : accToUpdate.values()) {
                Account ac = new Account();
                System.debug('==account=='+account);
                if( account.National_Account__c == true ) {
                    ac.National_Account__c = true ;
                    ac.Id = account.Id ;
                    
                } else {
                    ac.National_Account__c = false ;
                    ac.Id = account.Id ;
                }
                accToUpdate1.put(ac.Id, ac);
            }


        }
       
        if(!accToUpdate1.Values().isEmpty() ) {
            System.debug('==accToUpdate.values()=='+accToUpdate.values()); 
            update accToUpdate1.Values();
        }
	}

	global void finish(Database.BatchableContext BC) {

	}
}