public with sharing class CLookUpComponentController {
    @AuraEnabled
    public static List<sObject> fetchValueOfSobject(String searchKeyWord, String ObjectName, List<sObject> ExcludeitemsList, String junctionObjParentId, String junctionObjName, String junctionObjParentName, String junctionObjChildName) {
        
            system.debug('ObjectName-->' + objectName);
            system.debug('searchKeyWord-->' + searchKeyWord);
            system.debug('ExcludeitemsList-->' + ExcludeitemsList);
            String searchKey = '%' + searchKeyWord + '%';
            List < sObject > returnList = new List < sObject > ();
            String parentIdForJun = junctionObjParentId;
     
            // List<string> lstExcludeitems = new List<string>();
            // for(sObject item : ExcludeitemsList ){
            //     lstExcludeitems.add(item.id);
            // }

            String sQuery1 =  'SELECT id, Name, ' + junctionObjParentName + ' , '+ junctionObjChildName +' FROM ' +junctionObjName + ' WHERE '+ junctionObjParentName + ' =: parentIdForJun order by createdDate DESC limit 49999';
            system.debug('sQuery1--111>' + sQuery1);
            List <sObject> lstOfRecords1 = Database.query(sQuery1);
            Map<Id, List <sObject>> m1 = new Map<Id, List <sObject>>();

           
            // List<String> fieldsS1 = new list<String>();

            Schema.SObjectField sfield1  ;

            Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(junctionObjName).getDescribe().fields.getMap();
            Map<String, String> preDefinedMap = new Map<String, String>();
            for(Schema.SObjectField sfield : fieldMap.Values()){
                //fieldsS1.add(sfield.getdescribe().getname());
                 if(sfield.getdescribe().getname() == junctionObjChildName) {
                //     m1.put(obj1.sfield.getdescribe().getname(), obj1);
                    //sfield1 = sfield.getdescribe().getname();
                    system.debug('sfield.getdescribe().getname()--111>' + sfield.getdescribe().getname());
                }

                

            }

            for (sObject obj1: lstOfRecords1) {
                

               
                
            }

            // system.debug('m1--111>' + m1);

            // system.debug('lstOfRecords1--111>' + lstOfRecords1);
            
            // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  
            //String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey AND Id NOT IN : lstExcludeitems order by createdDate DESC limit 5';
            String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
            system.debug('sQuery--111>' + sQuery);
            List <sObject> lstOfRecords = Database.query(sQuery);

            
            
            for (sObject obj: lstOfRecords) {
                returnList.add(obj);
            }

            system.debug('lstOfRecords--111>' + lstOfRecords);
            return returnList;
        
        
    }


    
    @AuraEnabled
    public static List<sObject> fetchValueFromJunctionObj(String junctionObjParentId, String junctionObjName, String junctionObjParentName, String junctionObjChildName, String selectdRecList) {


        // List<string> lstExcludeitems = new List<string>();
        //     for(sObject item : ExcludeitemsList ){
        //         lstExcludeitems.add(item.id);
        //     }

        system.debug('junctionObjParentId-->' + junctionObjParentId);
        system.debug('junctionObjName-->' + junctionObjName);
        system.debug('junctionObjParentName-->' + junctionObjParentName);
        system.debug('junctionObjChildName-->' + junctionObjChildName);
        system.debug('selectdRecList-->' + selectdRecList);

        String sQuery ;
        
        if(junctionObjParentId != Null && junctionObjName != Null && junctionObjParentName != Null && junctionObjChildName != Null && selectdRecList != Null ) {
            String parentIdForJun = junctionObjParentId;
            sObject obj = Schema.getGlobalDescribe().get(junctionObjName).newSObject();
            //obj.put('Name', 'TestForApex');
            obj.put(junctionObjParentName, junctionObjParentId);
            obj.put(junctionObjChildName, selectdRecList);
            insert obj;
        }

        List < sObject > returnList = new List < sObject > ();
     
        // List<string> lstExcludeitems = new List<string>();
        // for(sObject item : ExcludeitemsList ){
        //     lstExcludeitems.add(item.id);
        // }
        
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  

        if(selectdRecList != Null ) {
            sQuery =  'SELECT id, Name FROM ' +junctionObjName + ' WHERE '+ junctionObjParentName + ' =: parentIdForJun AND '+ junctionObjChildName +' != null order by createdDate DESC limit 49999';
        } else {
            sQuery =  'SELECT id, Name FROM ' +junctionObjName + ' WHERE '+ junctionObjParentName + ' =: parentIdForJun order by createdDate DESC limit 49999';
        }
        system.debug('sQuery-->' + sQuery);
        List <sObject> lstOfRecords = Database.query(sQuery);
        
        for (sObject obj1: lstOfRecords) {
            returnList.add(obj1);
        }

        system.debug('returnList-->' + returnList);
        return returnList;
    }



    @AuraEnabled
    public static void deleteJunctionRec(String junctionObjId ) {

        if(junctionObjId != Null ) {
            Id junctionId = junctionObjId;
            sObject getSobject = junctionId.getSobjectType().newSobject(junctionId);
            delete getSobject;
        }
        //Database.delete(junctionObjId);

    }
}