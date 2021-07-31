({
    getAccountList: function(component, pageNumber, pageSize) {
        var action = component.get("c.getAccountData");
        action.setParams({
            "pageNumber": pageNumber,
            "pageSize": pageSize
        });
        action.setCallback(this, function(result) {
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){
                var resultData = result.getReturnValue();
                component.set("v.accountList", resultData.accountList);
                component.set("v.PageNumber", resultData.pageNumber);
                component.set("v.TotalRecords", resultData.totalRecords);
                component.set("v.RecordStart", resultData.recordStart);
                component.set("v.RecordEnd", resultData.recordEnd);
                component.set("v.TotalPages", Math.ceil(resultData.totalRecords / pageSize));
                component.set("v.accountList.Number_of_Contacts__c" ,resultData.countTheContact);
            }
        });
        $A.enqueueAction(action);
    },

    editRecSaveHelper : function( component, lstId, allFields) {
        var action = component.get("c.saveEditAcc");
        action.setParams({
            "accList": allFields,
            "accId": lstId
        });
        action.setCallback(this, function(result) {
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS"){
                var resultData = result.getReturnValue();
            }
        });
        $A.enqueueAction(action);
    },

    
    deleteAccountHelper : function(component, selectedMenuItemId, pageNumber, pageSize) {
        var action = component.get("c.delteAccountById");
        action.setParams({
            "accid": selectedMenuItemId,
            "pageNumber": pageNumber,
            "pageSize": pageSize
        });
        action.setCallback(this, function(result) {
            var state = result.getState();
            if (component.isValid() && state === "SUCCESS") {
                var resultData = result.getReturnValue();
                component.set("v.accountList", resultData.accountList);
                component.set("v.PageNumber", resultData.pageNumber);
                component.set("v.TotalRecords", resultData.totalRecords);
                component.set("v.RecordStart", resultData.recordStart);
                component.set("v.RecordEnd", resultData.recordEnd);
                component.set("v.TotalPages", Math.ceil(resultData.totalRecords / pageSize));
                component.set("v.showErrorMsgOnSuccDel", true);
            } else if ( state=="ERROR" ) {
                
                component.set("v.showErrorMsg", true);
            }
            var delayInMilliseconds = 2000; //5 seconds
            window.setTimeout(
                $A.getCallback(function() {
                    console.log('myHelperMethod EXECUTING NOW... ');
                    component.set("v.showErrorMsgOnSuccDel", false);
                    component.set("v.showErrorMsg", false);
                }), delayInMilliseconds
            );   
        });
        $A.enqueueAction(action);
    },
    
    createAccountHelper : function(component, newAcc, pageNumber, pageSize, event, helper) {
        var newAcc = component.get("v.newAccount");
        console.log("new account==="+newAcc);
        console.log("new account in helper==="+newAcc);
        var action = component.get("c.saveAccount");
        action.setParams({ 
            "acc": component.get("v.newAccount"),
            "pageNumber": pageNumber,
            "pageSize": pageSize
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS"){
                var resultData = response.getReturnValue();
                component.set("v.accountList", resultData.accountList);
                component.set("v.PageNumber", resultData.pageNumber);
                component.set("v.TotalRecords", resultData.totalRecords);
                component.set("v.RecordStart", resultData.recordStart);
                component.set("v.RecordEnd", resultData.recordEnd);
                component.set("v.TotalPages", Math.ceil(resultData.totalRecords / pageSize));
                component.set("v.showErrorMsgOnSuccCer", true);
                component.set("v.newAccount","");
     
            } else if ( state=="ERROR" ) {
                component.set("v.showErrorMsgOnSuccCer", true);
            }
            var delayInMilliseconds = 2000; //5 seconds
                window.setTimeout(
                    $A.getCallback(function() {
                        console.log('myHelperMethod EXECUTING NOW... ');
                        component.set("v.showErrorMsgOnSuccCer", false);
                        component.set("v.showErrorMsgOnSuccCer", false);
                    }), delayInMilliseconds
                );     
           
            component.set("v.ShowModule", false);
            });
        $A.enqueueAction(action)
    },

    createContactHelper : function( component, newCon, accId, helper ) {
        var action = component.get("c.saveContact");
        action.setParams({ 
            "con": newCon,
            "accId": accId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS"){
                var resultData = response.getReturnValue();
                component.set("v.contactList", resultData.contactList);
                //component.set("v.newContact","");
            }
            //component.set("v.newContact","");
            //component.destroy();
            component.set("v.ShowModuleForNewContact", false);
            });
        $A.enqueueAction(action)
    },

    editTheFormHelper : function(component, event, allFields, lstId) {
        console.log("--====",JSON.stringify(allFields));
        var action = component.get("c.editAccountOne");
        action.setParams({ 
            "OneAccount": allFields,
            "AccId": lstId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS"){
                var resultData = response.getReturnValue();
                console.log("@@@--",resultData);
               // component.set("v.contactList", resultData.contactList);
                //component.set("v.newContact","");
                component.set("v.accountList",resultData);
            }
        });
        $A.enqueueAction(action)
    },

    editAccountHelper : function(component, event, selectedMenuItemId, pageNumber, pageSize) {
        //if(component.get("v.recordId")){
        component.set("v.showDetails", true);
        var action = component.get("c.saveUpdateRecord");
        action.setParams({ 
            "selectedMenuItemId": selectedMenuItemId,
            "pageNumber": pageNumber,
            "pageSize": pageSize
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var resultData = response.getReturnValue();
                component.set("v.accountList", resultData.accountList);
                component.set("v.PageNumber", resultData.pageNumber);
                component.set("v.TotalRecords", resultData.totalRecords);
                component.set("v.RecordStart", resultData.recordStart);
                component.set("v.RecordEnd", resultData.recordEnd);
                component.set("v.TotalPages", Math.ceil(resultData.totalRecords / pageSize));
            }
            //component.set("v.newAccount","");
            //component.destroy();
            //component.set("v.showDetails", false);
        });
        $A.enqueueAction(action)
       // }
    },

    


    deleteSelectedHelper: function(component, event, deleteRecordsIds) {
        var action = component.get('c.deleteRecords');
        console.log("action of the"+action);
        action.setParams({
         "lstRecordId": deleteRecordsIds
        });
        action.setCallback(this, function(response) {
         var state = response.getState();
         if (state === "SUCCESS") {
          if (response.getReturnValue() != '') {
           alert('The following error has occurred. while Delete record-->' + response.getReturnValue());
          } else {
           console.log('check it--> delete successful');
          }
          // call the onLoad function for refresh the List view    
          this.afterDeleteReturnContactListHelper(component, event);
          //component.set("v.showDetails", false);
         }
        });
        $A.enqueueAction(action);
    },

    afterDeleteReturnContactListHelper : function( component, event ) {
        var idOfAccForCon= component.get("v.recordIdOfCon");
        var action = component.get("c.getContactRecords");
        action.setParams({ accId :  idOfAccForCon});
        action.setCallback(this, function(response) {
            var state = response.getState(); //Checking response status
            if (component.isValid() && state === "SUCCESS")
                component.set("v.contactList", response.getReturnValue());  // Adding values in Aura attribute variable. 
                component.set("v.selectedCount", 0);
                component.find("box3").set("v.value", false);  
        });
        $A.enqueueAction(action);
    },
   
    saveAccountList : function(component, event, helper) {
        //Call Apex class and pass account list parameters
        var action = component.get("c.saveAccounts");
        action.setParams({
            "accList": component.get("v.accountListSp")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //component.set("v.accountList", []);
                alert('Account records saved successfully');
            }
        }); 
        $A.enqueueAction(action);
    }
})