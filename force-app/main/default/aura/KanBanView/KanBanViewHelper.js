({
    doInitHelper : function(component,event){ 
        var action = component.get("c.getsObjects");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var responseOfObj = response.getReturnValue();
                if(responseOfObj.length > 0){
                    component.set('v.allObject', responseOfObj);
                    console.log("==responseOfObj==",responseOfObj);
                }
            }
            else{
                alert('Error...');
            }
        });
        $A.enqueueAction(action);  
    },

    fetchPickListVal : function(component, event, helper, fieldName, targetAttribute) {
        console.log("tetetess",component.find('selectObject').get('v.value'));
        var selectObj = component.find('selectObject').get('v.value');
        component.set("v.selectObject",selectObj);
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.find('selectObject').get('v.value')
           
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var opts = [];
                var allValues = response.getReturnValue();
                console.log("allValues==",allValues);
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                console.log('==opts==',opts);
                component.set("v.listSkillsOptions", opts);
            }else{
                alert('Callback Failed...');
            }
        });
        $A.enqueueAction(action);
        
    }
})