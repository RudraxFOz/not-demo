public with sharing class DynamicKanbanMainComponentController {

    @AuraEnabled(cacheable=true)
    public static List<ParentChildObjectRecordsWrapper> getSobjectRecords(String primaryObject, String secondaryObject, String secondaryObjSelectedFields){
        List<ParentChildObjectRecordsWrapper> parentChildRecObj = new List<ParentChildObjectRecordsWrapper>();
        //String primaryObject = getObjectById;
        Schema.SObjectType sobjectTypeObj = ((SObject) Type.forName(primaryObject).newInstance()).getSObjectType();
        System.debug('sobjectTypeObj is '+ sobjectTypeObj);
        String childObjRelationshipName ;
        List<SObject> parentSobjectList = new  List<SObject>();
        List<SObject> childSobjectList = new  List<SObject>();
        List<String> parentRequiredFieldList = new  List<String>();
        List<String> childObjFieldList = secondaryObjSelectedFields.split(',');
        //String requiredFieldStr;
        Schema.DescribeSObjectResult obj = sobjectTypeObj.getDescribe(); 
        System.debug('==obj=='+obj.getChildRelationships());
        for (Schema.ChildRelationship cr: obj.getChildRelationships()) {
            String objTypeToString = String.valueOf(cr.getChildSObject());
            System.debug('objType is ' + cr.getChildSObject());
            if (objTypeToString == secondaryObject) {
                System.debug('==cr=='+cr);
                System.debug('Child Object Relationship Name:'+cr.getRelationshipName());
                childObjRelationshipName = cr.getRelationshipName();
            }     
        }


        Map<String,Schema.SObjectField> fields = obj.fields.getMap() ;   
        for(String field : fields.keyset()) {
            Schema.DescribeFieldResult desribeResult = fields.get(field).getDescribe();
            if( desribeResult.isCreateable()  && !desribeResult.isNillable() && !desribeResult.isDefaultedOnCreate()) {
                //This is mandatory / required field
                system.debug('///' + field ); 
                parentRequiredFieldList.add(field.capitalize());
                //requiredFieldStr = ', ' + requiredFieldStr
            }
        }
       // parentRequiredFieldList.add('Status__c');
        //parentRequiredFieldList.add('Phone');
        String requiredFieldStr = String.join(parentRequiredFieldList,',');
        String query = 'SELECT Id,' + requiredFieldStr +',(SELECT Id, ' + secondaryObjSelectedFields + ' FROM ' + childObjRelationshipName +')  FROM ' + primaryObject +' LIMIT 5';
        System.debug('==query=='+query);
        list<SObject> records = Database.query(query);
        System.debug('==records=='+records);

        for(SObject parentObj : records){
            //sObjectList.add(record);
            parentSobjectList.add(parentObj);
            for(SObject childObj : parentObj.getSObjects(childObjRelationshipName)) {
               system.debug('childObj=' + childObj);
               childSobjectList.add(childObj);
            }
        }
        //List<String> primaryObjSelectedFieldList = primaryObjSelectedFields.split(',');
        parentChildRecObj.add(new ParentChildObjectRecordsWrapper(parentSobjectList,parentRequiredFieldList,childSobjectList,childObjFieldList,childObjRelationshipName));



        // List<String> primaryObjSelectedFieldList = primaryObjSelectedFields.split(',');
        // parentChildRecObj.add(new SobjectRecordsWrapper(records,primaryObjSelectedFieldList));
        System.debug('==parentChildRecObj==parentChildRecOb=='+parentChildRecObj);
        return parentChildRecObj;


    }

    
    @AuraEnabled
    public static void updateAcc(String newConId, String newAccId, String childObjRelationsName){
        System.debug('==newConId=='+newConId);
        System.debug('==newAccId=='+newAccId);
        System.debug('==childObjRelationsName=='+childObjRelationsName);
       // Schema.SObjectType sObjName =  newConId.getsobjecttype();
        //String sObjNameStr = String.valueOf(sObjName);
        Id myRecordId = newConId;
        String sObjName = myRecordId.getSObjectType().getDescribe().getName();
        Schema.SObjectType sobjectTypeObj = ((SObject) Type.forName(sObjName).newInstance()).getSObjectType();
        String query = 'SELECT Id FROM Contact';
        list<Contact> records = [SELECT Id FROM Contact WHERE Id =:newConId];  
        System.debug('==records=='+records);
        records[0].AccountId = newAccId;
        if(records.size() > 0) {
            update records;
        }
         

    }



    public class ParentChildObjectRecordsWrapper {
        @AuraEnabled public List<SObject> parentRecords;
        @AuraEnabled public List<SObject> childRecords;
        @AuraEnabled public List<String> parentObjFields;
        @AuraEnabled public List<String> childObjFields;
        @AuraEnabled public String childObjRelationName;
        public ParentChildObjectRecordsWrapper(List<SObject> parentRecords, List<String> parentObjFields, List<SObject> childRecords,  List<String> childObjFields, String childObjRelationName) {
            this.parentRecords = parentRecords;
            this.parentObjFields = parentObjFields;
            this.childRecords = childRecords;
            this.childObjFields = childObjFields;
            this.childObjRelationName = childObjRelationName;
        }

        // public class childObjectRecordsWrapper {
        //     @AuraEnabled public List<SObject> childRecords;
        //     @AuraEnabled public List<String> childObjFields;
        //     public childObjectRecordsWrapper(List<SObject> childRecords,  List<String> childObjFields) {
        //         this.childRecords = childRecords;
        //         this.childObjFields = childObjFields;
        //     }
        // }
    }
}