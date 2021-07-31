({
    validDate : function(component,event,helper){

        var startDate = component.get("v.dataInValue");
        console.log(startDate);
        
        var endDate = component.get("v.dataEndValue");
        console.log(endDate);
        if(startDate != null && endDate != null){
            helper.setDateOnTimeSheet(component, event, startDate, endDate);
        }        
    },
    
    validDateSize : function(component,event,helper){
        var data_inicio = component.get("v.dataInValue");
        console.log("Stardt Date:"+component.get("v.dataInValue"));
        var data_fim = component.get("v.dataEndValue");   
        var sel = window.getSelection().toString();
        console.log('entra no validate size');
        console.log('Data Ini'+data_inicio);
        
        if(data_inicio != null)
        {
            console.log('Entra no if');
            var tam = data_inicio.length;
            console.log('Tam:'+tam);
            if(tam > 10 && sel ==''){
                event.preventDefault();
            }
        }
        
        if(data_fim){
            var tam = data_fim.lenght;
            if(tam>10 && sel == ''){
                event.preventDefault();
            }
        }
    },

    // function call on component Load
    doInit: function(component, event, helper) {
        // create a Default RowItem [Contact Instance] on first time Component Load
        // by call this helper function  
        helper.createObjectData(component, event);
    },
 
    // function for save the Records 
    Save: function(component, event, helper) {
        // first call the helper function in if block which will return true or false.
        // this helper function check the "first Name" will not be blank on each row.
        if (helper.validateRequired(component, event)) {
            // call the apex class method for save the Contact List
            // with pass the contact List attribute to method param.  
            var action = component.get("c.saveTimeSheetItems");
            action.setParams({
                "ListTimeSheetItems": component.get("v.timeSheetItemList"),
                "TimeSheetid"       : component.get("v.timeSheetId")
            });
            // set call back 
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    // if response if success then reset/blank the 'contactList' Attribute 
                    // and call the common helper method for create a default Object Data to Contact List 
                    component.set("v.timeSheetItemList", []);
                    helper.createObjectData(component, event);
                    alert('record Save');
                }
            });
            // enqueue the server side action  
            $A.enqueueAction(action);
        }
    },
 
    // function for create new object Row in Contact List 
    addNewRow: function(component, event, helper) {
        // call the comman "createObjectData" helper method for add new Object Row to List   
        component.set("v.storeTotalOfRow", component.get("v.totalOfRow")); 
        component.set("v.storeValueOnNewRow", true);  
        //component.set("v.showFirstRecOnLine", true);
        helper.createObjectData(component, event);
    },
 
    // function for delete the row 
    removeDeletedRow: function(component, event, helper) {
        // get the selected row Index for delete, from Lightning Event Attribute  
        var index = event.getParam("indexVar");
        // get the all List (contactList attribute) and remove the Object Element Using splice method    
        var AllRowsList = component.get("v.timeSheetItemList");
        var valueAtIndex1 = AllRowsList[index];

        var getValIn = JSON.parse((JSON.stringify(valueAtIndex1)));
        var getValIn1 = (JSON.stringify(valueAtIndex1));

        var deleteRowValue ;

        if(!isNaN(parseInt(getValIn.Monday__c))) {
            deleteRowValue = getValIn.Monday__c;
            component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) - parseInt(getValIn.Monday__c));
        }
        if(!isNaN(parseInt(getValIn.Tuesday__c))) {
            deleteRowValue = parseInt(deleteRowValue) + parseInt(getValIn.Tuesday__c);
            component.set("v.totalOfColumnTu",  parseInt(component.get("v.totalOfColumnTu")) - parseInt(getValIn.Tuesday__c));
        }
        if(!isNaN(parseInt(getValIn.Wednesday__c))) {
            deleteRowValue = parseInt(deleteRowValue) + parseInt(getValIn.Wednesday__c);
            component.set("v.totalOfColumnWe",  parseInt(component.get("v.totalOfColumnWe")) - parseInt(getValIn.Wednesday__c));
        }
        if(!isNaN(parseInt(getValIn.Thursday__c))) {
            deleteRowValue =parseInt( deleteRowValue) + parseInt(getValIn.Thursday__c);
            component.set("v.totalOfColumnTh",  parseInt(component.get("v.totalOfColumnTh")) - parseInt(getValIn.Thursday__c));
        }
        if(!isNaN(parseInt(getValIn.Friday__c))) {
            deleteRowValue = parseInt(deleteRowValue) + parseInt(getValIn.Friday__c);
            component.set("v.totalOfColumnFr",  parseInt(component.get("v.totalOfColumnFr")) - parseInt(getValIn.Friday__c));
        }
        if(!isNaN(parseInt(getValIn.Saturday__c))) {
            deleteRowValue = parseInt(deleteRowValue) + parseInt(getValIn.Saturday__c);
            component.set("v.totalOfColumnSa",  parseInt(component.get("v.totalOfColumnSa")) - parseInt(getValIn.Saturday__c));
        }
        if(!isNaN(parseInt(getValIn.Sunday__c))) {
            deleteRowValue = parseInt(deleteRowValue) + parseInt(getValIn.Sunday__c);
            component.set("v.totalOfColumnSu",  parseInt(component.get("v.totalOfColumnSu")) - parseInt(getValIn.Sunday__c));
        }

        component.set("v.totalOfRow", parseInt(component.get("v.totalOfRow")) - parseInt(deleteRowValue));

    
        AllRowsList.splice(index, 1);
        // set the contactList after remove selected row element  
        component.set("v.timeSheetItemList", AllRowsList);
    },  


    showColumnTotalValue : function(component, event, helper) {
  
        component.set("v.totalOfRow",  parseInt(component.get("v.storeTotalOfRow")) + parseInt(event.getParam("columnTotal")));
        
    },

    showColumnValue: function(component, event, helper) {
        

        if(!isNaN(parseInt(event.getParam("columnTotalMo")))) {
            var forLenZero = 0;
            var getPreDigits = 0; 
            var getColPreDigits = 0;
            var getNumberVal = event.getParam("columnTotalMo");
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1 ){ //|| getNumberVal.length == 1 ;
                
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                //component.getEvent("ShowColumnTotalValidation").setParams({"rowTotalValidation" : component.get("v.totalOfColumnMo") }).fire();
                
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits) }).fire();
            }else if(component.get("v.showFirstRecOnLine") && getNumberVal.length == 1){
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                component.set("v.showFirstRecOnLine",false);

            } else {
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(component.get("v.preNumberValue")));
                //component.getEvent("ShowColumnTotalValidation").setParams({"rowTotalValidation" : component.get("v.totalOfColumnMo") }).fire();
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")) }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);

        } else {
            component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) - parseInt(component.get("v.preNumberValue")));
            //component.getEvent("ShowColumnTotalValidation").setParams({"rowTotalValidation" : component.get("v.totalOfColumnMo") }).fire();
            //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) - parseInt(component.get("v.preNumberValue")) }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }    
        
        
        var accountEvent = $A.get("e.c:DeleteRowEvt");
        accountEvent.setParams({"rowTotalValidation": component.get("v.totalOfColumnMo")});
        accountEvent.fire(); 

        
      
    },

    showColumnValueTu: function(component, event, helper) {

        if(!isNaN(parseInt(event.getParam("columnTotalTu")))) {
            var forLenZero = 0;
            var getPreDigits = 0; 
            var getColPreDigits = 0;
            var getNumberVal = event.getParam("columnTotalTu");
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1 ){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        //output.push(+sNumber.charAt(i));
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalOfColumnTu",  parseInt(component.get("v.totalOfColumnTu")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits) }).fire();
            } else if(component.get("v.showFirstRecOnLine") && getNumberVal.length == 1){
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                component.set("v.showFirstRecOnLine",false);

            } else {
                component.set("v.totalOfColumnTu",  parseInt(component.get("v.totalOfColumnTu")) + parseInt(getNumberVal) - parseInt(component.get("v.preNumberValue")));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")) }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalOfColumnTu",  parseInt(component.get("v.totalOfColumnTu")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);

        } else {
            component.set("v.totalOfColumnTu",  parseInt(component.get("v.totalOfColumnTu")) - parseInt(component.get("v.preNumberValue")));
            //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) - parseInt(component.get("v.preNumberValue")) }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }     
       
    },

    showColumnValueWe: function(component, event, helper) {

        if(!isNaN(parseInt(event.getParam("columnTotalWe")))) {
            var forLenZero = 0;
            var getPreDigits = 0; 
            var getColPreDigits = 0;
            var getNumberVal = event.getParam("columnTotalWe");
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1 ){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        //output.push(+sNumber.charAt(i));
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalOfColumnWe",  parseInt(component.get("v.totalOfColumnWe")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits) }).fire();
            } else if(component.get("v.showFirstRecOnLine") && getNumberVal.length == 1){
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                component.set("v.showFirstRecOnLine",false);

            } else {
                component.set("v.totalOfColumnWe",  parseInt(component.get("v.totalOfColumnWe")) + parseInt(getNumberVal) - parseInt(component.get("v.preNumberValue")));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")) }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalOfColumnWe",  parseInt(component.get("v.totalOfColumnWe")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);

        } else {
            component.set("v.totalOfColumnWe",  parseInt(component.get("v.totalOfColumnWe")) - parseInt(component.get("v.preNumberValue")));
            //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) - parseInt(component.get("v.preNumberValue")) }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }     
       
    },

    showColumnValueTh: function(component, event, helper) {

        if(!isNaN(parseInt(event.getParam("columnTotalTh")))) {
            var forLenZero = 0;
            var getPreDigits = 0; 
            var getColPreDigits = 0;
            var getNumberVal = event.getParam("columnTotalTh");
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1 ){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                   
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalOfColumnTh",  parseInt(component.get("v.totalOfColumnTh")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits) }).fire();
            }else if(component.get("v.showFirstRecOnLine") && getNumberVal.length == 1){
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                component.set("v.showFirstRecOnLine",false);

            }  else {
                component.set("v.totalOfColumnTh",  parseInt(component.get("v.totalOfColumnTh")) + parseInt(getNumberVal) - parseInt(component.get("v.preNumberValue")));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")) }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalOfColumnTh",  parseInt(component.get("v.totalOfColumnTh")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);

        } else {
            component.set("v.totalOfColumnTh",  parseInt(component.get("v.totalOfColumnTh")) - parseInt(component.get("v.preNumberValue")));
            //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) - parseInt(component.get("v.preNumberValue")) }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }     
       
    },

    showColumnValueFr: function(component, event, helper) {

        if(!isNaN(parseInt(event.getParam("columnTotalFr")))) {
            var forLenZero = 0;
            var getPreDigits = 0; 
            var getColPreDigits = 0;
            var getNumberVal = event.getParam("columnTotalFr");
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1 ){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        //output.push(+sNumber.charAt(i));
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalOfColumnFr",  parseInt(component.get("v.totalOfColumnFr")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits) }).fire();
            } else if(component.get("v.showFirstRecOnLine") && getNumberVal.length == 1){
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                component.set("v.showFirstRecOnLine",false);

            } else {
                component.set("v.totalOfColumnFr",  parseInt(component.get("v.totalOfColumnFr")) + parseInt(getNumberVal) - parseInt(component.get("v.preNumberValue")));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")) }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalOfColumnFr",  parseInt(component.get("v.totalOfColumnFr")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);

        } else {
            component.set("v.totalOfColumnFr",  parseInt(component.get("v.totalOfColumnFr")) - parseInt(component.get("v.preNumberValue")));
            //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) - parseInt(component.get("v.preNumberValue")) }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }     
       
    },

    showColumnValueSa: function(component, event, helper) {

        if(!isNaN(parseInt(event.getParam("columnTotalSa")))) {
            var forLenZero = 0;
            var getPreDigits = 0; 
            var getColPreDigits = 0;
            var getNumberVal = event.getParam("columnTotalSa");
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1 ){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        //output.push(+sNumber.charAt(i));
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalOfColumnSa",  parseInt(component.get("v.totalOfColumnSa")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits) }).fire();
            } else if(component.get("v.showFirstRecOnLine") && getNumberVal.length == 1){
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                component.set("v.showFirstRecOnLine",false);

            } else {
                component.set("v.totalOfColumnSa",  parseInt(component.get("v.totalOfColumnSa")) + parseInt(getNumberVal) - parseInt(component.get("v.preNumberValue")));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")) }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalOfColumnSa",  parseInt(component.get("v.totalOfColumnSa")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);

        } else {
            component.set("v.totalOfColumnSa",  parseInt(component.get("v.totalOfColumnSa")) - parseInt(component.get("v.preNumberValue")));
            //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) - parseInt(component.get("v.preNumberValue")) }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }     
       
    },

    showColumnValueSu: function(component, event, helper) {

        if(!isNaN(parseInt(event.getParam("columnTotalSu")))) {
            var forLenZero = 0;
            var getPreDigits = 0; 
            var getColPreDigits = 0;
            var getNumberVal = event.getParam("columnTotalSu");
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1 ){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                   
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalOfColumnSu",  parseInt(component.get("v.totalOfColumnSu")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits) }).fire();
            } else if(component.get("v.showFirstRecOnLine") && getNumberVal.length == 1){
                component.set("v.totalOfColumnMo",  parseInt(component.get("v.totalOfColumnMo")) + parseInt(getNumberVal) - parseInt(getPreDigits));
                component.set("v.showFirstRecOnLine",false);

            } else {
                component.set("v.totalOfColumnSu",  parseInt(component.get("v.totalOfColumnSu")) + parseInt(getNumberVal) - parseInt(component.get("v.preNumberValue")));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")) }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalOfColumnSu",  parseInt(component.get("v.totalOfColumnSu")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);

        } else {
            component.set("v.totalOfColumnSu",  parseInt(component.get("v.totalOfColumnSu")) - parseInt(component.get("v.preNumberValue")));
            //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) - parseInt(component.get("v.preNumberValue")) }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }     
       
    },

    
})