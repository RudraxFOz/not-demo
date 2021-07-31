({
    addNewRow : function(component, event, helper){
       // fire the AddNewRowEvt Lightning Event 
       component.getEvent("AddRowEvt").fire();     
    },
    
    removeRow : function(component, event, helper){
       component.getEvent("DeleteRowEvt").setParams({"indexVar" : component.get("v.rowIndex") }).fire();
    }, 


    forDisableRows: function(component, event, helper) {
       var temp = component.get("v.AccountInstance.disable");
       component.set("v.AccountInstance.disable",temp === true ? false : true)
       //var temp1 = component.get("v.AccountInstance.disable");
    },


    valueForCloneInItem : function(component, event, helper) { 
        var ss = component.get("v.AccountInstance");
        console.log("==",JSON.stringify(ss));
        var myEvent = component.getEvent("forAccList");
        myEvent.setParams({"forAccListAcc": component.get("v.AccountInstance")});
        myEvent.fire();
    },

  
})