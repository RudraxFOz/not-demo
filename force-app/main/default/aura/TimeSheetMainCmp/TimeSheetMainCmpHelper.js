({
    setDateOnTimeSheet : function(component, event, startDate, endDate) {
        var action = component.get('c.setTimeSheetRecord');
        action.setParams({
            sDate : startDate,
            eDate : endDate
           });
		action.setCallback(this, function(response){
            var state = response.getState();
			if (state === 'SUCCESS') {				
                component.set('v.timeSheetId', response.getReturnValue());	
                component.set('v.showChildObj', true);	
			} else {
				//alert('Error : ' + JSON.stringify(response.getError()))
			}
		})
		$A.enqueueAction(action);
    },

    createObjectData: function(component, event) {
        // get the contactList from component and add(push) New Object to List  
        var RowItemList = component.get("v.timeSheetItemList");
        RowItemList.push({
            'sobjectType': 'Timesheet_Line_items__c',
            'Project_Name__c': '',
            'Monday__c': '',
            'Tuesday__c': '',
            'Wednesday__c	': '',
            'Thursday__c': '',
            'Friday__c': '',
            'Saturday__c': '',
            'Sunday__c': ''
        });
        // set the updated list to attribute (contactList) again    
        component.set("v.timeSheetItemList", RowItemList);
    },
    // helper function for check if first Name is not null/blank on save  
    validateRequired: function(component, event) {
        var isValid = true;
        var allContactRows = component.get("v.timeSheetItemList");
        for (var indexVar = 0; indexVar < allContactRows.length; indexVar++) {
            if (allContactRows[indexVar].Project_Name__c == '') {
                isValid = false;
                alert('First Name Can\'t be Blank on Row Number ' + (indexVar + 1));
            }
        }
        return isValid;
    },
})