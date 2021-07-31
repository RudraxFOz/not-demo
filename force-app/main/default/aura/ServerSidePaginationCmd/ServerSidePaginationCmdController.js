({
    doInit: function(component, event, helper) {
        
        helper.doInitHelper(component, event);
    },
    
    changePageSize: function (component, event, helper) {
        component.set("v.pageSize", event.currentTarget.value);
        helper.showRecordByQueryHelper(component, event);
        //helper.selectAllCheckbox(component, event);
        //helper.checkboxSelect(component, event);
        component.set("v.masterCheckBox",false);
        var getSelectedNumber = component.get("v.selectedCount");
        if (getSelectedNumber == component.get("v.pageSize")) {   
            component.set("v.masterCheckBox",true);
        }
        //alert(cmp.find('select').get('v.value') + ' pie is good.');
    },
 
    /* javaScript function for pagination */
    navigation: function(component, event, helper) {
        var sObjectList = component.get("v.listOfAllAccounts");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var whichBtn = event.getSource().get("v.name");
        // check if whichBtn value is 'next' then call 'next' helper method
        if (whichBtn == 'next') {
            component.set("v.currentPage", component.get("v.currentPage") + 1);
            helper.next(component, event, sObjectList, end, start, pageSize);
        }
        // check if whichBtn value is 'previous' then call 'previous' helper method
        else if (whichBtn == 'previous') {
            component.set("v.currentPage", component.get("v.currentPage") - 1);
            helper.previous(component, event, sObjectList, end, start, pageSize);
        }  else if (whichBtn == 'Last') {
            component.set("v.currentPage", component.get("v.totalPagesCount") );
            helper.last(component, event, helper, sObjectList, end, start, pageSize);
        } else if (whichBtn == 'First') {
            component.set("v.currentPage", 1);
            helper.first(component, event, helper, sObjectList, end, start, pageSize);
        }
    },
    

    selectAllCheckbox: function(component, event, helper) {
        helper.selectAllCheckbox(component, event);
      
    },
 
    checkboxSelect: function(component, event, helper) {
        // on each checkbox selection update the selected record count 
      helper.checkboxSelect(component, event);
    },
 
   

    onSelectObj : function (component, event, helper) {

        helper.fetchPickListVal(component, 'Name', 'listSkillsOptions');
    },
    handleChange:function(component,event,helper) {

        var selectedOptionsList = event.getParam("value");
        console.log(selectedOptionsList);
        component.set("v.lstToShow", selectedOptionsList);
    },
    showRecordByQuery : function (component, event, helper) {
        helper.showRecordByQueryHelper(component, event, helper);
    },

    sort : function(component, event, helper){
		helper.sort(component, event);
	},
})