public with sharing class ClientSidePaginationController {
    /*---- Wrapper class for selected object fields -----*/
    public class SObjectWrapper {
        @AuraEnabled
        public String value ;
        @AuraEnabled
        public String label ;
        public SObjectWrapper(String value, String label){
            this.value = value ;
            this.label = label ;   
        }
    }
    /*---- Wrapper class for show record on template -----*/
    public class SObjectWrapperForRecord {
        @AuraEnabled public SObject sObj ;
        @AuraEnabled public List<String> selectFields; 
        // public SObjectWrapperForRecord(SObject sObj) {
        //     this.sObj = sObj ;
        // }
    }

    /*---- get all sObject -----*/
    @AuraEnabled 
    public Static List<SObjectWrapper> getSobject() {
        List<SObjectWrapper> sObjectWrapperList = new List<SObjectWrapper>();
        sObjectWrapperList.add(new SObjectWrapper('--None--','--None--'));
        for(Schema.SObjectType sObj : Schema.getGlobalDescribe().values()) {
            DescribeSObjectResult describeSobj = sObj.getDescribe();
            if( describeSobj.isQueryable() && describeSobj.isAccessible() && describeSobj.isSearchable() ) {
                sObjectWrapperList.add(new SObjectWrapper(sObj.getDescribe().getName(),sObj.getDescribe().getLabel()));
            } 
        }
        return sObjectWrapperList ;
    }

    /*---- get all fields of selected object -----*/
    @AuraEnabled
    public Static List<String> getFields(String selectedObj) {
        List <String> allOpts = new list <String> ();
        Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map <String, Schema.SObjectField> fieldMap = schemaMap.get(selectedObj).getDescribe().fields.getMap();
        for(Schema.SObjectField fieldSobj : fieldMap.Values()) {
            DescribeFieldResult describeSobjField = fieldSobj.getDescribe();
            if( describeSobjField.isAccessible() && describeSobjField.isUpdateable()) {
                allOpts.add(describeSobjField.getname());
            }
        }
        return allOpts;
    }

    /*---- get all all record -----*/
    @AuraEnabled
    public Static List<SObjectWrapperForRecord> getRecords(String selectedObj, String selectedFieldsLst) {
        SObjectWrapperForRecord objWrapper1 = new SObjectWrapperForRecord();
        List<SObject> queryList = new List<SObject>();
        List<SObjectWrapperForRecord> sObjectWrapperForRecord = new List<SObjectWrapperForRecord>();
       // String selectedFields = String.join(selectedFieldsLst,',');
       List<String> lstAlpha = selectedFieldsLst.split(',');
       objWrapper1.selectFields = lstAlpha;
       sObjectWrapperForRecord.add(objWrapper1);
       System.debug('==lstAlpha=='+lstAlpha);
       System.debug('==objWrapper1=='+objWrapper1);
        String queryString = 'SELECT Id, '+selectedFieldsLst+' FROM '+selectedObj +' ORDER BY Id ASC LIMIT 50000'; 
        queryList = Database.query(queryString);
        for(SObject obj : queryList){
            SObjectWrapperForRecord objWrapper = new SObjectWrapperForRecord();
            objWrapper.sObj = obj ;
            sObjectWrapperForRecord.add(objWrapper);
        } 
       
        System.debug('==sObjectWrapperForRecord=='+sObjectWrapperForRecord);
        return sObjectWrapperForRecord ;
    }
}