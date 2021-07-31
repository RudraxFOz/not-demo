({
	//1. FUNCTION FOR INIT HANDLER
	doInit : function(component, event, helper) {
		helper.doInit(component, event);
	},

	//2. FUNCTION TO GET FIELDS LIST 
	getFields : function(component, event, helper){
		helper.getFields(component, event);
	},

	//3. FUNCTION TO RETRIEVE RECORDS FIRST TIME AFTER FIELDS SELECTION
	getRecordsFirstTime : function(component, event, helper){
		helper.getRecordsFirstTime(component, event);
	},

	//4. FUNCTION TO PERFORM CHANGE PAGE SIZE ACTION
	changePageSize : function(component, event, helper){
		helper.changePageSize(component, event);
	},

	//5. FUNCTION TO FETCH NEXT SET OF RECORDS
	fetchNextRecordSet : function(component, event, helper){
		helper.fetchNextRecordSet(component, event);
	},

	//6. FUNCTION TO FETCH PREVIOUS SET OF RECORDS
	fetchPreviousRecordSet : function(component, event, helper){
		helper.fetchPreviousRecordSet(component, event);
	},

	//7. FUNCTION TO FETCH FIRST SET OF RECORDS
	fetchFirstRecordSet : function(component, event, helper){
		helper.fetchFirstRecordSet(component, event);
	},

	//8. FUNCTION TO FETCH LAST SET OF RECORDS
	fetchLastRecordSet : function(component, event, helper){
		helper.fetchLastRecordSet(component, event);
	},

	//9. FUNCTION TO SORT CURRENT PAGE
	sort : function(component, event, helper){
		helper.sort(component, event);
	},

	//10. FUNCTION TO UPDATE CHECK BOXES ACCORDING TO MASTER CHECKBOX
	updateCheckBoxes : function(component, event, helper){
		helper.updateCheckBoxes(component, event);
	},

	//11. FUNCTION TO UPDATE MASTER CHECKBOX BASED ON CHILD CHECKBOXES
	updateMasterCheckBox : function(component, event, helper){
		helper.updateMasterCheckBox(component, event);
	}
})