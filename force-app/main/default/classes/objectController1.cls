public class objectController1
{
    public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    public String selectedObject {get; set;}
    public String selectedField {get; set;}
    public String picklistValue {get; set;}
    public List<sObject> lstobj {get; set;}
    public List<String> lstfields {get; set;}
    public List<String> fnlFields {get;set;}
    public List<SelectOption> fieldNames {get; set;}
   // public List<wrapData> bindData {get;set;}
       Public Integer size{get;set;} 

    public List<SelectOption> paginationSizeOptions{get;set;}
    Integer counter = 0;//TO track the number of records parsed
    Integer limitSize = 10;//Number of records to be displayed
    Integer totalSize =0; //To Store the total number of records available
    public List<sObject> datatoShow{get; set;}
    
    Public objectController1(){   
        selectedObject ='account';
        //system.debug('HI This is fields'+selectedField );
         paginationSizeOptions = new List<SelectOption>();
         paginationSizeOptions.add(new SelectOption('5','5'));
         paginationSizeOptions.add(new SelectOption('10','10'));
         paginationSizeOptions.add(new SelectOption('20','20'));
         paginationSizeOptions.add(new SelectOption('50','50'));
         paginationSizeOptions.add(new SelectOption('100','100'));
    }
    
    public List<SelectOption> getObjectNames(){
        List<SelectOption> objNames = new List<SelectOption>();
        List<String> entities = new List<String>(schemaMap.keySet());
        entities.sort();
        
        for(String name : entities){
            objNames.add(new SelectOption(name,name.toUpperCase()));
        }
        return objNames;
    }
    
    public List<SelectOption> getObjectFields(){
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType ObjectSchema = schemaMap.get(selectedObject);
        Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();
        fieldNames = new List<SelectOption>();
        for (String fieldName: fieldMap.keySet()){  
            fieldNames.add(new SelectOption(fieldName,fieldName.toUpperCase()));
            //fieldMap.get(fieldName).getDescribe().getLabel();//It provides to get the object fields label.
        }
        System.debug('fieldNames-----'+fieldNames);
        return fieldNames;
    }
    
    
    public PageReference Fetch(){
        
        lstobj = new List<sObject>();
        lstfields= new List<String>();
        fnlFields = new List<String>(); 
        datatoShow= new List<sObject>();
        //System.debug('Select'+selectedField +'From'+selectedObject);
        String s1= selectedField.removeStart('[');
        String s2= s1.removeEnd(']');
        
        String Query='Select '+s2+' From '+selectedObject;
        
        
        lstobj= Database.query(Query);
        System.debug('List '+lstobj);
        totalSize = lstobj.size();
        
        //Intial adding of contacts to ContactsToShow
        //check the total records are more than limitSize and assign the records
        if((counter+limitSize) <= totalSize){
            for(Integer i=0;i<limitSize;i++){
                datatoShow.add(lstobj.get(i));
            }
        }else{
            for(Integer i=0;i<totalSize;i++){
                datatoShow.add(lstobj.get(i));
            }
        }
        lstfields = s2.split(',');
        
        System.debug('---- lstFields: ' + lstFields);
        //System.debug('List of fields '+lstfields);
        for(String s : lstfields){
        
        fnlFields.add(s.trim());
        
        }
        System.debug(fnlFields);
        
        
        return null; 
    }  
     public void beginning(){
   
        datatoShow.clear();
        counter=0;
        if((counter + limitSize) <= totalSize){
       
            for(Integer i=0;i<limitSize;i++){
                datatoShow.add(lstobj.get(i));
            }   
           
        } else{
       
            for(Integer i=0;i<totalSize;i++){
                datatoShow.add(lstobj.get(i));
            }       
           
        }
       
    }
   
    public void next(){
   
        datatoShow.clear();
        counter=counter+limitSize;
       
        if((counter+limitSize) <= totalSize){
            for(Integer i=counter-1;i<(counter+limitSize);i++){
                datatoShow.add(lstobj.get(i));
            }
        } else{
            for(Integer i=counter;i<totalSize;i++){
                datatoShow.add(lstobj.get(i));
            }
        }
    }
   
    public void previous(){
   
        datatoShow.clear();

        counter=counter-limitSize;       
       
        for(Integer i=counter;i<(counter+limitSize); i++){
            datatoShow.add(lstobj.get(i));
        }
    }

    public void last (){
   
        datatoShow.clear();
       
        if(math.mod(totalSize , limitSize) == 0){
            counter = limitSize * ((totalSize/limitSize)-1);
        } else if (math.mod(totalSize , limitSize) != 0){
            counter = limitSize * ((totalSize/limitSize));
        }
       
        for(Integer i=counter-1;i<totalSize-1;i++){
                datatoShow.add(lstobj.get(i));
        }
       
    }
   
    public Boolean getDisableNext(){
   
        if((counter + limitSize) >= totalSize )
            return true;
        else
            return false ;
    }
   
    public Boolean getDisablePrevious(){
   
        if(counter == 0)
            return true;
        else
            return false ;
    } 
    public PageReference refreshPageSize() {
         
         return null;
         
    }
  
}