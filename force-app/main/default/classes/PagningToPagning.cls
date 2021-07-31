public with sharing class PagningToPagning {
    public List<SObject> queryOnRecord {get; set;}
    public List<SObject> delOnRecord {get; set;}
    public List<SelectOption> allSelectedFields {get; set;}
    public String selectedSObject {get; set;}
    public List<String> listOfSelectedFields { get; set;}
    public boolean flag {get; set;}
    public Integer totalRecord {get; set;}
    public Integer firstNumberOnBottom {get; set;}
    public Integer limitSize {get; set;}
    public Integer offSetSize {get; set;}
    public Integer SecondNumberOnBottom {get; set;}
    public List<SObject> quDemo ;
    public boolean change {get; set;}
    public List<SelectOption> listViewOfRecord {get; set;}
    public String selectHowManyRecordShow {get; set;}
    public Integer totalpageSize {get; set;}
    public Integer alphaTotalpageSize {get; set;}
    public Integer gopageSize {get; set;}
    public Integer pageSize {get; set;}
    public Boolean flagF {get; set;}
    public String RecPerPageSize {get; set;}
    public String SearchVar{get;set;}
    public List<SObject> ShowRec {get; set;}
    public Integer sizee{get;set;}
    public List<String> SerchAlpabet{get;set;}
    public string ecid {get;set;}  
    public string dcid {get;set;}  
    public String delField {get; set;}
    public String checkId {get; set;}
    public List<PagningToPagningWrapper> wrapperList {get; set;}
    public Integer  SecondNumberOnBottomR {get; set;}
    public List<SelectOption> SelectAndDeselect {get; set;}
    public String chooseSelectAndDeselect {get; set;}
    public List<SObject> alphaQueList {get; set;}
    public Integer alphaTotalRecord {get;  set;}
    public Set<Id> selectedCheckBoxIds  {get; set;}
    public Double totalpageSizeOfRec {get; set;}
    public Boolean findIdFormVf {get; set;}
    public String checkBoxRecId {get; set;}
    private Map<String, Boolean> checkBoxMap;
    private Map<Set<Id>, Boolean> masterCheckBoxMap;
    public Set<String> resultIds {get; set;}
    public String allRecordId {get; set;}
    public Integer off {get; set;}
    //public llistOfMasterChechBox
    public Boolean statusOfMasterCheckBox {get; set;}
    public Boolean passCondition {get; set;}
    Double allNumber ;

    public PagningToPagning() {
        passCondition = false;
        off = 0;
        statusOfMasterCheckBox = false;
        checkBoxMap = new Map<String, Boolean>();
        masterCheckBoxMap = new Map<Set<Id>, Boolean>();
        resultIds = new Set<String>();
        allRecordId ='';
        checkBoxRecId = '';
        wrapperList = new List<PagningToPagningWrapper>();
        findIdFormVf = false;
        totalpageSizeOfRec = 1;
        allNumber = 0.0;
        alphaQueList = new List<SObject>();
        alphaTotalRecord = 0;
        chooseSelectAndDeselect = '';
        selectedCheckBoxIds = new Set<Id>();
        ecid ='';
        dcid ='';
        delField ='';
        checkId ='';
        SecondNumberOnBottomR = 5;
        delOnRecord = new List<SObject>();
        SerchAlpabet=new List<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','All'};
        SearchVar='All';
        ShowRec = new List<SObject>();
        queryOnRecord = new List<SObject>();
        allSelectedFields = new List<SelectOption>();
        selectedSObject = '';
        listOfSelectedFields = new List<String>();
        listViewOfRecord = new List<SelectOption>();
        listViewOfRecord = listView();
        SelectAndDeselect = new List<SelectOption>();
        SelectAndDeselect = selectCheack();
        selectHowManyRecordShow = '';
        flagF = false;
        pageSize = 1;
        totalpageSize = 1;
        alphaTotalpageSize = 1;
        //flag = true;
        change = false;
        totalRecord = 0;
        firstNumberOnBottom =1;
        SecondNumberOnBottom =5;
        limitSize = 5;       
        offSetSize = 0;
        gopageSize = 1;
        RecPerPageSize = '5';
        quDemo = new List<SObject>();
    }

    public void  callPagningClass() {
       /* if(!String.isEmpty(selectedObject)) {
           queryOnRecord.clear();
        }*/
        passCondition =true;
        flag = false;
        flagF = true;
        /*if(queryOnRecord.size>0) {
            ch = true ;
        }*/
        System.debug(chooseSelectAndDeselect);
        listOfSelectedFields = new List<String>();
        listOfSelectedFields.add('Name');
        for(SelectOption selectOptionList : allSelectedFields) {
             listOfSelectedFields.add(selectOptionList.getValue());
        }
       
        try {
         String fieldOfSobject=String.join(listOfSelectedFields,',');
         delField = fieldOfSobject ;
        
         string queryR ;
         String selectAlpha = '\''+ SearchVar + '%\'';
         
         String qu = 'SELECT '+fieldOfSobject+' FROM '+selectedSObject ; 
         String alphaQue = 'SELECT '+fieldOfSobject+' FROM '+selectedSObject +' WHERE Name LIKE '+selectAlpha ;
         if( SearchVar == 'All' || SearchVar == 'null') {      
             queryR = 'SELECT '+fieldOfSobject+' FROM '+selectedSObject +' LIMIT '+limitSize+' OFFSET '+offSetSize;

         }

         else {
             queryR = 'SELECT '+fieldOfSobject+' FROM '+selectedSObject +' WHERE Name LIKE '+selectAlpha+' LIMIT '+limitSize+' OFFSET '+offSetSize;
             System.debug('Alpha word :'+queryR);
         }
         
         alphaQueList = Database.query(alphaQue);
         quDemo = Database.query(qu);

         
         if( SearchVar == 'All' || SearchVar == 'null') {
             totalRecord = (quDemo !=null &&quDemo.size()>0)?quDemo.size():0;     
         }
         else {
            
             alphaTotalRecord = (alphaQueList !=null &&alphaQueList.size()>0)?alphaQueList.size():0;
             totalRecord = alphaTotalRecord ;
         }

         /*if(totalRecord<SecondNumberOnBottom) {
            SecondNumberOnBottom = totalRecord ;
         }*/
         
        totalpageSizeOfRec = (Double)math.ceil(totalRecord / limitSize);
        System.debug(totalpageSizeOfRec);

        queryOnRecord = Database.query(queryR);
        System.debug('Alpha word qury :'+queryOnRecord);
        wrapperList = new List<PagningToPagningWrapper>();
        System.debug(statusOfMasterCheckBox);

         for( SObject obj : queryOnRecord ) {
            PagningToPagningWrapper wrapper;

            if(checkBoxMap.get( obj.Id ) == true || resultIds.contains(obj.Id)) {
                wrapper = new PagningToPagningWrapper(obj, true); 
            } else {
                wrapper = new PagningToPagningWrapper(obj, false); 
            }

            if( statusOfMasterCheckBox == true &&  offSetSize == off) {
                Id n = obj.Id;
                resultIds.add(n);
                System.debug(resultIds);
                if(resultIds.contains(obj.Id) == true) {
                wrapper = new PagningToPagningWrapper(obj, true); 
                } 
            }
            wrapperList.add(wrapper);
            //
         }
         
         /*resultIds    = (new Map<Id,SObject>(queryOnRecord)).keySet();

         System.debug(resultIds);*/
        // PagningToPagningWrapper(queryOnRecord);
        
        
        }
        catch(Exception e) {
            Apexpages.addMessages(e);
        }
    }

    public void firstPage() {
       /* statusOfMasterCheckBox = false ;*/
        offSetSize =0;
        firstNumberOnBottom = 1;
        SecondNumberOnBottom = limitSize ;
        pageSize = 1;
        callPagningClass();
       
    }

    public void previous() {
        //statusOfMasterCheckBox = true;
        offSetSize = offSetSize - limitSize;
        SecondNumberOnBottom = firstNumberOnBottom - 1;
        firstNumberOnBottom = SecondNumberOnBottom - limitSize + 1;
        pageSize--;
        callPagningClass();
        
    }

    public void next() {

        offSetSize = offSetSize + limitSize;
        firstNumberOnBottom = SecondNumberOnBottom +1;
        SecondNumberOnBottom =  SecondNumberOnBottom + limitSize ;

        if(SecondNumberOnBottom > totalRecord){
            SecondNumberOnBottom = totalRecord;        
        }
       
        pageSize++;

        callPagningClass();
    }

    public void lastPage() {

        System.debug(totalRecord);
        offSetSize = totalRecord - math.mod(totalRecord,limitSize);
        System.debug(offSetSize);
        firstNumberOnBottom = offSetSize + 1 ; 
        System.debug(firstNumberOnBottom);
        SecondNumberOnBottom = totalRecord;
        pageSize = (Integer)totalpageSizeOfRec + 1 ;
        callPagningClass();      

    }

    public boolean getprev() {
        if(offSetSize == 0 || pageSize == 1) {
            return true;
        }
        else {
            return false;
        }
    }  
    
/*|| (offSetSize + limitSize) > alphaTotalRecord*/

/* Page: <apex:outputText  value=" {!pageSize} of {! CEILING(totalRecord / limitSize) }"/>
*/
    public boolean getnxt() {
        if((offSetSize + limitSize) > totalRecord  ) {
            return true;
        }
        else {
            return false;
        }
    }         




    public SelectOption[] listView() {

        SelectOption[] recordView = new SelectOption[] {  };
        recordView.add(new SelectOption('5','5'));
        recordView.add(new SelectOption('10','10'));
        recordView.add(new SelectOption('15','15'));
        recordView.add(new SelectOption('20','20'));
        return recordView;
    }


    public void callTheQueryByListView() {
       
            limitSize = Integer.valueOf(RecPerpageSize);
            SecondNumberOnBottom = Integer.valueOf(RecPerpageSize);
            firstNumberOnBottom=null;
            firstNumberOnBottom = 1;
            offSetSize = 0;
            /*off = offSetSize;*/
            pageSize = 1;

            firstPage();
    }



    public void countThePageSize() {
            System.debug(gopageSize);
            System.debug('Hello everone');
                  
            offSetSize  = limitSize * gopageSize - limitSize ;
           
            firstNumberOnBottom = offSetSize + 1 ;
            SecondNumberOnBottom = offSetSize + limitSize ;

            if(SecondNumberOnBottom > totalRecord){
                 SecondNumberOnBottom = totalRecord;        
            }
            pageSize = gopageSize;
            callPagningClass();        
       
    }



    public void display() {

        System.debug(SearchVar);
        offSetSize=0;
        callPagningClass();
        countThePageSize();
    }



    public void findIdFormCheckBox() {
        System.debug(findIdFormVf);
        System.debug(checkBoxRecId);
        System.debug(off);
       
       // listOfMasterChechBox.add(statusOfMasterCheckBox);
       // masterCheckBoxMap.put(resultIds,statusOfMasterCheckBox)
        checkBoxMap.put(checkBoxRecId, findIdFormVf);
        callPagningClass();
        
        /*for( PagningToPagningWrapper wrapper : wrapperList ) {
            if( findIdFormVf == wrapper.record.Id ) {
                wrapper.selected = true;
            } else {
                wrapper.selected = false;
            }
        }*/
    }



    public void findMasterIdFormCheckBox() {
        off = offSetSize;
        System.debug(off);
        System.debug(statusOfMasterCheckBox);
       /* if( statusOfMasterCheckBox == true ) {
            for( PagningToPagningWrapper wrapper : wrapperList ) {
                wrapper.selected = true;
            }
        } else {
            for( PagningToPagningWrapper wrapper : wrapperList ) {
                wrapper.selected = false;
            }
        }*/
        

        callPagningClass();
    }


    public void deleteRec() {  
        try {
            String delQuery;
            String delId = '\''+ dcid + '\'';
            delQuery = 'SELECT id  FROM '+selectedSObject +' WHERE id = ' +delId; 
            delete Database.query(delQuery);  

            for(Integer i=0; i<queryOnRecord.size(); i++) {
                if(queryOnRecord.get(i).get('id') == dcid) {
                    queryOnRecord.remove(i); 
                    callPagningClass();              
                    break;
                }
            }
        }
        catch(Exception e) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Record Can not delete'));
            //Apexpages.addMessages(myMsg);
        }   
   }  


    public void clickOnCheakBox() {
        System.debug(chooseSelectAndDeselect);
        if(chooseSelectAndDeselect == 'Selected Page') {
           /* resultIds
            for(Integer i=0; i<inputCheckBox.length; i++){          
                if(inputCheckBox[i].id.indexOf(resultIds)!=-1){                                     
                    inputCheckBox[i].checked = obj.checked;
                }*/
        }
        else if(chooseSelectAndDeselect == 'Deselected Page') {
            System.debug('also done');
        }

            
            
    }

     public SelectOption[] selectCheack() {
        System.debug(chooseSelectAndDeselect);
        SelectOption[] recordView = new SelectOption[] {  };
       /* recordView.add(new SelectOption('Demo','Demo'));*/
        recordView.add(new SelectOption('Deselected Page','Selected Page'));
        recordView.add(new SelectOption('selected Page','Deselected Page'));
        return recordView ;
    }



    public void SelectedAndDeselectMethod() {

    }

    public class PagningToPagningWrapper {
        public SObject record {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public PagningToPagningWrapper(SObject record, Boolean selected) {
            this.record = record;
            this.selected = selected;
        }
    }

}