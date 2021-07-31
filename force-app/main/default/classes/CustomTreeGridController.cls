public with sharing class CustomTreeGridController {
 
    @AuraEnabled(cacheable=true)
    public static List<SobjectRecordsWrapper> getRecords(String primaryObject, String secondaryObject, String primaryObjSelectedFields, String secondaryObjSelectedFields){
        
        List<SobjectRecordsWrapper> sObjectRecList = new List<SobjectRecordsWrapper>();
        System.debug('==primaryObjSelectedFields=='+primaryObjSelectedFields);
        try {
            if(String.isNotBlank(primaryObject) && primaryObjSelectedFields != null){
                String query = 'SELECT Id, ' + primaryObjSelectedFields + ' FROM '+primaryObject + ' LIMIT 10';
                System.debug('==query=='+query);
                list<SObject>  records = Database.query(query);
                List<String> primaryObjSelectedFieldList = primaryObjSelectedFields.split(',');
                sObjectRecList.add(new SobjectRecordsWrapper(records,primaryObjSelectedFieldList));
                System.debug('==sObjectRecList=='+sObjectRecList[0].selectFields);
                return sObjectRecList;
            }
            return null;
        } catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }    
    }

    
    @AuraEnabled(cacheable=true)
    public static List<SobjectRecordsWrapper> getChildRecords(Id objectId, String primaryObject, String secondaryObject, String primaryObjSelectedFields, String secondaryObjSelectedFields){
        System.debug('objectId is '+ objectId);
        Schema.SObjectType getObjectById =  objectId.getsobjecttype();
        System.debug('object is '+ getObjectById);
        List<SobjectRecordsWrapper> sObjectRecList = new List<SobjectRecordsWrapper>();
        //String primaryObject = getObjectById;
    //      Schema.SObjectType sobjectTypeObj = ((SObject) Type.forName(primaryObject).newInstance()).getSObjectType();
    //      System.debug('sobjectTypeObj is '+ sobjectTypeObj);
        String ss ;
        List<SObject> sObjectList = new  List<SObject>();
    
       Schema.DescribeSObjectResult obj = getObjectById.getDescribe(); 
        System.debug('==obj=='+obj.getChildRelationships());
        for (Schema.ChildRelationship cr: obj.getChildRelationships()) {
            String objType = String.valueOf(cr.getChildSObject());
            System.debug('objType is ' + cr.getChildSObject());
            if (objType == secondaryObject) {
                System.debug('==cr=='+cr);
                System.debug('Child Object Relationship Name:'+cr.getRelationshipName());
                ss = cr.getRelationshipName();
            }     
        }

        String query = 'SELECT Id, (SELECT Id, ' + secondaryObjSelectedFields + ' FROM ' + ss +')  FROM ' + primaryObject ;
        System.debug('==query=='+query);
        list<SObject> records = Database.query(query+ ' WHERE Id = :objectId');
        System.debug('==records=='+records);

        for(SObject record : records){
            //sObjectList.add(record);
           
            for(SObject child : record.getSObjects(ss)) {
               // System.debug('==child RRR=='+ child.getChildRelationships());
               system.debug('Child=' + child);
               sObjectList.add(child);
            }
        }
        List<String> primaryObjSelectedFieldList = primaryObjSelectedFields.split(',');
        sObjectRecList.add(new SobjectRecordsWrapper(sObjectList,primaryObjSelectedFieldList));

        // List<String> primaryObjSelectedFieldList = primaryObjSelectedFields.split(',');
        // sObjectRecList.add(new SobjectRecordsWrapper(records,primaryObjSelectedFieldList));
        System.debug('==sObjectRecList==sObjectRecList=='+sObjectRecList);
        return sObjectRecList;


    }

    public class SobjectRecordsWrapper {
        @AuraEnabled public List<SObject> sObjectRecords;
        @AuraEnabled public List<String> selectFields;
        public SobjectRecordsWrapper(List<SObject> sObjectRecords, List<String> selectFields) {
            this.sObjectRecords = sObjectRecords;
            this.selectFields = selectFields;
        }
    }
}