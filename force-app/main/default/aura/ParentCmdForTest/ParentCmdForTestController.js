({
    parentEventFun : function(component, event, helper) {
        var messa = event.getParam("simpleMessage");
        component.set("v.eventMessage",messa);
    },

    childCmdEventFunParent : function(component, event, helper) {
        // var parentEventCmd = component.getEvent("SmapleCmdEventFromParent");
        // parentEventCmd.setParams({"simpleMessageForParent": "Parent Test Done"});
        // parentEventCmd.fire();

        var evt = $A.get("e.c:SampleComponentEvent");
        evt.setParams({ "simpleMessageForParent": "Parent Test Done"});
        evt.fire();
        console.log('==Fire from parent==');
    },

    callAuraMethod : function(component, event, helper) {
        //Call Child aura method
        var childComponent = component.find("childCmp");
        var message = childComponent.childMessageMethod('Happy Coding','Readers');
        console.log('==message=='+message);
    }
})