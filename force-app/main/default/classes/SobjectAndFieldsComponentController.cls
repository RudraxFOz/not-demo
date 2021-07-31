public with sharing class SobjectAndFieldsComponentController {
	private Static List<SObject> queryOnRecord {get; set;}

	@RemoteAction
    public static Set<String> queryForRecord(String selectFields, String selectedObject, String enterValueInText) {
    	System.debug('Ehert word in text ' + enterValueInText) ;
    	String newString = '\''  + enterValueInText + '%' + '\''; 
        queryOnRecord= new List<SObject>();
        Set<String> selectedFieldData = new Set<String>();    
        String queryR = 'SELECT Id,' + selectFields + ' FROM ' + selectedObject + ' WHERE ' + selectFields + ' LIKE ' +  newString  ;
        System.debug(queryR);
        queryOnRecord = Database.query(queryR);
        System.debug(queryOnRecord);
        for(sobject s : queryOnRecord){
            selectedFieldData.add(String.valueOf(s.get(selectFields)));
        }
        return selectedFieldData;
    }

    @RemoteAction
    public Static list<Sobject> showTheRecord(String selectFields,String selectedObject,String selectRecord) {
    	System.debug(selectRecord);
        queryOnRecord = new List<SObject>();        
        //String newString = '\''+ selectRecord + '\''; 
        String newString = '\''  + selectRecord + '%' + '\''; 
        String queryR = 'SELECT Id,' + selectFields + ' FROM ' + selectedObject + ' WHERE ' + selectFields + ' LIKE ' +  newString  ;
        queryOnRecord = Database.query(queryR);
        return queryOnRecord;
    }

    @RemoteAction
    public Static void saveTheRecordAfterEdit(String selectedObject,String jsonStringOfRecord) {
    	list<object> allIdAndRecord = (List<object>) JSON.deserializeUntyped(jsonStringOfRecord);
		List<sobject> listOfSobj = new List<sobject>();
		for(Object objAllIdAndRecord : allIdAndRecord){
			SObject selectObj = Schema.getGlobalDescribe().get(selectedObject).newSobject();
			Map<string,object> mapAllIdAndRecord = (Map<string,object>) objAllIdAndRecord;
			for(String getThaValueFormMap : mapAllIdAndRecord.keySet()){
				selectObj.put(getThaValueFormMap,mapAllIdAndRecord.get(getThaValueFormMap));
			}
			listOfSobj.add(selectObj);
		}
		update listOfSobj;
    }
}