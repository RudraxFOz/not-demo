({
    childCmdEventFun : function(component, event, helper) {
        var cmdEvent =  $A.get("e.c:SampleComponentEvent");
        cmdEvent.setParams({"simpleMessage": "Test Done"});
        cmdEvent.fire();
    },

    parentEventFunFormParent : function(component, event, helper) {
        console.log('==Come==Inside==Child==');
        var parentEventCmd = event.getParam("simpleMessageForParent");
        console.log('==parentEventCmd=='+parentEventCmd);
    },

    getMessage : function(component, event) {
        //get method paramaters
        var params = event.getParam('arguments');
        if (params) {
            var param1 = params.childGreetingParam;
            var param2 = params.childPersonNameParam;
            alert(param1 + " " + param2);
        }
    }
})