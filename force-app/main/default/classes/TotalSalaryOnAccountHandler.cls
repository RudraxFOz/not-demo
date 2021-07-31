public with sharing class TotalSalaryOnAccountHandler {

    public Static void onBeforeInsert(List<Account> insertNewConList) { 
        //System.debug('hllllll');
      
    }   
    public Static void onAfterInsert(List<Account> insertNewConList) { 
        

    }
    public Static void onBeforeUpdate( List<Account> newListForInsert, Map<Id,Account> oldMapForUpt) { 
        

    }
    public Static void onAfterUpdate( List<Account> newListForInsert, Map<Id,Account> oldMapForUpt ) { 
        
       // updateAccFromChild(newListForInsert, oldMapForUpt);
       updateList(newListForInsert,oldMapForUpt);
    }
    public Static void onBeforeDelete(List<Account> lstOfConForDelete) { 
        
        
    }
    public Static void onAfterDelete(List<Account> oldMapForDelete) { 

        System.debug('Delete Record:'+oldMapForDelete);
        System.debug('hhh'); 
        Set<Id> accId = new Set<Id>();
        for(Account con : oldMapForDelete) {
            System.debug('Testing==='+con.Parent_Account__c);
            if(con.Id != NULL) {
            	accId.add(con.Parent_Account__c);
        	}
        }  
        UpdateLst(accId); 
       

    }
    public Static void onAfterUndelete(List<Account> newUndeleteList) { 
        System.debug('Delete Record:'+newUndeleteList);
        System.debug('hhh'); 
        Set<Id> accId = new Set<Id>();
        for(Account con : newUndeleteList) {
            System.debug('Testing==='+con.Parent_Account__c);
            if(con.Id != NULL) {
            	accId.add(con.Parent_Account__c);
        	}
        }  
        UpdateLst(accId); 
        
    }


    public Static void updateList( List<Account> newListForInsert, Map<Id,Account> oldMapForUpt ) {
        Set<Id> setOFAcc = new Set<Id>();
        List<Account> lstCon = new List<Account>();
        for( Account acc : newListForInsert ) {
            System.debug('==new List Name=='+acc.Name +'==Id==' +acc.Id);
            System.debug('==new List=='+oldMapForUpt);
            //System.debug('===@@new@@@@ ==='+con.lastName+' Salary '+ con.Salary__c +' AccountName '+con.Id );
            if(acc.Id == oldMapForUpt.get(acc.Id).Id && acc.Parent_Account__c != oldMapForUpt.get(acc.Id).Parent_Account__c) {
            	setOFAcc.add(acc.Parent_Account__c);
                setOFAcc.add(oldMapForUpt.get(acc.Id).Parent_Account__c);
            }
        }
        UpdateLst(setOFAcc);
    }

    public Static void UpdateLst( Set<Id> accId  ) { 
        System.debug('cheack come Here' + accId);
        Set<Id> topParentAccId = new Set<Id>();
        List<Account> accToUpdate = new List<Account>();
        List<TotalSalaryObj__c> custToUpdate = new List<TotalSalaryObj__c>();
		Map<id,Account> parentAccMap = new Map<id,Account>();
         
        List<Account> AccLst = [SELECT Id, Name, TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c, (SELECT id,name,Salary__c FROM Contacts WHERE AccountId != NULL and Salary__c != NULL),(SELECT id, Name, TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c FROM Accounts__r) FROM Account WHERE Id IN :accId];
        for(Account acc : AccLst) {
            System.debug('Ch1===1=='+acc.Name);
            for(Account acc1 : acc.Accounts__r) {
                System.debug('Ch1===1.1=='+acc1.Name);
            	accId.add(acc1.Id);    
            }
            if(acc.Parent_Account__c != NULL) {
            	accId.add(acc.Parent_Account__c);
            }
            if(acc.TotalSalaryObjParent__c != NULL) {
                topParentAccId.add(acc.TotalSalaryObjParent__c);
            }
        }
        List<Account> TempParentAccLst = [SELECT Id, TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c, (SELECT id,name,Salary__c FROM Contacts WHERE AccountId != NULL and Salary__c != NULL),(SELECT id,TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c FROM Accounts__r) FROM Account WHERE Id IN :accId]; 
        for(Account acc : TempParentAccLst) {
            for(Account acc1 : acc.Accounts__r) {
            	accId.add(acc1.Id);    
            }
        }
        List<Account> parentAccLst = [SELECT Id, TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c, (SELECT id,name,Salary__c FROM Contacts WHERE AccountId != NULL and Salary__c != NULL),(SELECT id,TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c FROM Accounts__r) FROM Account WHERE Id IN :accId];
        for(Account acc : parentAccLst) {
        	parentAccMap.put(acc.Id,acc);
            for(Account acc1 : acc.Accounts__r) {
            	parentAccMap.put(acc1.Id,acc1);    
            }
        }
        
        system.debug(parentAccMap);
        for(Account acc : parentAccMap.values()) {
            decimal sum = 0;
            decimal parentsum = 0;
            decimal sum2 = 0;
        
            for(Contact con : acc.Contacts) {
                sum += con.Salary__c;
            }
            if(acc.Accounts__r.size() > 0) {
                for(Account acc1 : acc.Accounts__r) {
                    System.debug('Account'+acc1);
                    Account temp = parentAccMap.get(acc1.Id);
                    System.debug(temp.Contacts.size()+'   &777&    ' +temp.Id);
                    if(temp.Contacts.size() > 0) {
                        for(Contact conTemp : temp.Contacts) {
                            sum2 += conTemp.Salary__c;
                            System.debug(conTemp.Salary__c);
                        }
                    }
                }
            }
            //sum += parentsum;
            sum += sum2;
            acc.TotalSalary__c = sum;
            accToUpdate.add(acc);
        }
        
        if(accToUpdate.size() >0) {
            update accToUpdate;
        }
        
        List<TotalSalaryObj__c> custObjLst = [SELECT id,TotalSalary__c,(SELECT id,TotalSalary__c FROM TotalSalaryObject__r) FROM TotalSalaryObj__c];
        for(TotalSalaryObj__c tot : custObjLst) {
            decimal sum = 0;
            for(Account acc : tot.TotalSalaryObject__r) {
                System.debug('Team Main==='+acc);
                if(acc.TotalSalary__c != NULL) {
            		sum += acc.TotalSalary__c;   
                }
            }
            tot.TotalSalary__c = sum;
            custToUpdate.add(tot);
        }
        
        if(custToUpdate.size() > 0) {
            update custToUpdate;
        }
    }
    
}