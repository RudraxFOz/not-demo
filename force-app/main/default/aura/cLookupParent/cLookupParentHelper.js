({
    searchHelper : function(component,event,getInputkeyWord) {
      // call the apex class method 
      var action = component.get("c.fetchValueOfSobject");
      // set param to method  
      action.setParams({
          'searchKeyWord': getInputkeyWord,
          'ObjectName' : component.get("v.objectAPIName"),
          'ExcludeitemsList' : component.get("v.lstSelectedRecords"),
          'junctionObjParentId': component.get("v.recordId"),
          'junctionObjName': component.get("v.junctionObjectAPIName"),
          'junctionObjParentName' : component.get("v.junctionObjectForParAPIName"),
          'junctionObjChildName' : component.get("v.junctionObjectForChildAPIName"),
      });
      // set a callBack    
      action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
          var state = response.getState();
          if (state === "SUCCESS") {
              var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Records Found... message on screen.                }
              if (storeResponse.length == 0) {
                  component.set("v.Message", 'No Records Found...');
              } else {
                  component.set("v.Message", '');
                  // set searchResult list with return value from server.
              }
              component.set("v.listOfSearchRecords", storeResponse); 
          }
      });
      // enqueue the Action  
      $A.enqueueAction(action);
    },

    createJuctionObjRecords : function(component,event, selectedAccountGetFromEvent) {

      console.log('==selectedAccountGetFromEvent=='+selectedAccountGetFromEvent);
      var testVar = component.get("v.recordId");
      console.log('==testVar=='+testVar);
      console.log('==component.get("v.recordId")=='+component.get("v.recordId"));

      // call the apex class method 
      var action = component.get("c.fetchValueFromJunctionObj");
      // set param to method  
      action.setParams({
           'junctionObjParentId': component.get("v.recordId"),
          'junctionObjName': component.get("v.junctionObjectAPIName"),
          'junctionObjParentName' : component.get("v.junctionObjectForParAPIName"),
          'junctionObjChildName' : component.get("v.junctionObjectForChildAPIName"),
          'selectdRecList'   : selectedAccountGetFromEvent
      });
      // set a callBack    
      action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
          var state = response.getState();
          if (state === "SUCCESS") {
              var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Records Found... message on screen.                }
              if (storeResponse.length == 0) {
                  component.set("v.Message", 'No Records Found...');
              } else {
                  component.set("v.Message", '');
                  // set searchResult list with return value from server.
              }
              component.set("v.listOfJunctionObjRecords", null); 
              component.set("v.listOfJunctionObjRecords", storeResponse); 
              component.set("v.truthy", true);
              
          }
      });
      // enqueue the Action  
      $A.enqueueAction(action);
    },



    clearAndDeleteJunctionRecHelper : function(component,event, selectedPillId) {
      // call the apex class method 
      var action = component.get("c.deleteJunctionRec");
      // set param to method  
      action.setParams({
           'junctionObjId': selectedPillId
      });
      // set a callBack    
      action.setCallback(this, function(response) {
          $A.util.removeClass(component.find("mySpinner"), "slds-show");
          var state = response.getState();
          if (state === "SUCCESS") {
              var storeResponse = response.getReturnValue();
              // if storeResponse size is equal 0 ,display No Records Found... message on screen.                }
              // if (storeResponse.length == 0) {
              //     component.set("v.Message", 'No Records Found...');
              // } else {
              //     component.set("v.Message", '');
              //     // set searchResult list with return value from server.
              // }
              // component.set("v.listOfJunctionObjRecords", null); 
              // component.set("v.listOfJunctionObjRecords", storeResponse); 
              // component.set("v.truthy", true);   
          }
      });
      // enqueue the Action  
      $A.enqueueAction(action);

    },
})