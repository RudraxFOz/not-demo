({
    searchHelper : function(component,event,getInputkeyWordValue) {
      var action = component.get("c.fetchValueOfSobject");
          action.setParams({
              'searchKeyWord': getInputkeyWordValue,
              'ObjectName' : component.get("v.objectAPIName")
            });
          action.setCallback(this, function(response) {
            $A.util.removeClass(component.find("mySpinner"), "slds-show");
              var state = response.getState();
              if (state === "SUCCESS") {
                var result = response.getReturnValue();
                if (result.length == 0) {
                    component.set("v.Message", 'No Result Found...');
                } else {
                    component.set("v.Message", '');
                }
                component.set("v.listOfSearchRecords", result);
              }
          });
        // enqueue the Action  
      $A.enqueueAction(action);
    }
})