({
    AddNewRow : function(component, event, helper){
        // fire the AddNewRowEvt Lightning Event 
         component.getEvent("AddRowEvt").fire();     
     },
     
     removeRow : function(component, event, helper){
      // fire the DeleteRowEvt Lightning Event and pass the deleted Row Index to Event parameter/attribute
        component.getEvent("DeleteRowEvt").setParams({"indexVar" : component.get("v.rowIndex") }).fire();
     }, 

     commit: function(component) {
        let pricesSum = 0;
        let changedPrices = component.find("input");
    
        // changedPrices.forEach(element => {
            
        //     if (element.get("v.value")) {
        //         pricesSum += element.get("v.value");
        //     }
        // });

        console.log('==pricesSum=='+pricesSum);
    }, 

    handleBlur : function(component,event) {
        var inputField = component.find('forMo');
        var value = 'foof';
        if(value != 'foo') {
           // console.log('==parentTochildValue=='+parentTochildValue);
            inputField.set('v.validity', {valid:false, badInput :true});
            inputField.showHelpMessageIfInvalid();
            console.log('==inputField=='+inputField);
    
        }
    },

    handleCustomValidation : function(component,event) {

        var parentTochildValue = event.getParam("rowTotalValidation");
       
        var value11 = 24;
        
        //var value = component.get("v.moColValue");
        console.log('==parentTochildValue=='+parentTochildValue);
        console.log('==value==typeof=='+typeof parentTochildValue);
        console.log('==value==parentTochildValue != 24=='+parentTochildValue <= value11);
        console.log('==value==parentTochildValue != typeof=='+typeof parentTochildValue <= value11);

        //if(typeof parentTochildValue <= value11) {
        
    },

    keyForMo : function(component, event, helper){

        var input_number = component.find('forMo').get('v.value');
        //var inputfield = event.getSource();
        
        if(!isNaN(parseInt(component.find('forMo').get('v.value')))) {

            var forLenZero = 0;
            var getPreDigits = 0;
            var getNumberVal = component.find('forMo').get('v.value');
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1){  //
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
 
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forMo').get('v.value')) - parseInt(getPreDigits));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            } else {
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forMo').get('v.value')) - parseInt(component.get("v.preNumberValue")));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            }
            //console.log('==getPreDigits=='+getPreDigits);

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);
            

        } else {
            component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }
        

        if(component.find('forMo').get('v.name') == 'inputMo'){
            component.getEvent("ShowColumnTotalMo").setParams({"columnTotalMo" : component.find('forMo').get('v.value') }).fire();

        }
        //  else if(component.find('forTu').get('v.name') == 'inputTu'){
           
        //     component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : component.find('forTu').get('v.value') }).fire();

        // } else if(component.find('forWe').get('v.name') == 'inputWe'){
            
        //     component.getEvent("ShowColumnTotalWe").setParams({"columnTotalWe" : component.find('forWe').get('v.value') }).fire();

        // } else if(component.find('forTh').get('v.name') == 'inputTh'){
           
        //     component.getEvent("ShowColumnTotalTh").setParams({"columnTotalTh" : component.find('forTh').get('v.value') }).fire();

        // } else if(component.find('forFr').get('v.name') == 'inputFr'){
        //     component.getEvent("ShowColumnTotalFr").setParams({"columnTotalFr" : component.find('forFr').get('v.value') }).fire();

        // } else if(component.find('forSa').get('v.name') == 'inputSa'){
        //     component.getEvent("ShowColumnTotalSa").setParams({"columnTotalSa" : component.find('forSa').get('v.value') }).fire();

        // } else if(component.find('forSu').get('v.name') == 'inputSu'){
        //     component.getEvent("ShowColumnTotalSu").setParams({"columnTotalSu" : component.find('forSu').get('v.value') }).fire();
        // }
           
    },

    keyForTu : function(component, event, helper){

        var input_number = component.find('forTu').get('v.value');
    
        if(!isNaN(parseInt(component.find('forTu').get('v.value')))) {
            var forLenZero = 0;
            var getPreDigits = 0; 
            var getColPreDigits = 0;
            var getNumberVal = component.find('forTu').get('v.value');
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(getPreDigits) }).fire();
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            } else {
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")));
                //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) + parseInt(component.find('forTu').get('v.value')) - parseInt(component.get("v.preNumberValue")) }).fire();
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);

        } else {
            component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            //component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : parseInt(component.get("v.totalHrsColumn")) - parseInt(component.get("v.preNumberValue")) }).fire();
            component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }
        component.getEvent("ShowColumnTotalTu").setParams({"columnTotalTu" : component.find('forTu').get('v.value') }).fire();



    },

    keyForWe : function(component, event, helper){
        if(!isNaN(parseInt(component.find('forWe').get('v.value')))) {
            var forLenZero = 0;
            var getPreDigits = 0;
            var getNumberVal = component.find('forWe').get('v.value');
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forWe').get('v.value')) - parseInt(getPreDigits));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            } else {
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forWe').get('v.value')) - parseInt(component.get("v.preNumberValue")));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);
        } else {
            component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }
        //component.getEvent("ShowRowTotal").setParams({"rowTotal" : component.get("v.totalHrsRow") }).fire();
        
        component.getEvent("ShowColumnTotalWe").setParams({"columnTotalWe" : component.find('forWe').get('v.value') }).fire();

    },

    keyForTh : function(component, event, helper){
        if(!isNaN(parseInt(component.find('forTh').get('v.value')))) {
            var forLenZero = 0;
            var getPreDigits = 0;
            var getNumberVal = component.find('forTh').get('v.value');
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                   
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forTh').get('v.value')) - parseInt(getPreDigits));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            } else {
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forTh').get('v.value')) - parseInt(component.get("v.preNumberValue")));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);
        } else {
            component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }
        //component.getEvent("ShowRowTotal").setParams({"rowTotal" : component.get("v.totalHrsRow") }).fire();
        
        component.getEvent("ShowColumnTotalTh").setParams({"columnTotalTh" : component.find('forTh').get('v.value') }).fire();

    },

    keyForFr : function(component, event, helper){
        if(!isNaN(parseInt(component.find('forFr').get('v.value')))) {
            var forLenZero = 0;
            var getPreDigits = 0;
            var getNumberVal = component.find('forFr').get('v.value');
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 ){
                if(getNumberVal.length > 1 || getNumberVal.length == 1){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forFr').get('v.value')) - parseInt(getPreDigits));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            } else {
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forFr').get('v.value')) - parseInt(component.get("v.preNumberValue")));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);
        } else {
            component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }
        //component.getEvent("ShowRowTotal").setParams({"rowTotal" : component.get("v.totalHrsRow") }).fire();
        
        component.getEvent("ShowColumnTotalFr").setParams({"columnTotalFr" : component.find('forFr').get('v.value') }).fire();


    },

    keyForSa : function(component, event, helper){
        if(!isNaN(parseInt(component.find('forSa').get('v.value')))) {
            var forLenZero = 0;
            var getPreDigits = 0;
            var getNumberVal = component.find('forSa').get('v.value');
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                        
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forSa').get('v.value')) - parseInt(getPreDigits));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            } else {
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forSa').get('v.value')) - parseInt(component.get("v.preNumberValue")));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);
        } else {
            component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }
        //component.getEvent("ShowRowTotal").setParams({"rowTotal" : component.get("v.totalHrsRow") }).fire();
        
        component.getEvent("ShowColumnTotalSa").setParams({"columnTotalSa" : component.find('forSa').get('v.value') }).fire();

    },

    keyForSu : function(component, event, helper){
        if(!isNaN(parseInt(component.find('forSu').get('v.value')))) {
            var forLenZero = 0;
            var getPreDigits = 0;
            var getNumberVal = component.find('forSu').get('v.value');
            var getNumberVal2 = component.get("v.preNumberLen");
            if(getNumberVal.length > getNumberVal2 || getNumberVal.length == 1){
                if(getNumberVal.length > 1 ){
                    for (var i = 0, len = getNumberVal.length; i < len-1; i += 1) {
                      
                        getPreDigits = getPreDigits + getNumberVal.charAt(i);
                    }

                }
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forSu').get('v.value')) - parseInt(getPreDigits));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            } else {
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) + parseInt(component.find('forSu').get('v.value')) - parseInt(component.get("v.preNumberValue")));
                component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            }
            if(getNumberVal.length == forLenZero){
                component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            }

            var getPreNumberLen = getNumberVal.length;
            component.set("v.preNumberLen", getPreNumberLen);  
            component.set("v.preNumberValue", getNumberVal);
        } else {
            component.set("v.totalHrsRow",  parseInt(component.get("v.totalHrsRow")) - parseInt(component.get("v.preNumberValue")));
            component.getEvent("ShowColumnTotal").setParams({"columnTotal" : component.get("v.totalHrsRow") }).fire();
            component.set("v.preNumberLen", 0);  
            component.set("v.preNumberValue", 0);
        }
        //component.getEvent("ShowRowTotal").setParams({"rowTotal" : component.get("v.totalHrsRow") }).fire(); 
        
        component.getEvent("ShowColumnTotalSu").setParams({"columnTotalSu" : component.find('forSu').get('v.value') }).fire();
        

    }
   
})