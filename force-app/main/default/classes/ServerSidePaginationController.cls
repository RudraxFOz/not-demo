public with sharing class ServerSidePaginationController {


    @AuraEnabled 
    public static List<String> getsObjects(){
        List<String> sObjectList = new List<String>();
        for(Schema.SObjectType sObj : Schema.getGlobalDescribe().values()){
            System.debug('==sObj=='+sObj);
            DescribeSObjectResult describeSobj = sObj.getDescribe();
            if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() && describeSobj.isCreateable() &&describeSobj.isDeletable() &&describeSobj.isUndeletable()) {
            	sObjectList.add(sObj.getDescribe().getName());
            }  
            sObjectList.sort();
            System.debug('==sObjectList=='+sObjectList);  
        }
        return sObjectList;
    }


    @AuraEnabled
    public Static List<String> getselectOptions(String objObject) {
        System.debug('objObject --->' + objObject);
        List <String> allOpts = new list <String> ();
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get(objObject).getDescribe().fields.getMap();
        for(Schema.SObjectField fieldSobj : fieldMap.Values()) {
            System.debug('==fieldSobj=='+fieldSobj);
            DescribeFieldResult describeSobjField = fieldSobj.getDescribe();
            if( describeSobjField.isAccessible() && describeSobjField.isUpdateable()) {
                allOpts.add(describeSobjField.getname());
            }
        }
        return allOpts;
    }

    @AuraEnabled
    public Static List<accountListWrapper> getFieldsRecord(String selectedObj, List<String> fieldsName, Integer recLimits ) {
        List<SObject>  queryList = new List<SObject>();
        List<accountListWrapper> lstaccountListWrapper = new List<accountListWrapper>();
        String fieldOfSobject=String.join(fieldsName,',');

        String qu = 'SELECT '+fieldOfSobject+' FROM '+selectedObj +' ORDER BY Id asc LIMIT '+ recLimits; 
        System.debug('==qu=='+qu);
        queryList = Database.query(qu);
       
        Integer count = database.countQuery('SELECT COUNT() FROM ' + selectedObj);
		system.debug('the count is '+ count);
        for(SObject obj : queryList){
            accountListWrapper objWrapper = new accountListWrapper();
            objWrapper.isChecked = false ;
            objWrapper.sObj = obj ;
            objWrapper.totalCount = count ;
            objWrapper.fieldsName1 = fieldsName ;
            lstaccountListWrapper.add(objWrapper);
        } 
       
        return lstaccountListWrapper ;

    } 


    // @AuraEnabled 
    // public static List<accountListWrapper> fetchAccountWrapper(Integer recLimits){    
    //     System.debug('==recLimits==buttonValue'+recLimits);
    //     List<accountListWrapper> lstaccountListWrapper = new List<accountListWrapper>();
    //     List<Account> accList = new List<Account>();
    //     Integer count = database.countQuery('SELECT COUNT() FROM ' + sObjectApiName); 
	// 	system.debug('the count is '+ count);
		
        
    //     // query account records and create 'accountListWrapper' class instance for each record. 
    //     for(Account acc : [Select id, Name, Description, Phone From Account ORDER BY Id asc LIMIT : recLimits]){
    //         accountListWrapper obj = new accountListWrapper();
    //         obj.isChecked = false ;
    //         obj.sObj = acc ;
    //         obj.totalCount = count ;
    //         lstaccountListWrapper.add(obj);
    //     } 
    //     // return the 'lstaccountListWrapper' list 
    //     return lstaccountListWrapper; 
    // }
    
    @AuraEnabled 
    public Static List<accountListWrapper> fetchRecList(String selectedObj, List<String> fieldsName,Integer recLimits, Integer lastPageLimit, String buttonValue, String LastId, String firstId, Boolean previousButtonLst) {
        System.debug('==buttonValues=='+buttonValue);
        System.debug('==LastId=='+LastId);
        System.debug('==firstId=='+firstId);
         System.debug('==recLimits=='+recLimits);
        List<accountListWrapper> lstaccountListWrapper = new List<accountListWrapper>();
        List<Account> accList = new List<Account>();  
        String fieldOfSobject=String.join(fieldsName,',');
        //String LastIdA = ' > '+ LastId ;
        String queryString ='SELECT '+fieldOfSobject+' FROM '+selectedObj ;
        if(buttonValue == 'previous') {
           
            queryString += ' WHERE ID < \'' + firstId + '\' ORDER BY Id DESC LIMIT '+ recLimits; 
            //accList = [Select id, Name   From Account WHERE Id <: firstId ORDER BY Id DESC  Limit : recLimits];
        } else if (buttonValue == 'next') {
            queryString += '  WHERE ID > \'' + LastId + '\'  ORDER BY Id ASC LIMIT '+ recLimits;
            //accList = [Select id, Name  From Account WHERE Id >: LastId  ORDER BY Id ASC  Limit : recLimits];
        }  else if (buttonValue == 'Last') {
            System.debug('come in Last');
            queryString += ' ORDER BY Id DESC LIMIT '+ lastPageLimit;
        }  else if (buttonValue == 'First') {
            System.debug('come in First');
            queryString += ' ORDER BY Id ASC LIMIT '+ recLimits;
        }
        System.debug('==queryString=='+queryString);
        List<sobject> records = database.query(queryString);
        System.debug('==records11=='+records);
        if(buttonValue == 'previous'){
            records = reverse(records);
        }
        System.debug('==records222=='+records);
        for(sobject acc : records){
            //System.debug(acc.Name);
            accountListWrapper obj = new accountListWrapper();
            obj.isChecked = false ;
            obj.sObj = acc ;                  
            lstaccountListWrapper.add(obj);
        }
        
         return lstaccountListWrapper ;
        
    }

    private static List<sobject> reverse(List<sobject> records){
        List<sobject> result = new list<sobject>();
        for(Integer i = records.size()-1 ; i >= 0 ; i--){
            result.add(records[i]);
        }
        return result;
    }
    
    /* wrapper class */  
    public class accountListWrapper {
        @AuraEnabled public boolean isChecked ;
        @AuraEnabled public Integer totalCount ;
        @AuraEnabled public  SObject sObj ;
        @AuraEnabled Public List<String> fieldsName1;
        
    }
}