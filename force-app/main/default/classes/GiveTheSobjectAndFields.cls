public class GiveTheSobjectAndFields {

    public String name { get; set; }

	public list<SelectOption> ListObjects { get; set; }
	// public list<SelectOption> selectedobject { get; set; }
  
			Schema.DescribeSObjectResult DR_SObject;
	Map<String, Schema.sObjectField> mapToken_Fields;
	Map<String, Schema.sObjectType> mapToken_SObjects;
	List<String> sortedNames = new List<String>();
		public GiveTheSobjectAndFields() {

 
	// Find all objects
	mapToken_SObjects = Schema.getGlobalDescribe();
	sortedNames = new List<String>();
	sortedNames.addAll(mapToken_SObjects.keyset());
	sortedNames.Sort();
 
	 ListObjects = new List<SelectOption>();
	ListObjects.add(new SelectOption('', '-- NONE --', true));
	for (string nameSObject : sortedNames) {
		// Use sObject describe to find information about object...
		DR_SObject = mapToken_SObjects.get(nameSObject).getDescribe();
		if (DR_SObject.isSearchable() && DR_SObject.isUpdateable()) {
			// Field token map...
			mapToken_Fields = DR_SObject.fields.getMap();
			if (mapToken_Fields.containsKey('MetaphoneSource__c')) {
				ListObjects.add(new SelectOption(nameSObject, DR_SObject.getLabel()));
			}
		}
	}
		}
 /* public List<SelectOption> getName()
  {
    List<Schema.SObjectType> listSobject = Schema.getGlobalDescribe().Values();   
    System.debug(listSobject);  
    List<SelectOption> options = new List<SelectOption>();
    System.debug(options);
    for(Schema.SObjectType SobjectObj : listSobject)
    {
       options.add(new SelectOption(SobjectObj.getDescribe().getLabel(),SobjectObj.getDescribe().getLabel()));
        System.debug(options);
    }
    return options;
   
  }*/
//  System.debug(options);
	
}