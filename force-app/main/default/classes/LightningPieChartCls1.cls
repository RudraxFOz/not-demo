public with sharing class LightningPieChartCls1 {
    // @AuraEnabled
    // public List<String> childObjLst ;
    @auraEnabled 
    public List<String> childObjLst{get;set;}
    @AuraEnabled
    public static List<String> fetchAllObject(){
        List<Schema.SObjectType> allObj = Schema.getGlobalDescribe().Values();    
        List<String> options = new List<String>();
        for(SObjectType oneByoneObj : allObj) {
            DescribeSObjectResult describeSobj = oneByoneObj.getDescribe();
            if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() && describeSobj.isCreateable() && describeSobj.isDeletable() && describeSobj.isUndeletable() ) {
                options.add(oneByoneObj.getDescribe().getName());
                options.sort();     
            }  
        }
        System.debug('options--->>' + options);
        return options;
    }
    
    @AuraEnabled
    public static List<sObject> fetchChildObj(String selectedObject){
        Map<String,sObject> returnValueMap = new Map<String,sObject>();
        LightningPieChartCls1 obj = new LightningPieChartCls1();
        obj.childObjLst = new List<String>();
        Set<String> childObjSet = new Set<String>();
        Set<String> childRelationShipNameSet = new Set<String>(); 
        Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
        Schema.sObjectType objType = globalDescription.get(selectedObject); 
        String childRelationShipName1 = '';
        for(Schema.ChildRelationship child : objType.getdescribe().getChildRelationships()) {
            DescribeSObjectResult describeSobj = child.getChildSObject().getDescribe();
            if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() && describeSobj.isCreateable() && describeSobj.isDeletable() && describeSobj.isUndeletable() ) {
                String childObj = ''+child.getChildSObject();
                System.debug('==childObj@@=='+childObj);
                String childRelationShipName = child.getRelationshipName();
                System.debug('==childRelationShipName@@=='+childRelationShipName);
                childRelationShipNameSet.add(childRelationShipName);
                childObjSet.add(childObj);
            } 
        }
        System.debug('==set of child obj=='+childObjSet);
        childRelationShipNameSet.remove(null);
        System.debug('==set of childRelationShipNameSet obj=='+childRelationShipNameSet);
        obj.childObjLst.addAll(childRelationShipNameSet);
        System.debug('childObj=='+obj.childObjLst);
       
        String childObjRel = '';
        for(String oneObj : childRelationShipNameSet) {
            if(String.isNotBlank(oneObj) ) {
                System.debug('==oneObj=='+oneObj);
                childObjRel = childObjRel + ', ' + '(SELECT Id FROM ' + oneObj + ')';  
            }  
        }
        System.debug('==childRel=='+childObjRel); 
        String lst = 'SELECT Id, Name '+childObjRel+' FROM '+selectedObject;
        List<sObject> sobjList = Database.query(lst);
        System.debug('==sobjList=='+sobjList);
        // String profileName = (String)sobjList.get('Name');
        // System.debug(profileName);
        List<sObject> lstopp = new List<sObject>(); 
        //Map<String,Integer> mapLeadSource = new Map<String,Integer>();
        // for( Integer i=0; i<sobjList.size(); i++) {
        //     System.debug('==qwq=='+sobjList[i]);
        // }
        for(sObject l : sobjList) {
            System.debug('==@lll=='+l);
            // if(mapLeadSource.containsKey(l.)) {

            // }
        }
        //fetchChildOfObject();
        return sobjList;
    }

    @AuraEnabled
    public Static List<String> fetchChildOfObject( String selectedObject) {
        LightningPieChartCls1 obj = new LightningPieChartCls1();
        System.debug('@@====childObj==11121211'+obj.childObjLst);

        List<String> childObjLst = new List<String>();
        Set<String> childObjSet = new Set<String>();
        Set<String> childRelationShipNameSet = new Set<String>(); 
        Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
        Schema.sObjectType objType = globalDescription.get(selectedObject); 
        String childRelationShipName1 = '';
        for(Schema.ChildRelationship child : objType.getdescribe().getChildRelationships()) {
            DescribeSObjectResult describeSobj = child.getChildSObject().getDescribe();
            if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() && describeSobj.isCreateable() && describeSobj.isDeletable() && describeSobj.isUndeletable() ) {
                String childObj = ''+child.getChildSObject();
                System.debug('==childObj@@=='+childObj);
                String childRelationShipName = child.getRelationshipName();
                System.debug('==childRelationShipName@@=='+childRelationShipName);
                childRelationShipNameSet.add(childRelationShipName);
                childObjSet.add(childObj);
            } 
        }
        System.debug('==set of child obj=='+childObjSet);
        childRelationShipNameSet.remove(null);
        System.debug('==set of childRelationShipNameSet obj=='+childRelationShipNameSet);
        childObjLst.addAll(childRelationShipNameSet);
        System.debug('childObj=='+childObjLst);
        return childObjLst ;
       
    }
    
    @AuraEnabled
    public static String getOpportunityJSON() {
        List<sObject> lstopp = new List<sObject>(); 
        Map<String,Integer> mapLeadSource = new Map<String,Integer>();
        // for(sObject l : lstopp) {
            
        //     if(mapLeadSource.containsKey(l.stagename)) {
            
        //         mapLeadSource.put(l.stagename, mapLeadSource.get(l.stagename)+1) ;
        //     } else {
        //         mapLeadSource.put(l.stagename, 0) ;        
        //     }
        // }
        // system.debug('map values--'+mapLeadSource);
         list<RadarDataWrapper> radarData = new list<RadarDataWrapper>();
        // for(String key : mapLeadSource.keySet()) {         
        //    RadarDataWrapper rdw = new RadarDataWrapper();
        //     rdw.name=key;
        //     rdw.y=mapLeadSource.get(key);
        //     radarData.add(rdw);
        // }
        // system.debug('rdw---'+radarData);
        return System.json.serialize(radarData);
        //return null;
    }
    
   
    class RadarDataWrapper {
    
       @AuraEnabled
       public String name;
       @AuraEnabled
       public integer y;
      
    }   

    class ChildObjectWrapper {
        @AuraEnabled
        public  string name ;
            
   
    }

}