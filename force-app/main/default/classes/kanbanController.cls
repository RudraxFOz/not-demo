public class kanbanController {
    
    @AuraEnabled
    public static kanbanWrap getKanbanWrap(String objName, String[] objFields, String kanbanField) {
        List<String> lstPickvals = new List<String>();
        for (Schema.PicklistEntry a : Schema.getGlobalDescribe().get(objName).getDescribe().fields.getMap().get(kanbanField).getDescribe().getPickListValues())
            lstPickvals.add(a.getValue());
        System.debug(lstPickvals);
        
        String query = 'SELECT Id, ';
        for(String s:objFields){
            query += s+' ,';
        }
        query = query.removeEnd(',');
        query += ' FROM ' + objName;
        System.debug('qq  ' + query);
        //SELECT lstPickvals value, COUNT(Id) recordCount FROM objName GROUP BY lstPickvals 
         System.debug('qq qqq ' + Database.query(query));
        return new kanbanWrap(Database.query(query), lstPickvals);
    }
    
    @AuraEnabled
    public static kanbanWrapForUpdate getUpdateStage(Id recId, String kanbanField, String kanbanNewValue) {
        SObject upadateRec = recId.getSObjectType().newSObject(recId);
        System.debug(upadateRec);
        upadateRec.put(kanbanField,kanbanNewValue);
        update upadateRec;
        kanbanWrapForUpdate objDT =  new kanbanWrapForUpdate();  
        objDT.recordss = [SELECT  ID, Name, AccountNumber, CreatedDate, Status__c FROM Account ];
        //return 'Success';
        return objDT;
    }
    
    
    
    public class kanbanWrap{
        @AuraEnabled
        List<sObject> records {get;set;}
        @AuraEnabled
        List<String> pickVals {get;set;}
       
        
        public kanbanWrap(List<sObject> recs, List<String> pVals){
            this.records = recs;
            this.pickVals = pVals;
        }
    }


    public class kanbanWrapForUpdate {
        @AuraEnabled
        List<Account> recordss {get;set;}

    }
    
}