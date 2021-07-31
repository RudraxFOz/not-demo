public class TaskManagerChart {

    @AuraEnabled
    public static List<String> fetchAllObject(){
        List<Schema.SObjectType> allObj = Schema.getGlobalDescribe().Values();    
        List<String> options = new List<String>();
        for(SObjectType oneByoneObj : allObj){
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
    public static List<String> fetchChildObj(String selectedObject){
        Set<String> childObjSet = new Set<String>();
        List<String> childObjLst = new List<String>();
        Map<String , Schema.SObjectType> globalDescription = Schema.getGlobalDescribe();
        Schema.sObjectType objType = globalDescription.get(selectedObject); 

        for(Schema.ChildRelationship child : objType.getdescribe().getChildRelationships()) {
            DescribeSObjectResult describeSobj = child.getChildSObject().getDescribe();
            if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() && describeSobj.isCreateable() && describeSobj.isDeletable() && describeSobj.isUndeletable() ) {
                String childObj = '' +child.getChildSObject();
                childObjSet.add(childObj);
            }
        }
        System.debug('==list of child obj=='+childObjSet);
        childObjLst.addAll(childObjSet);
        return childObjLst;
    }
    
    @AuraEnabled
    public static String getOpportunityJSON() {
        
        List<opportunity> lstopp = [SELECT Id FROM opportunity]; 
        Map<String,Integer> mapLeadSource = new Map<String,Integer>();
        
        for(opportunity l : lstopp) {
        
            if(mapLeadSource.containsKey(l.stagename)) {
            
                mapLeadSource.put(l.stagename, mapLeadSource.get(l.stagename)+1) ;
            } else {
                mapLeadSource.put(l.stagename, 0) ;        
            }
        }
        system.debug('map values--'+mapLeadSource);
        list<RadarDataWrapper> radarData = new list<RadarDataWrapper>();
        
        for(String key : mapLeadSource.keySet()) {
                   
           RadarDataWrapper rdw = new RadarDataWrapper();
            rdw.name=key;
            rdw.y=mapLeadSource.get(key);
            radarData.add(rdw);
        }
        system.debug('rdw---'+radarData);
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