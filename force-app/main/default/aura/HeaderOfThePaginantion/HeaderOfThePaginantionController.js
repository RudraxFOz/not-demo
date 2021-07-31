({
    HideMe: function(component, event, helper) {
       component.set("v.ShowModule", false);
    },
    
   
    ShowModuleBox: function(component, event, helper) {
        component.set("v.ShowModule", true);
       // var evt = $A.get("e.c:PassValueHeaderToPaginantionEvent");
        //evt.setParams({ "CheackTheCondition": true});
 //evt.fire();
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