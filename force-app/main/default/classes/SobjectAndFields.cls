public class SobjectAndFields {
	public List<sObject> queryOnRecord {get;set;}
	 // public List<string> lstFlds {get;private set;}

    public String selectedObject { get; set; }
   // public  list<sobject> records{ get; set; }
    /*public String changeFiled { get; set; }
    public List<SObject> rec = new List<SObject>();*/
 //   public String selectedField { get; set; }
    List<String> picklistValues = new List<String>();
    Public List<String> showField { get; set; }
    Public List<String> leftSelected {get;set;}
    Public List<String> rightSelected {get;set;}
    Set<String> leftValues = new Set<String>();
    Set<String> rightValues = new Set<String>();
    //List<selectOption> copyAllFields = new List<selectOption>();
    //FatchTheRecordForSobject obj = new FatchTheRecordForSobject();
    //SobjectAndFields objectTest = new SobjectAndFields();
   // String objName ;
   //String fieldGetName = '';
    public List<String> filedName = new  List<String>();
   // public List<String> listOfFiledName { get; set; }
   //public  List<String queryR;
   // public List<String> recordList;
   // System.debug('objName');
     //List<SelectOption> options = new List<SelectOption>();

//showField.clear();
    public SobjectAndFields() {
    	showField = new List<String>();
    	//lstFlds = new List<String>();
        leftSelected = new List<String>();
        //listOfFiledName = new List<String>();
        rightSelected = new List<String>();
        //filedName = new  List<String>(); 
     //   recordList = new List<String>();
        leftValues.addAll(picklistValues);
    }


    /* This Getter is Return The All Sobject That in Our Org. Return On VF Page */
    public SelectOption[] getObjectOptions() {
        SelectOption[] allSobj = new SelectOption[] { new SelectOption('','-- none --') };
      
        for( SObjectType valueOfSobj : Schema.getGlobalDescribe().values() ) {
        	//System.debug(valueOfSobj);
            DescribeSObjectResult describeSobj = valueOfSobj.getDescribe();
           // System.debug(describeSobj);

            if ( describeSobj.isSearchable() && describeSobj.isUpdateable() && describeSobj.isAccessible() && describeSobj.isQueryable() ) {
            	
           		 allSobj.add(new SelectOption( describeSobj.getName(), describeSobj.getLabel() ));
           		/* System.debug(selectedObject);
           		 System.debug(allSobj);*/
            }
        }
        return allSobj;
    }


    /* This getter return All The fields of Selected Object on The Vf Page*/
    public SelectOption[] getFieldOptions() {
        SelectOption[] allFields = new SelectOption[] { new SelectOption('','-- none --') };
       // Set<String> picklistValues = new Set<String>();
        if( selectedObject != null) {
            for( SObjectField fieldSobj : Schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap().values()) {
                System.debug(fieldSobj);
                DescribeFieldResult describeSobjField = fieldSobj.getDescribe();
                System.debug(describeSobjField);
               
               if( describeSobjField.isAccessible() ) {
               
               		 allFields.add(new SelectOption(describeSobjField.getName(), describeSobjField.getLabel()));

               }
            }

            System.debug(allFields);
           /*
			for(SelectOption changeInStr : fieldSobj) {
   					 picklistValues.add(changeInStr.getValue());
			}
			System.debug(picklistValues);*/
            
        }
        return allFields;
    }


	public PageReference getSelect() {
        rightSelected.clear();

        //System.debug(leftSelected);
        for( String s : leftSelected ) {
        	System.debug(s);
            leftValues.remove(s);
            System.debug(leftValues);
            rightValues.add(s);
        }
        return null;
    }
     

    public PageReference getDeselect(){    
        leftSelected.clear();
        for(String s : rightSelected){
            rightValues.remove(s);
            leftValues.add(s);
        }
        return null;
    }
     
    public List<SelectOption> getDeselectedValues(){
       List<SelectOption> options = new List<SelectOption>();
        List<String> objList = new List<String>();
        objList.addAll(leftValues);
        objList.sort();
        system.debug('Deselect Value:'+objList);
        for(String s : objList){
            options.add(new SelectOption(s,s));
        }
        return options;
    }
     
    public List<SelectOption> getSelectedValues(){
           System.debug(leftValues);
        List<SelectOption> options = new List<SelectOption>();
        List<String> objList = new List<String>();
        showField.addAll(rightvalues);
        /*objList.addAll(rightvalues);
        objList.sort();*/
      //  showField.sort();
        //FatchTheRecordForSobject obj = new FatchTheRecordForSobject();
       // obj.findTheRecord(objList);
        system.debug('Select Value:'+showField);
       // String getNameField = objList.getName();
        //for()
       /* for(selectOption ChangeToString : objList) {
        	String nameOfFiled = ChangeToString.getName();
        	fieldGetName += nameOfFiled +',';
        	//fieldGetName +=',';
        }*/
        for(String s : showField){
        	//obj.findTheRecord(s);
        	/*
        	fieldGetName += s.getName();
        	//getName
        	fieldGetName += ',';*/
        	// filedName.add(s);
        	// System.debug(filedName);
        	//. fieldGetName += s+',';
            options.add(new SelectOption(s,s));
            System.debug(options);
        }
        return options;
    }


    public void FatchTheRecord() {
    	try {
    	//String selectField = String.join(filedName+',');
    	//List<String> listVariable = new List<String>(filedName);

    	//String selectField = ', ';

		String s=String.join(showField,',');

    	System.debug(s);
    	 string queryR = 'select Id,'+s+' from '+selectedObject;
    	 System.debug(queryR);
    	 queryOnRecord = Database.query(queryR);
    	 System.debug(queryOnRecord);
    	}
    	catch(Exception e) {
    		ApexPages.addMessages(e);
    	}
    	//showField.clear();

    }


}