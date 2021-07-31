public class dataTableCtrl{
    @AuraEnabled 
    public static List<accountListWrapper> fetchAccountWrapper(Integer recLimits){    
        System.debug('==recLimits==buttonValue'+recLimits);
        List<accountListWrapper> lstaccountListWrapper = new List<accountListWrapper>();
        List<Account> accList = new List<Account>();
        Integer count = database.countQuery('select count() from account');
		system.debug('the count is '+ count);
		
        
        // query account records and create 'accountListWrapper' class instance for each record. 
        for(Account acc : [Select id, Name, Description, Phone From Account ORDER BY Id asc LIMIT : recLimits]){
            accountListWrapper obj = new accountListWrapper();
            obj.isChecked = false ;
            obj.objAccount = acc ;
            obj.totalCount = count ;
            lstaccountListWrapper.add(obj);
        } 
        // return the 'lstaccountListWrapper' list 
        return lstaccountListWrapper; 
    }
    
    @AuraEnabled 
    public Static List<accountListWrapper> fetchAccList(Integer recLimits, String buttonValue, String LastId, String firstId) {
        System.debug('==buttonValues=='+buttonValue);
        System.debug('==LastId=='+LastId);
        List<accountListWrapper> lstaccountListWrapper = new List<accountListWrapper>();
        List<Account> accList = new List<Account>();
        if(buttonValue == 'Previous') {
            accList = [Select id, Name, Description, Phone From Account WHERE Id <: firstId ORDER BY Id DESC  Limit : recLimits];
        } else if (buttonValue == 'Next') {
            accList = [Select id, Name, Description, Phone From Account WHERE Id >: LastId  ORDER BY Id ASC  Limit : recLimits];
        }
        for(Account acc : accList){
            System.debug(acc.Name);
            accountListWrapper obj = new accountListWrapper();
            obj.isChecked = false ;
            obj.objAccount = acc ;                  
            lstaccountListWrapper.add(obj);
        }
        
         return lstaccountListWrapper ;
        
    }
    
    /* wrapper class */  
    public class accountListWrapper {
        @AuraEnabled public boolean isChecked {get;set;}
        @AuraEnabled public Integer totalCount {get;set;}
        @AuraEnabled public  account objAccount{get;set;}
        
    }
}