({
    HideMe: function(component, event, helper) {
       component.set("v.ShowModule", false);
    },
    ShowModuleBoxTesting: function(component, event, helper) {
        var ShowResultValue = event.getParam("CheackTheCondition");
        // set the handler attributes based on event data
        //component.set(“v.Get_Result”, ShowResultValue);
        component.set("v.CheackCondi", ShowResultValue);
    },
    createAccount : function(component, event, helper) {
        var newAcc = component.get("v.newAccount");
        var action = component.get("c.saveAccount");
        action.setParams({ 
            "acc": newAcc
        });
        action.setCallback(this, function(a) {
                var state = a.getState();
                if (state === "SUCCESS") {
                    var name = a.getReturnValue();
                    component.destroy();
                }
            });
        $A.enqueueAction(action)
    },
 })