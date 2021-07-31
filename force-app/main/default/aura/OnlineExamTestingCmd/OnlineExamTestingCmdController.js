({
    doInit : function(component, event, helper) {
        console.log("===the action==");
		helper.doInitHelper(component, event, helper);
	},

    selectOptionSubject : function(component, event, helper) { 
        helper.selectOptionSubjectHelper(component, event, helper);
    }
})