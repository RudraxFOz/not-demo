({
    doInit: function(component, event, helper) {
        var action = component.get("c.getKanbanWrap");
        action.setParams({
            "objName":component.get("v.objName"),
            "objFields":component.get("v.objFields"),
            "kanbanField":component.get("v.kanbanPicklistField")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.kanbanData", response.getReturnValue());
                var allRecPicklist =  component.get("v.kanbanData.pickVals")
                var allRec =  component.get("v.kanbanData.records")     
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
            }
        });
        $A.enqueueAction(action);
    },

    
    allowDrop: function(component, event, helper) {
        event.preventDefault();
    },
    
    drag: function (component, event, helper) {
        event.dataTransfer.setData("text", event.target.id);
    },
    
    drop: function (component, event, helper) {
        event.preventDefault();
        var data = event.dataTransfer.getData("text");
        var idOfCurrentCom = event.currentTarget;
        idOfCurrentCom.appendChild(document.getElementById(data));
        helper.updatePickVal(component,data,component.get("v.kanbanPicklistField"),idOfCurrentCom.getAttribute('data-Pick-Val'));
    }
})