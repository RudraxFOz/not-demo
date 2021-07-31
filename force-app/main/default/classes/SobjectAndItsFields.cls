public  class SobjectAndItsFields {

	public String selectedObject { get; set; }
    public List<String> leftSelected {get;set;}
    public List<String> rightSelected {get;set;}
    public List<SelectOption> listOfSObject {get; set;}
    public List<SelectOption> allFields {get; set;}
    public List<SelectOption> rightOptionList {get; set;}
    public Boolean condition {get; set;}
    //public List<String> removeAddress ;
    List<string> removeAddress = new List<string> {'Name','AccountId'};
    //public List<SObject> queryOnRecord { get; set; }
   // public List<String> listOfSelectedFields { get; set; }
   

    public SobjectAndItsFields() {
        
        
        //listOfSelectedFields = new List<String>();
       // queryOnRecord = new  List<SObject>();
        //removeAddress = new List<String>();
       
        rightOptionList = new List<SelectOption>();
        selectedObject = '';
        allFields = new List<SelectOption>();
        leftSelected = new List<String>();
        rightSelected = new List<String>();
        listOfSObject = new List<SelectOption>();
        listOfSObject = allsObjectList();
        
    }



    /* This Getter is Return The All Sobject That in Our Org. Return On VF Page */
	public SelectOption[] allsObjectList() {
        SelectOption[] allSobj = new SelectOption[] { new SelectOption('','-- none --') };
       
        for( SObjectType valueOfSobj : Schema.getGlobalDescribe().values() ) {
            DescribeSObjectResult describeSobj = valueOfSobj.getDescribe();
            if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() && describeSobj.isCreateable() &&describeSobj.isDeletable() &&describeSobj.isUndeletable()) {
            	allSobj.add(new SelectOption( describeSobj.getName(), describeSobj.getLabel() ));

            }
            allSobj.sort();
        }
        return allSobj;
    }



    public void changedObject() {
         condition = false;
        if(!String.isEmpty(selectedObject)) {
            allFields.clear();
            rightOptionList.clear();
            for(SObjectField fieldSobj : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
                System.debug(fieldSobj);
                /*if(fieldSobj == 'BillingAddress') {
                    fieldSobj.remove(fieldSobj);
                }*/
                DescribeFieldResult describeSobjField = fieldSobj.getDescribe();
                
               
                if( describeSobjField.isAccessible() && describeSobjField.isUpdateable()) {
                    allFields.add(new SelectOption(describeSobjField.getName(), describeSobjField.getLabel()));
                }
                
                for(String selected : removeAddress) {
                    
                    for(Integer i=0; i<allFields.size(); i++) {
                        if(allFields[i].getValue() == selected) {
                           
                            allFields.remove(i);

                        }
                    }
                }

                allFields.sort();
            }
        }
    }


    
    public void addFromLetToRight() {
        //rightOptionList.clear();
        System.debug('-------------------------');
        List<String> listOfSel = new List<String>();
        for( String selected : leftSelected ) {
            for(Integer i=0; i<allFields.size(); i++) {
                if(allFields[i].getValue() == selected) {
                    rightOptionList.add( new SelectOption( allFields[i].getValue(), allFields[i].getLabel() ) );
                    allFields.remove(i);
                }
            }
            allFields.sort();
            rightOptionList.sort();
            System.debug(rightOptionList);
        }
        
    }



    public void addFromRightToLeft() {
        for(String selected : rightSelected) {
            System.debug(selected);
            for(Integer i=0; i<rightOptionList.size(); i++) {
                 if(rightOptionList[i].getValue() == selected) {
                     allFields.add(new SelectOption( rightOptionList[i].getValue(), rightOptionList[i].getLabel() ) );
                     rightOptionList.remove(i);

                 }
            }
            allFields.sort();
            rightOptionList.sort();
        }
    }
}