({
    updatePickVal : function(component, recId, pField, pVal) {
        console.log("---recId---",recId);
        console.log("---pField---",pField);
        console.log("---pVal---",pVal);
        var action = component.get("c.getUpdateStage");
        action.setParams({
            "recId":recId,
            "kanbanField":pField,
            "kanbanNewValue":pVal
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.kanbanDataForUpdate", response.getReturnValue());
                var allRec =  component.get("v.kanbanDataForUpdate.recordss")
                var lengthOfPro = 0;
                var lengthOfCus = 0;
                var lengthOfPen = 0; 
                for ( var i=1; i<allRec.length; i++ ) { 
                    if (allRec[i].Status__c == 'Prospect' ) {
                        lengthOfPro++ ;
                    } else if (allRec[i].Status__c == 'Customer') {
                        lengthOfCus++ ;
                    } else if (allRec[i].Status__c == 'Pending') {
                        lengthOfPen++ ;
                    } else {
                    }
                }
                component.set("v.increaseValueOfPro", lengthOfPro);
                component.set("v.increaseValueOfCus", lengthOfCus);
                component.set("v.increaseValueOfPen", lengthOfPen);
                // document.getElementById(recId).style.backgroundColor = "#04844b";
                setTimeout(function(){ document.getElementById(recId).style.backgroundColor = ""; }, 300);
            }
        });
        $A.enqueueAction(action);
    }
})