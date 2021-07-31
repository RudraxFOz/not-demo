({
    doInit: function( component, event, helper ) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value"); 
        component.set("v.ShowKan",false);
        helper.getAccountList( component, pageNumber, pageSize );
       // helper.createObjectData(component, event);
    },
     
    handleNext : function( component, event, helper ) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber++;
        helper.getAccountList( component, pageNumber, pageSize );
    },
     
    handlePrev : function( component, event, helper ) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        pageNumber--;
        helper.getAccountList( component, pageNumber, pageSize );
    },
     
    onSelectChange : function( component, event, helper ) {
        var page = 1
        var pageSize = component.find("pageSize").get("v.value");
        helper.getAccountList( component, page, pageSize );
    },

    editDelete : function( component, event, helper ) {
        console.log("helloe sir");
        var selectedMenuItemIdAndValue = event.getParam("value").split(',')
        var selectedMenuItemId = selectedMenuItemIdAndValue[0];
        var selectedMenuItemValue = selectedMenuItemIdAndValue[1]; 
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value");
        console.log("pageSize=="+pageSize );
        console.log("value=="+selectedMenuItemValue );
        console.log("Id==="+selectedMenuItemId );
        console.log(selectedMenuItemValue == 'Edit');
        if ( selectedMenuItemValue == 'Edit' ) {
            //component.set("v.ShowModuleForEdit", true);
            component.set("v.recordId", selectedMenuItemId);
           // console.log("===id==="+!v.recordId);
            component.set("v.showDetails", true);
            //helper.editAccountHelper(component, event, selectedMenuItemId);  
        } else if ( selectedMenuItemValue == 'Delete' ) {
            console.log("helloe sir1111");
            if ( confirm('Are you sure For Delete:?' ))
                helper.deleteAccountHelper( component, selectedMenuItemId, pageNumber, pageSize );  
        } else if ( selectedMenuItemValue == 'Contact' ) {
            component.set("v.showContacts", true);
            var selectedMenuItemIdAndValue = event.getParam("value").split(',')
            var selectedMenuItemId = selectedMenuItemIdAndValue[0];
            console.log("id for conatc"+selectedMenuItemId);
            component.set("v.recordIdOfCon", selectedMenuItemId);
            var action = component.get("c.getContactRecords");
            action.setParams({ accId :  selectedMenuItemId});
            action.setCallback(this, function(response) {
                var state = response.getState(); //Checking response status
                console.log("contactsss... "+JSON.stringify(response.getReturnValue()));
                if ( component.isValid() && state === "SUCCESS" ) {
                    component.set("v.contactList", response.getReturnValue());  // Adding values in Aura attribute variable.   
                } else {
                    alert("No conatact ")
                }
            });
            $A.enqueueAction(action);
        }               
    },

    ShowModuleBox: function( component, event, helper ) {
        component.set("v.ShowModule", true);
    },

    ModuleBoxForBulk: function( component, event, helper ) {
        component.set("v.ShowModuleBoxForBulk", true);
    },

    HideMe: function( component, event, helper ) {
        var pageNumber = component.get("v.PageNumber");  
        var pageSize = component.find("pageSize").get("v.value"); 
        component.set("v.showDetails", false);
        component.set("v.ShowModuleForDelete", false);
        component.set("v.ShowModule", false);
        component.set("v.showContacts", false);
        component.set("v.selectedCount", 0);
        component.set("v.showErrorMsg", false);
        component.set("v.showErrorMsgOnSuccDel", false);
        component.set("v.showErrorMsgOnSuccCer", false);
        component.set("v.showErrorMsgOnNotCer", false);
        component.set("v.ShowModuleBoxForBulk", false);
        helper.getAccountList( component, pageNumber, pageSize );
       
    },

    createAccount : function( component, event, helper ) {

        var newAcc = component.get("v.newAccount");
        console.log("new account==="+newAcc);
        var pageNumber = component.get("v.PageNumber");  
        console.log("pageNumber=="+pageNumber );
        var pageSize = component.find("pageSize").get("v.value");
        console.log("pageSize=="+pageSize );
        helper.createAccountHelper( component, newAcc, pageNumber, pageSize, event, helper );  
        
    },


    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
    },
     
  
    hideSpinner : function(component,event,helper){
      // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    },

    handleSub : function( component, event, helper ) {
        var selectedMenuItemIdAndValue = event.getParam("value").split(',')
        var selectedMenuItemId = selectedMenuItemIdAndValue[0];
    },

    // myAction : function( component, event, helper ) {
    //     var toastEvent = $A.get("e.force:showToast"); 
    //     toastEvent.setParams({ 
    //         "title": "Success!", 
    //         "message": "Record is successfully updated!", 
    //         "type": "success" 
    //     }); 
    //     toastEvent.fire();
    // },

    createContact : function( component, event, helper ) {
        var newCon= component.get("v.newContact");
        console.log("new contact 1 step ==="+newCon);
        console.log("contactsss... "+JSON.stringify(newCon));
        var accId= component.get("v.recordIdOfCon");
        console.log("new account 1 step ==="+accId);
        component.set("v.selectedCount", 0);
        helper.createContactHelper( component, newCon, accId, helper );
    },

    showTheModul : function( component, event, helper ) {
        component.set("v.ShowModuleForNewContact", true);
    },

    hideNewContactModal : function( component, event, helper ) {
        component.set("v.ShowModuleForNewContact", false);
        component.set("v.selectedCount", 0);
    },

    editTheForm : function( component, event, helper ) {
        event.preventDefault();       // stop the form from submitting
        var allFields = event.getParam('fields');
        console.log("edit form="+JSON.stringify(allFields));
        var lst = component.get("v.accountList");
        var lstId = component.get("v.recordId");
        console.log("lst form==="+JSON.stringify(lst));
        console.log("lst form====="+lstId);
        //helper.editTheFormHelper(component, event, allFields, lstId);
        for (var i=0; i<lst.length; i++) {
            if ( lst[i].Id == lstId) {
                lst.splice(i,1, allFields);
            }
        }
        lst.push(allFields);
        component.set("v.accountList",lst);
        //helper.editTheFormHelper(component, event, allFields, lstId);
        component.set("v.showDetails", false);
    },

    
    checkboxSelect: function( component, event, helper ) {
        var button = component.find('disablebuttonid');
        var selectedRec = event.getSource().get("v.value");
        var sizeOfCon= component.get("v.contactList").length;
        var getSelectedNumber = component.get("v.selectedCount");
        var getAllId = component.find("boxPack");

        if ( selectedRec == true ) {
            getSelectedNumber++; 
            for ( var i=1; i<=sizeOfCon; i++ ) {
                if ( getSelectedNumber > 0 ) {
                    button.set('v.disabled',false);
                } else {
                    button.set('v.disabled',true);
                }  
            }

            if ( sizeOfCon == getSelectedNumber ) {
                component.find("box3").set("v.value", true);
            } else {
                component.find("box3").set("v.value", false);
            }
        } else {
            getSelectedNumber--;
            for ( var i=1; i<=sizeOfCon; i++ ) {
                if ( getSelectedNumber > 0 ) {
                    button.set('v.disabled',false);
                } else {
                    button.set('v.disabled',true);
                }  
            }

            if ( sizeOfCon == getSelectedNumber ) {
                component.find("box3").set("v.value", true);
            } else {
                component.find("box3").set("v.value", false);
            }
        }
        component.set("v.selectedCount", getSelectedNumber);
    },


    // For select all Checkboxes 
    selectAll: function(component, event, helper) {
        var button = component.find('disablebuttonid');
        var selectedHeaderCheck = event.getSource().get("v.value");
        var getAllId = component.find("boxPack");
        // If the local ID is unique[in single record case], find() returns the component. not array   
        if ( !Array.isArray(getAllId) ) {
            if ( selectedHeaderCheck == true ) { 
                component.find("boxPack").set("v.value", true);
                component.set("v.selectedCount", 1);
                button.set('v.disabled',false);
            } else {
                component.find("boxPack").set("v.value", false);
                component.set("v.selectedCount", 0);
                button.set('v.disabled',true);
            }
            } else {
            if ( selectedHeaderCheck == true ) {
                for ( var i = 0; i < getAllId.length; i++ ) {
                    component.find("boxPack")[i].set("v.value", true);
                    component.set("v.selectedCount", getAllId.length);
                    button.set('v.disabled',false);
                }
            } else {
                for (var i = 0; i < getAllId.length; i++) {
                    component.find("boxPack")[i].set("v.value", false);
                    component.set("v.selectedCount", 0);
                    button.set('v.disabled',true);
                }
            } 
        }  
    },

   //For Delete selected records 
    deleteSelected: function(component, event, helper) {
        var button = component.find('disablebuttonid');
        button.set('v.disabled',true);
        var delId = [];
        var getAllId = component.find("boxPack");
        if (! Array.isArray(getAllId)) {
            if (getAllId.get("v.value") == true) {
                delId.push(getAllId.get("v.text"));
            }
        } else {
            for (var i = 0; i < getAllId.length; i++) {
                if (getAllId[i].get("v.value") == true) {
                    delId.push(getAllId[i].get("v.text"));
                }
            }
        } 
        helper.deleteSelectedHelper(component, event, delId);     
    },

    keyCheck :  function(component, event, helper) {
        var button = component.find('disablebuttonidofSave');
        button.set('v.disabled',false);
    },

    goByIndex : function(component, Event, helper) {
        //component.getEvent("AddRowEvt").fire();
        var indexOfInputFiled = document.getElementById("input1").value; 
        if ( indexOfInputFiled > 0 && indexOfInputFiled <=10) {
            component.set("v.parentAttForAddMultiRow", indexOfInputFiled);
            var childCmp = component.find("childComponent");
            var retnMsg = childCmp.GetValueFromChildMethod(indexOfInputFiled);
            document.getElementById('input1').value = '';
        } else {
            alert("please enter the value under the 10.")
        }
    },

    forKanbag : function(component, event, helper) {
        var isButtonVisible = component.get("v.hideMainCmdClickOnKan");
        var disableStatuss = component.get("v.HideTheTopButton");
        console.log("!!!!!",disableStatuss);
        var isButtonVi = component.get("v.showModelForKanbag");  
        if ( isButtonVisible == true ) {
            component.set("v.HideTheTopButton",true);
            component.set("v.hideMainCmdClickOnKan",false);
            component.set("v.showModelForKanbag",true);
 
        } else {
            component.set("v.HideTheTopButton",false);
            component.set("v.hideMainCmdClickOnKan",true);
            component.set("v.showModelForKanbag",false);
        } 
    }
})