public class ServerSidePagiCmdController {
    //------------------------------------------------------WRAPPER TO HOLD OBJECT API NAME WITH ITS LABEL---------------------------------------------------------
    public class SObjectTypeWrapper implements Comparable { //WORKS FOR BOTH SOBJECTS AND SOBJECT FIELDS
        public String apiName;
        public String label;
        public String keyPrefix; //USEFUL FOR ONLY SOBJECTS
        public boolean isNameField; //USEFUL FOR ONLY SOBJECT FIELDS

        public SObjectTypeWrapper(String apiName, String label, String keyPrefix, boolean isNameField){
            this.apiName = apiName;
            this.label = label;
            this.keyPrefix = keyPrefix; //FILLED W.R.T SOBJECT
            this.isNameField = isNameField; //FILLED W.R.T SOBJECT FIELD
        }

        public Integer compareTo(Object compareTo) {
            SObjectTypeWrapper sow = (SObjectTypeWrapper)compareTo;
            if(label > sow.label){
                return 1;
            }else if(label < sow.label){
                return -1;
            }else{
                return 0;
            }
        }
    }
    //--------------------------------------------------------------------- METHODS ---------------------------------------------------------------------------------
    //1. FETCHS SOBJECT LIST FROM OBJECT SCHEMA
    @AuraEnabled
    public static String doInitSObjectList(){
        String result = '[';
        result += '{"label":"-None-","value":"none","keyPrefix":""},';
        Map<String, Schema.sObjectType> schemaMap = Schema.getGlobalDescribe();
        List<SObjectTypeWrapper> objList = doGetEssentialObjects(schemaMap); //Map<apiName,label>
        objList.sort();
        for(SObjectTypeWrapper obj : objList){
            result += '{"label":"' + obj.label + '","value":"' + obj.apiName + '","keyPrefix":"' + obj.keyPrefix + '"},';
        }
        return result.removeEnd(',') + ']';
    }

    //2. FETCHS SOBJECT FIELDS LIST FROM SOBJECT SCHEMA
    @AuraEnabled
    public static string doInitFieldList(String sObjectApiName){
        Map<String, Schema.sObjectField> fieldMap = Schema.getGlobalDescribe().get(sObjectApiName).getDescribe().fields.getMap();        
        List<SObjectTypeWrapper> fieldList = doGetEssentialFields(fieldMap); //Map<apiName,label>
        fieldList.sort();
        Integer resultSize = database.countQuery('SELECT COUNT() fROM ' + sObjectApiName); // query to count resultSize
        String nameField = '';
        String fields = '';
        for(SObjectTypeWrapper field : fieldList){
            fields += '{"label":"' + field.label + '","value":"' + field.apiName + '"},';
            if(field.isNameField){
                nameField = field.apiName;
            }
        }
        return '{"resultSize":"' + resultSize + '", "nameField":"' + nameField + '","fields":[' + fields.removeEnd(',') + ']}';
    }

    //3. FILTERS UNWANTED OBJECTS FROM RETRIVED OBJECT LIST
    private static List<SObjectTypeWrapper> doGetEssentialObjects(Map<String, Schema.sObjectType> schemaMap){
        List<SObjectTypeWrapper> result = new List<SObjectTypeWrapper>();
        for(String apiName : schemaMap.keySet()){
            DescribeSObjectResult dsr = schemaMap.get(apiName).getDescribe();
            if(dsr.isCreateable() && dsr.isDeletable() && dsr.isUpdateable()){
                result.add(new SObjectTypeWrapper(apiName, dsr.getLabel(), dsr.getKeyPrefix(), null)); //isNameField is not applicable for sobject
            }
        }
        return result;
    }

    //4. FILTERS UNWANTED FIELDS FROM RETRIVED FIELD LIST
    private static List<SObjectTypeWrapper> doGetEssentialFields(Map<String, Schema.sObjectField> fieldMap){
        List<SObjectTypeWrapper> result = new List<SObjectTypeWrapper>();
        for(String apiName : fieldMap.keySet()){
            DescribeFieldResult dfr = fieldMap.get(apiName).getDescribe();
            if(dfr.isAccessible() && dfr.isSortable()){
                result.add(new SObjectTypeWrapper(apiName, dfr.getLabel(), null, dfr.isNameField())); //keyprefix is not applicable for sobject field
            }
        }
        return result;
    }

    //5. GENERATE QUERY BASED ON SELECTED FIELDS
    @AuraEnabled
    public static string doQueryForRecords(String queryString, Boolean isReversedList){
        List<sobject> records = database.query(queryString);
        if(isReversedList){
            records = reverse(records);
        }
        Integer startIndex = queryString.indexOf('SELECT ') + 'SELECT '.length();
        Integer endIndex = queryString.indexOf(' FROM');
        String commaSeparatedFields = queryString.substring(startIndex, endIndex);
        List<String> fields = commaSeparatedFields.split(',');
        String result = '[';
        for(sObject record : records){
            result += '{';
            for(String field : fields){
                result += '"' + field + '":"' + record.get(field) + '",';
            }
            result = result.removeEnd(',');
            result += '},';
        }
        return result.removeEnd(',') + ']';
    }

    //6. REVERSES AN OBJECT LIST
    private static List<sobject> reverse(List<sobject> records){
        List<sobject> result = new list<sobject>();
        for(Integer i = records.size()-1 ; i >= 0 ; i--){
            result.add(records[i]);
        }
        return result;
    }
}