public  class SobjectAndFieldsController {
    public Static List<SelectOption> listOfSObject {get; set;}
    public Static List<SobjectAndFieldsWrapper> listOfSobjectFieldWrapper{get;set;}
    //private Static List<SobjectAndFieldsWrapper.SobjectWrapper> listOfSobjectWrapper{get;set;}
    //private Static List<string> removeAddress = new List<string> {'Id','IsDeleted'};
    public SobjectAndFieldsController() {
        listOfSObject = new List<SelectOption>();
        listOfSObject = allsObjectList();  
    }

    /* This Getter is Return The All Sobject That in Our Org. Return On VF Page */
    public Static SelectOption[] allsObjectList() {
        //listOfSobjectWrapper= new List<SobjectAndFieldsWrapper.SobjectWrapper>();
        SelectOption[] allSobj = new SelectOption[] { new SelectOption('', '-- none --') };
        for( SObjectType valueOfSobj : Schema.getGlobalDescribe().values() ) {
            DescribeSObjectResult describeSobj = valueOfSobj.getDescribe();
            if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() && describeSobj.isCreateable() && describeSobj.isDeletable() && describeSobj.isUndeletable()) {
                allSobj.add(new SelectOption( describeSobj.getName(), describeSobj.getLabel() ));
            }
            allSobj.sort();
        }
        return allSobj;
    }


    @RemoteAction
    public Static SobjectAndFieldsWrapper[] changedObject(String selectedObject) {
        listOfSobjectFieldWrapper= new List<SobjectAndFieldsWrapper>();
        if(!String.isEmpty(selectedObject)) {
            for(SObjectField fieldSobj : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
                Schema.DescribeFieldResult describeSobjField = fieldSobj.getDescribe();
                if(describeSobjField.isAccessible() && describeSobjField.isUpdateable()&& describeSobjField.isFilterable() ) {
                    SobjectAndFieldsWrapper objOfSobjectWrapper = new SobjectAndFieldsWrapper();
                    objOfSobjectWrapper.label = describeSobjField.getLabel();
                    objOfSobjectWrapper.value = describeSobjField.getName();
                    listOfSobjectFieldWrapper.add(objOfSobjectWrapper);
                }
            }
        }
        return listOfSobjectFieldWrapper;
    }

}