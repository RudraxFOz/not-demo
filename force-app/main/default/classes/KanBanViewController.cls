public with sharing class KanBanViewController {
    /* wrapper class */  
    public class accountListWrapper {
        @AuraEnabled public boolean isChecked ;
        @AuraEnabled public Integer totalCount ;
        @AuraEnabled public  SObject sObj ;
        @AuraEnabled Public List<String> fieldsName1;
        
    }

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
            System.debug('==describeSobjField=='+describeSobjField.getType());
            String pick = 'PICKLIST' ;
             System.debug('==getScale()=='+describeSobjField.getType() == pick);
            if( describeSobjField.isAccessible() && describeSobjField.isUpdateable()) {
                allOpts.add(describeSobjField.getname());
            }
            // List<Schema.PicklistEntry> ple = describeSobjField.getPicklistValues();
            // for( Schema.PicklistEntry pickListVal : ple){
            //     allOpts.add(pickListVal.getLabel());
            // }     
            //return pickListValuesList;
        }
        return allOpts;
    }
}