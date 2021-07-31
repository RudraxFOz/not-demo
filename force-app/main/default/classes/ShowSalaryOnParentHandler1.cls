public with sharing class ShowSalaryOnParentHandler1 {
    
    public Static void onBeforeInsert(List<Contact> insertNewConList) { 
      
    }   

    public Static void onAfterInsert(List<Contact> insertNewConList) { 
        System.debug('@@@c@@@'); 
        Set<Id> accId = new Set<Id>();
        for(contact con : insertNewConList) {
            if(con.AccountId != NULL) {
            	accId.add(con.AccountId);
        	}
        }  
        insertAndDeleteRecord(accId);
    }

    public Static void onBeforeUpdate( List<Contact> newListForInsert, Map<Id,Contact> oldMapForUpt) { 

        System.debug('chech for inserttime come in update');
       
        
    }
    public Static void onAfterUpdate( List<Contact> newListForInsert, Map<Id,Contact> oldMapForUpt ) { 

        updateList(newListForInsert, oldMapForUpt);

    }
    public Static void onBeforeDelete(List<Contact> lstOfConForDelete) { 
        
        
    }
    public Static void onAfterDelete(List<Contact> oldMapForDelete) { 
        System.debug('Delete Record:'+oldMapForDelete);
        System.debug('hhh'); 
        Set<Id> accId = new Set<Id>();
        for(contact con : oldMapForDelete) {
            if(con.AccountId != NULL) {
            	accId.add(con.AccountId);
        	}
        }  
        insertAndDeleteRecord(accId);
    }
    // public Static void onAfterUndelete(List<Contact> newUndeleteList) { 
        
    // } insertNewCon

    //System.debug('Delete Record:'+oldMapForDelete);
  
    public Static void updateList( List<Contact> newListForInsert, Map<Id,Contact> oldMapForUpt ) {
        Set<Id> setOFAcc = new Set<Id>();
        List<Contact> lstCon = new List<Contact>();
        for( Contact con : newListForInsert ) {
            System.debug('===@@new@@@@ ==='+con.lastName+' Salary '+ con.Salary__c +' AccountName '+con.AccountId );
            if(con.AccountId != oldMapForUpt.get(con.Id).AccountId || con.Salary__c != oldMapForUpt.get(con.Id).Salary__c) {
            	setOFAcc.add(con.AccountId);
                setOFAcc.add(oldMapForUpt.get(con.Id).AccountId);
            }
        }
        insertAndDeleteRecord(setOFAcc);
    }

    public Static void insertAndDeleteRecord( Set<Id> accId ) {
        
        Set<Id> topParentAccId = new Set<Id>();
        List<Account> accToUpdate = new List<Account>();
        List<TotalSalaryObj__c> custToUpdate = new List<TotalSalaryObj__c>();
		Map<id,Account> parentAccMap = new Map<id,Account>();
        Map<id,Account> parentAccMapPp = new Map<id,Account>(); 
        List<Account> AccLst = [SELECT Id,Name, TotalSalary__c,ToSal__c, Parent_Account__c, TotalSalaryObjParent__c, (SELECT id,Name,Salary__c FROM Contacts WHERE AccountId != NULL and Salary__c != NULL),(SELECT id,TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c FROM Accounts__r) FROM Account WHERE Id IN :accId];
        for(Account acc : AccLst) {
            System.debug('Ch1===1=='+acc.Name);
            for(Account acc1 : acc.Accounts__r) {
                System.debug('Ch1===1.1=='+acc1.Name);
                accId.add(acc1.Id);
                // for(Account acc2 : acc1.Accounts__r) {
                //     system.debug('yes accounts'+acc2.Id);
            	//     accId.add(acc2.Id);  
                // }  
            }
            if(acc.Parent_Account__c != NULL) {
            	accId.add(acc.Parent_Account__c);
            }
            if(acc.TotalSalaryObjParent__c != NULL) {
                topParentAccId.add(acc.TotalSalaryObjParent__c);
            }
        }
        List<Account> TempParentAccLst = [SELECT Id, TotalSalary__c,ToSal__c, Parent_Account__c, TotalSalaryObjParent__c, (SELECT id,name,Salary__c FROM Contacts WHERE AccountId != NULL and Salary__c != NULL),(SELECT id,TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c FROM Accounts__r) FROM Account WHERE Id IN :accId]; 
        for(Account acc : TempParentAccLst) {
            for(Account acc1 : acc.Accounts__r) {
            	accId.add(acc1.Id);    
                // for(Account acc2 : acc1.Accounts__r) {
                //     system.debug('yes accounts'+acc2.Id);
            	//     accId.add(acc2.Id);  
                // }  
            }
        }
        List<Account> parentAccLst = [SELECT Id, TotalSalary__c,ToSal__c, Parent_Account__c, TotalSalaryObjParent__c, (SELECT id,name,Salary__c FROM Contacts WHERE AccountId != NULL and Salary__c != NULL),(SELECT id,TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c FROM Accounts__r) FROM Account WHERE Id IN :accId];
        List<Account> parentAccLstPp = [SELECT Id, TotalSalary__c,ToSal__c, Parent_Account__c, TotalSalaryObjParent__c, (SELECT id,name,Salary__c FROM Contacts WHERE AccountId != NULL and Salary__c != NULL),(SELECT id,TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c FROM Accounts__r) FROM Account WHERE Id IN :accId];
        
        for(Account acc : parentAccLst) {
        	parentAccMap.put(acc.Id,acc);
            for(Account acc1 : acc.Accounts__r) {
            	parentAccMap.put(acc1.Id,acc1);    
                // for(Account acc2 : acc1.Accounts__r) {
                //     System.debug('heee'+acc2.Name); 
            	//     parentAccMap.put(acc2.Id,acc2);    
                // } parentAccMapPp
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
           // acc.ToSal__c = sum ;
            accToUpdate.add(acc);
        }
        
        if(accToUpdate.size() >0) {
            update accToUpdate;
        }
        
        List<TotalSalaryObj__c> custObjLst = [SELECT id,TotalSalary__c,(SELECT id,TotalSalary__c FROM TotalSalaryObject__r) FROM TotalSalaryObj__c];
        for(TotalSalaryObj__c tot : custObjLst) {
            decimal sum = 0;
            for(Account acc : tot.TotalSalaryObject__r) {
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