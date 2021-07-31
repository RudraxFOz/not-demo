public with sharing class TotalSalaryTriggerHandler {
     public Static void onBeforeInsert(List<TotalSalaryObj__c> insertNewConList) { 
        //System.debug('hllllll');
      
    }   
    public Static void onAfterInsert(List<TotalSalaryObj__c> insertNewConList) { 
        

    }
    public Static void onBeforeUpdate( List<TotalSalaryObj__c> newListForInsert, Map<Id,TotalSalaryObj__c> oldMapForUpt) { 
        

    }
    public Static void onAfterUpdate( List<TotalSalaryObj__c> newListForInsert, Map<Id,TotalSalaryObj__c> oldMapForUpt ) { 
        
       // updateAccFromChild(newListForInsert, oldMapForUpt);
      
    }
    public Static void onBeforeDelete(List<TotalSalaryObj__c> lstOfConForDelete) { 
        
        
    }
    public Static void onAfterDelete(List<TotalSalaryObj__c> oldMapForDelete) { 

      detelCustomeObj(oldMapForDelete);

    }
    public Static void onAfterUndelete(List<TotalSalaryObj__c> newUndeleteList) { 
       
        
    }


    public Static void detelCustomeObj( List<TotalSalaryObj__c> oldMapForDelete ) {
        List<TotalSalaryObj__c> custToUpdate = new List<TotalSalaryObj__c>();
        Set<Id> accId = new Set<Id>();
        for(TotalSalaryObj__c con : oldMapForDelete) {
           // System.debug('Testing==='+con.Parent_Account__c);
            if(con.Id != NULL) {
            	accId.add(con.Id);
        	}
        }  
        //UpdateLst(accId); 


        List<TotalSalaryObj__c> custObjLst = [SELECT id,TotalSalary__c,(SELECT id,TotalSalary__c FROM TotalSalaryObject__r) FROM TotalSalaryObj__c WHERE Id IN: accId ];
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