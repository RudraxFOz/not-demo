({
    // function call on component Load
    doInit: function(component, event, helper) {
        // create a Default RowItem [Account Instance] on first time Component Load
        // by call this helper function  
        helper.createObjectData(component, event);
    },
 
    // function for save the Records 
    Save: function(component, event, helper) {
        // first call the helper function in if block which will return true or false.
        // this helper function check the "first Name" will not be blank on each row.
        if (helper.validateRequired(component, event)) {
            // call the apex class method for save the Account List
            var action = component.get("c.saveAccountss");
            action.setParams({
                "ListAccount": component.get("v.AccList")
            });
            // set call back 
            action.setCallback(this, function(response) {
                console.log("$$$$=="+JSON.stringify(response.getReturnValue()))
                var state = response.getState();
                if (state === "SUCCESS") {
                    var myEvent = component.getEvent("myComponentEvent");
                    myEvent.setParams({"LstOfAccFormChild": response});
                    myEvent.fire();
                    component.set("v.AccList", []);
                    helper.createObjectData(component, event);
                    alert('record Save');
                }
            });
            $A.enqueueAction(action);
        }
    },

    valueForClone: function(component, event, helper) { 
        helper.createObjectDataForClone(component, event);
    },
    
    // function for create new object Row in Contact List 
    addNewRow: function(component, event, helper) {
       // var sss = component.get("v.AddMultiRow");
       // console.log("===hhh=="+sss);
        helper.createObjectData(component, event);
    },

    
    getValueMethod: function(component, event, helper) { 
        var params = event.getParam('arguments');
        var param1 = params.NumberForRow;
        console.log("Hello====Sir"+param1);
        for (var i=0; i<param1; i++) {
            console.log("hhh");
           helper.createObjectData(component, event);
        }
    },
 
    // function for delete the row 
    removeDeletedRow: function(component, event, helper) {
        var index = event.getParam("indexVar"); 
        var AllRowsList = component.get("v.AccList");
        AllRowsList.splice(index, 1);
        component.set("v.AccList", AllRowsList);
    } 
})