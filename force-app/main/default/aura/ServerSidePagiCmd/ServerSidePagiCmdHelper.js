({
	//1. HELPER FUNCTION FOR INIT HANDLER
	doInit : function(component, event) {
		var doInitAction = component.get("c.doInitSObjectList");
		doInitAction.setCallback(this, function(initResponse){
			if(initResponse.getState() == 'SUCCESS'){
				component.set("v.SObjects", JSON.parse(initResponse.getReturnValue()));
				component.set("v.selectedSObject", 'none');
			}else{
				this.fireToast('Error in doInit','error');
			}
			this.hideSpinner(component);
		});
		$A.enqueueAction(doInitAction);
	},

	//2. HELPER FUNCTION TO RETRIVE FIELDS LIST
	getFields : function(component, event){
		var selectedSObject = event.getParam("value");
		
		this.clearAllAttributes(component, event);
		if(selectedSObject == 'none'){
			return;
		}
		this.showSpinner(component);
		var objectChangeAction = component.get("c.doInitFieldList");
		objectChangeAction.setParams({
			"sObjectApiName" : selectedSObject
		});
		objectChangeAction.setCallback(this, function(response){
			if(response.getState() == 'SUCCESS'){
				var returnedValue = JSON.parse(response.getReturnValue());
				component.set("v.fields", returnedValue.fields);
				component.set("v.totalRecords", returnedValue.resultSize);
				component.set("v.nameField", returnedValue.nameField);
				this.updateTotalPages(component, event);
			}else{
				this.fireToast('Error in getFields','error');
			}
			this.hideSpinner(component);
		});
		$A.enqueueAction(objectChangeAction);
	},

	//3. FUNCTION TO FETCH RECORDS FIRST TIME WHEN FIELDS ARE SELECTED
	getRecordsFirstTime : function(component, event){
		var selectedFields = component.get("v.selectedFields");
		if(selectedFields.length == 0){
			component.set("v.fieldsToShow",[]);
			component.set("v.records",[]);
			this.hideSpinner(component);
			return;
		}
		var commaSeparatedFields = '';
		selectedFields.forEach(function(field){
			commaSeparatedFields += field + ',';
		});
		commaSeparatedFields = commaSeparatedFields.substring(0, commaSeparatedFields.length - 1);
		var baseQuery = 'SELECT ';
		if(selectedFields.includes("id")){
			baseQuery += commaSeparatedFields;
		}else{
			baseQuery += 'id,' + commaSeparatedFields;
		}
		baseQuery += ' FROM ';
		baseQuery += component.get("v.selectedSObject");
		component.set("v.baseQuery", baseQuery);
		this.getRecords(component, event, ' ORDER BY ID', false);
		component.set("v.pageNumber", 1);
	},

	//4. FUNCTION TO DTECH RECORDS VIA HITTING APEX
	getRecords : function(component, event, supportingQueryParameters, isLastPage){
		this.showSpinner(component);	
		//HIT APEX CONTROLLER TO GET RECORDS
		var getRecordsAction = component.get("c.doQueryForRecords");
		var queryString =  component.get("v.baseQuery") + supportingQueryParameters;
		if(!isLastPage){
			queryString += ' LIMIT ' + component.get("v.pageSize");
		}else{
			
			var pageSize = component.get("v.pageSize");
			console.log("==page ==Size",pageSize);
			var totalPages = component.get("v.totalPages");
			console.log("==totalPages ==Size",totalPages);
			var totalRecords = component.get("v.totalRecords");
			var limit  = pageSize - (totalPages*pageSize - totalRecords);
			queryString += ' LIMIT ' + limit;
		}
		console.log(queryString);
		getRecordsAction.setParams({
			"queryString" : queryString,
			"isReversedList" : component.get("v.isReversedList")
		});
		getRecordsAction.setCallback(this, function(response){
			if(response.getState() == 'SUCCESS'){
				this.generateRecordsList(component, event, response);
			}else{
				this.fireToast('Error in getRecords','error');
			}
			this.generateFieldsToShow(component, event);
			this.hideSpinner(component);
		});
		$A.enqueueAction(getRecordsAction);
	},

	//5. FUNCTION TO GENERATE RECORDS DATA TO SHOW ON TABLE (bcz there is no dynamic binding)
	generateRecordsList : function(component, event, getRecordsResponse){
		var returnedValue = JSON.parse(getRecordsResponse.getReturnValue());
		if(returnedValue.length == 0){
			component.set("v.records", []);
			return;
		}
		component.set("v.currentRecordSetFirstRecordId", returnedValue[0].id);
		component.set("v.currentRecordSetLastRecordId", returnedValue[returnedValue.length - 1].id);
		var selectedFields = component.get("v.selectedFields");
		var records = [];
		var mapToHoldState = component.get("v.mapToHoldState");
		returnedValue.forEach(function(record){
			var fieldValues = [];
			selectedFields.forEach(function(field){
				if(field == "id" && !component.get("v.selectedFields").includes("id")){
					return;
				}
				if(record[field] == 'null'){ //here null value is in string format
					fieldValues.push('-');
				}else{
					fieldValues.push(record[field]);
				}
			});
			if(mapToHoldState.includes(record.id)){
				records.push({"id": record.id, "isSelected": true, "fieldValues" : fieldValues});
			}else{
				records.push({"id": record.id, "isSelected": false, "fieldValues" : fieldValues});
			}
			
		});
		component.set("v.records", records);
		this.updateHasNextHasPrevious(component, event);
		this.updateMasterCheckBox(component, event);
	},

	//6. FUNCTION TO FETCH FIRST RECORD SET
	fetchFirstRecordSet : function(component, event){
		component.set("v.isReversedList", false);
		this.getRecords(component, event, ' ORDER BY id ASC', false);
		component.set("v.pageNumber", 1);
	},

	//7. FUNCTION TO FETCH NEXT RECORD SET
	fetchNextRecordSet : function(component, event){
		var baseId = component.get('v.currentRecordSetLastRecordId');
		component.set("v.isReversedList", false);
		this.getRecords(component, event, ' WHERE ID > \'' + baseId + '\' ORDER BY id ASC', false);
		component.set("v.pageNumber", component.get("v.pageNumber") + 1);
	},

	//8. FUNCTION TO FETCH PREVIOUS RECORD SET
	fetchPreviousRecordSet : function(component, event){
		var baseId = component.get('v.currentRecordSetFirstRecordId');
		component.set("v.isReversedList", true);
		this.getRecords(component, event, ' WHERE ID < \'' + baseId + '\' ORDER BY id DESC', false);
		component.set("v.pageNumber", component.get("v.pageNumber") - 1);
	},

	//9. FUNCTION TO FETCH LAST RECORD SET
	fetchLastRecordSet : function(component, event){
		component.set("v.isReversedList", true);
		this.getRecords(component, event, ' ORDER BY id DESC', true);
		component.set("v.pageNumber", component.get("v.totalPages"));
	},

	//10. FUNCTION TO CHANGE PAGE SIZE
	changePageSize : function(component, event){
		component.set("v.pageSize", event.currentTarget.value);
		this.updateTotalPages(component, event);
		this.fetchFirstRecordSet(component, event);
	},

	//11. FUNCTION TO UPDATE TOTAL PAGES COUNT
	updateTotalPages : function(component, event){
		var totalRecords = component.get("v.totalRecords");
		var pageSize = component.get("v.pageSize");
		var totalPages;
		if(pageSize > totalRecords){
			totalPages = 1;
		}else{
			totalPages = totalRecords / pageSize;
			if(Math.ceil(totalPages) != Math.floor(totalPages)){
				totalPages = parseInt(totalPages) + 1;
			}
		}
		component.set("v.totalPages", totalPages);
	},

	//12. FUNCTION TO UPDATE HAS NEXT, HAS PREVIOUS BUTTONS STATE
	updateHasNextHasPrevious : function(component, event){
		//hasNext
		if(component.get("v.pageNumber") == component.get("v.totalPages")){
			component.set("v.hasNext", false);
		}else{
			component.set("v.hasNext", true);
		}
		//hasPrevious
		if(component.get("v.pageNumber") == 1){
			component.set("v.hasPrevious", false);
		}else{
			component.set("v.hasPrevious", true);
		}
	},

	//13. FUNCTION TO PREPARE FOR SORT 
	sort : function(component, event){
		var previousSortField = component.get("v.sortField");
		var currentSortField = event.currentTarget.dataset.field;
		component.set("v.sortField", currentSortField);
		if(previousSortField == currentSortField){
			this.toggleSortDirection(component, event);
			this.performClientSideSorting(component, component.get("v.records"), currentSortField, component.get("v.sortDirection"));
		}else{
			component.set("v.sortDirection", 'ASC');
			this.performClientSideSorting(component, component.get("v.records"), currentSortField, component.get("v.sortDirection"));
		}
		
	},

	//14. FUNCTION TO PERFORM CLIENT SIDE SORTING 
	performClientSideSorting : function(component, records, sortField, sortDirection){
		records = records.sort((a, b) => (a[sortField] > b[sortField]) ? 1 : -1);
		component.set("v.records", records);
	},

	//15. FUNCTION TO TOGGLE SORT DIRECTION "ASC <=> DESC"
	toggleSortDirection : function(component, event){
		var sortDirection = component.get("v.sortDirection");
		sortDirection = sortDirection == 'ASC' ? 'DESC' : 'ASC';
		component.set("v.sortDirection", sortDirection);
	},

	//16. FUNCTION TO CLEAR ALL ATTRIBUTES ON OBJECT CHANGE
	clearAllAttributes : function(component, event){
		component.set("v.fields", []);
		component.set("v.selectedFields", []);
		component.set("v.fieldsToShow", []);
		component.set("v.records", []);
		component.set("v.totalRecords", 0);
		component.set("v.hasPrevious", false);
		component.set("v.hasNext", false);
		component.set("v.pageNumber", 1);
		component.set("v.totalPages", 1);
		component.set("v.currentRecordSetFirstRecordId", '');
		component.set("v.currentRecordSetLastRecordId", '');
		component.set("v.baseQuery", '');
		component.set("v.whereClause", '');
		component.set("v.pageSize", 5);
		component.set("v.sortDirection", 'ASC');
		component.set("v.isReversedList", false);
		component.set("v.offlineRecords", []);
	}, 

	//17. FUNCTION TO GENERATE FIELDS TO SHOW ON UI
	generateFieldsToShow : function(component, event){
		var selectedFields = component.get("v.selectedFields");
		var fields = component.get("v.fields");
		var fieldsToShow = [];
		selectedFields.forEach(function(selectedField){
			fieldsToShow.push(fields[fields.findIndex(x => x.value === selectedField)]);
		});
		component.set("v.fieldsToShow", fieldsToShow);
	},

	//18. FUNCTION TO SHOW SPINNER
	showSpinner : function (component) {
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
        $A.util.addClass(spinner, "slds-show");
	},
	
	//19. FUNCTION TO HIDE SPINNER
    hideSpinner : function (component) {
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-show");
        $A.util.addClass(spinner, "slds-hide");
	},

	//20. FUNCTION TO FIRE TOAST MESSAGES
	fireToast : function(message, type) {
		var toastEvent = $A.get("e.force:showToast");
		toastEvent.setParams({
			"type": type,
			"message": message
		});
		toastEvent.fire();
	},

	//21. HELPER FUNCTION TO UPDATE CHILD CHECKBOXS ACCORDING TO MASTER CB
	updateCheckBoxes : function(component, event){
		var isMCBChecked = event.getSource().get("v.checked");
		var records = component.get("v.records");
		records.forEach(function(record){
			record.isSelected = isMCBChecked;
		});
		component.set("v.records", records);
		this.updateMapToHoldState(component, event);
	},

	//22. FUNCTION TO UPDATE MASTER CHECKBOX ACCORDING TO CHILD CHECKBOXES
	updateMasterCheckBox : function(component, event){
		this.updateMapToHoldState(component, event);
		var mcb = component.get("v.masterCheckBox");
		var flag = true;
		var records = component.get("v.records");
		records.forEach(function(record){
			if(record.isSelected == false){
				flag = false;
				return;
			}
		});
		if(flag){
			mcb = true;
		}else{
			mcb = false;
		}
		component.set("v.masterCheckBox", mcb);
	},

	//23. FUNCTION TO UPDATE MAP(ACTUALLY LIST) TO MAINTAIN CHECKBOXES STATE
	updateMapToHoldState : function(component, event){
		var mapToHoldState = component.get("v.mapToHoldState");
		if(mapToHoldState == null){
			mapToHoldState = [];
		}
		var records = component.get("v.records");
		records.forEach(function(record){
			if(record.isSelected == true && !mapToHoldState.includes(record.id)){
				mapToHoldState.push(record.id);
			}else if(record.isSelected == false && mapToHoldState.includes(record.id)){
				mapToHoldState.splice(mapToHoldState.indexOf(record.id), 1);
			}
		});
		component.set("v.records", records);
		var selectedCount = document.getElementById("selected");
		if(selectedCount != null){
			selectedCount.innerHTML = mapToHoldState.length;
		}
	}
})