({
	getAccountRecordsHelper : function(component, event) {
		var action = component.get('c.getKanbanAccList');
		action.setCallback(this, function(response){
			var state = response.getState();
			if (state === 'SUCCESS') {				
				component.set('v.accList', response.getReturnValue())			
			} else {
				alert('Error : ' + JSON.stringify(response.getError()))
			}
		})
		$A.enqueueAction(action);
	},	

	changeSelectedRowColor: function(component, event, selectOption){
        console.log("---selectOption----",selectOption);
		if (selectOption == 1) {		
			var index = event.currentTarget.value;
			var list = event.currentTarget.getAttribute("data-produto"); 		
			if (list == 'list1') {
				var listOfData = component.get('v.accList');		
				var returnValue = this.selectRecordUsingCtrl(component, event, listOfData, index);
				component.set('v.accList', returnValue );
			} else {						
				var listOfData = component.get('v.accSelectList');		
				var returnValue = this.selectRecordUsingCtrl(component, event, listOfData, index);
				component.set('v.accSelectList', returnValue );				
			}					
		} else if (selectOption == 2) {
			var index = event.currentTarget.value;		
			component.set('v.selectedRecord', index);		
			var list = event.currentTarget.getAttribute("data-produto"); 		
			if (list == 'list1') {			
				var listOfData = component.get('v.accList');		
				var returnValue = this.setColorOfRow(component, event, listOfData, index);
				component.set('v.accList', returnValue );
			} else {						
				var listOfData = component.get('v.accSelectList');		
				var returnValue = this.setColorOfRow(component, event, listOfData, index);
				component.set('v.accSelectList', returnValue );
			}				
		}	
	},

	setColorOfRow : function(component, event, listOfData, index){		
		var updatedData = [];
		for (var i = 0; i < listOfData.length; i++) {			
			if (i == index) {				
				updatedData.push({'Id': listOfData[i].Id, 'Name': listOfData[i].Name, 'isSelected' : true});				
			} else {
				updatedData.push({'Id': listOfData[i].Id, 'Name': listOfData[i].Name, 'isSelected' : false});
			}
		}
		return updatedData;
	},

	showSelectedDataHelper : function(component, event){		
		var getSelectedData = component.get('v.accSelectList');		
		component.set('v.showSelectedAcc', getSelectedData);		
	},

	sortData: function(component, event, listOfData, dragElementIndex, dropIndex) {
		var updatedData = [];
		var dragData;
		var dropData;
		for(var i = 0; i < listOfData.length; i++){			
			if(i == dragElementIndex){				
				dragData = listOfData[i];
			} else if(i == dropIndex) {			
				dropData = listOfData[i];
			}
		}	
		for (var i = 0; i < listOfData.length; i++) {
			if (i == dragElementIndex) {
			    updatedData.push(dropData);
			} else if(i == dropIndex) {
				updatedData.push(dragData);
			} else {
				updatedData.push(listOfData[i]);
			}
		}  
		return updatedData;      			
	},

	selectRecordUsingCtrl: function(component, event, listOfData, index) {
        console.log("----listOfData----",listOfData);
        console.log("----index----",index);
		var updatedData = [];
		for (var i = 0; i < listOfData.length; i++) {			
			if (i == index) {								
				if (listOfData[i].isSelected == true) {
					updatedData.push({'Id': listOfData[i].Id, 'Name': listOfData[i].Name, 'isSelected' : false});
				} else {
					updatedData.push({'Id': listOfData[i].Id, 'Name': listOfData[i].Name, 'isSelected' : true});
				}
			} else {
				updatedData.push({'Id': listOfData[i].Id, 'Name': listOfData[i].Name, 'isSelected' : listOfData[i].isSelected});
			}
		}
		return updatedData;
	},

	isItemSelected : function(component, event, list) {
		if(list == 1) {
			var listOfData = component.get('v.accList');
			var sDAta = [];
			var lastIndex;
			var includeIndex = [];
			for (var i = 0; i < listOfData.length; i++) {
				if (listOfData[i].isSelected) {
					sDAta.push(listOfData[i]);
					includeIndex.push(i);
					lastIndex = i;
				}
			}
			
			if (sDAta.length == null || sDAta.length == 0) {
				return false;
			} else {			
				component.set('v.SelectedData', sDAta);
				component.set('v.maxind', lastIndex);
				component.set('v.includeInd', includeIndex);				
				return true;
			}
		} else if(list == 2) {
			var listOfData = component.get('v.accSelectList');
			var selectedData = [];
			var lastIndex;
			var includeIndex = [];
			for (var i = 0; i < listOfData.length; i++) {
				if (listOfData[i].isSelected) {
					selectedData.push(listOfData[i]);
					includeIndex.push(i);
					lastIndex = i;
				}
			}

			if (selectedData.length == null || selectedData.length == 0) {
				return false;
			} else {
				component.set('v.SelectedData', selectedData);
				component.set('v.maxind', lastIndex);
				component.set('v.includeInd', includeIndex);
				return true;
			}
		}
	},

	setData: function(component, event, dropIndex, list) {
		var selectedData = component.get('v.SelectedData');
		var lastIndex = component.get('v.maxind');
		var dropData;
		var updatedData = [];
		if (dropIndex != undefined) {			
			if (list == 1) {					
				var listOfData = component.get('v.accList');			
				dropData = listOfData[dropIndex];		
				var status = this.checkDropDataExistsInSelectedRecordList(component, event, selectedData, dropData);	
				if (!status) {
					status = this.checkDragDataExistsInSelectedRecordList(component, event, selectedData);	
					if (status) {
						var includeIndex = component.get('v.includeIndex');
						var lastSelectedValueIndex = includeIndex[includeIndex.length-1];
						if(dropIndex > lastSelectedValueIndex) {
							var firstIndexOfSelectedItem = includeIndex[0]
							for (var i = 0; i < listOfData.length; i++) {
								if (i == dropIndex) {
									for (var j = 0; j < selectedData.length; j++) {
										updatedData.push(selectedData[j]);
									}
								} else if(i == firstIndexOfSelectedItem) {
									updatedData.push(dropData);
								} else {
									if (!includeIndex.includes(i)) {
										updatedData.push(listOfData[i]);
									}
								}
							}	
							component.set('v.accList', updatedData);
						} else {
							for (var i = 0; i < listOfData.length; i++) {
								if (i == dropIndex) {
									for (var j = 0; j < selectedData.length; j++) {
										updatedData.push(selectedData[j]);
									}
								} else if(i == lastSelectedValueIndex) {
									updatedData.push(dropData);
								} else {
									if (!includeIndex.includes(i)) {
										updatedData.push(listOfData[i]);
									}
								}
							}
						}
					} else {
						var dragData = component.get('v.selectAcc')
						for (var i = 0; i < listOfData.length; i++) {
							if(dropData.Id == listOfData[i].Id){
								updatedData.push(dragData);
							} else if(listOfData[i].Id == dragData.Id) {
								updatedData.push(dropData);
							} else {
								updatedData.push(listOfData[i]);
							}
						}
					}
					component.set('v.accList', updatedData);
				} else {			
					var result = this.setSecondListData(component, event, listOfData, firstIndexOfSelectedItem, selectedData, dropData, dropIndex);
					component.set('v.accList', result);
				}	
			} else if(list == 2) {
				var listOfData = component.get('v.accSelectList');
				dropData = listOfData[dropIndex];
				var status = this.checkDropDataExistsInSelectedRecordList(component, event, selectedData, dropData);				
				if (!status) {
					status = this.checkDragDataExistsInSelectedRecordList(component, event, selectedData);			
					if (status) {
						var includeIndex = component.get('v.includeInd');
						var lastSelectedValueIndex = includeIndex[includeIndex.length-1];
						if (dropIndex > lastSelectedValueIndex) {
							var firstIndexOfSelectedItem = includeIndex[0]
							for (var i = 0; i < listOfData.length; i++) {
								if (i == dropIndex) {
									for (var j = 0; j < selectedData.length; j++) {
										updatedData.push(selectedData[j]);
									}
								} else if(i == firstIndexOfSelectedItem) { 
									updatedData.push(dropData);
								} else {
									if (!includeIndex.includes(i)) {
										updatedData.push(listOfData[i]);
									}
								}
							}	
							component.set('v.accSelectList', updatedData);
						} else {
							for (var i = 0; i < listOfData.length; i++) {
								if (i == dropIndex) {
									for (var j = 0; j < selectedData.length; j++) {
										updatedData.push(selectedData[j]);
									}
								} else if(i == lastSelectedValueIndex) {
									updatedData.push(dropData);
								} else {
									if (!includeIndex.includes(i)) {
										updatedData.push(listOfData[i]);
									}
								}
							}
						}	
					} else { 
						var dragData = component.get('v.selectAcc')
						for (var i = 0; i < listOfData.length; i++) {
							if (dropData.Id == listOfData[i].Id) {
								updatedData.push(dragData);
							} else if(listOfData[i].Id == dragData.Id) {
								updatedData.push(dropData);
							} else {
								updatedData.push(listOfData[i]);
							}
						}
					}
					component.set('v.accSelectList', updatedData);
				} else {
					var result = this.setSecondListData(component, event, listOfData, firstIndexOfSelectedItem, selectedData, dropData, dropIndex);					
					component.set('v.accSelectList', result);
				}
			}
		}		
	},

	removeDuplicateRecords: function(component, event, recordList) {	
		var seen = new Set();
		var filteredArr = recordList.filter(obj => {
			var duplicate = seen.has(obj.Id);
			seen.add(obj.Id);
			return !duplicate;
		});		
		return filteredArr;		
	},

	checkDropDataExistsInSelectedRecordList: function(component, event, recordList, dropPlace){
		var status = false;				
		recordList.filter(function(obj){
			if(obj.Id == dropPlace.Id){
				status = true;
			}
		})

		return status;
	},

	checkDragDataExistsInSelectedRecordList: function(component, event, recordList){	
		var dropData = component.get('v.selectAcc');
		var status = false;

		recordList.filter(function(obj){
			if(obj.Id == dropData.Id){
				status = true;
			}
		})

		return status;	
	},

	setSecondListData : function(component, event, listOfData, firstIndexOfSelectedItem, selectedData, dropData, dropIndex){
		var includeIndex = component.get('v.includeInd');
		var lastSelectedValueIndex = includeIndex[includeIndex.length-1];
		var updatedData = [];
		var dragItemIndex = component.get('v.indexOfSelectAcc');
		var dragData = listOfData[dragItemIndex]
		
		if(dropIndex > lastSelectedValueIndex){

			var firstIndexOfSelectedItem = includeIndex[0]
			

			for(var i = 0; i < listOfData.length; i++){
				if(i == dragItemIndex){
					for(var j = 0; j < selectedData.length; j++){
						updatedData.push(selectedData[j]);
					}
					i += selectedData.length;
				}
				else if(i == firstIndexOfSelectedItem){
					updatedData.push(dragData);
				}
				else{
					if(!includeIndex.includes(i)){
						updatedData.push(listOfData[i]);
					}
				}
			}	

			var result = this.removeDuplicateRecords(component, event, updatedData)
			return result;
		}
		else{			
			var lastIndex = includeIndex[includeIndex.length-1];

			if(dragItemIndex > dropIndex){
				for(var i = 0; i < listOfData.length; i++){
					if(i == dropIndex){
						updatedData.push(dragData)
					}
					else if(i == dragItemIndex){
						for(var j = 0; j < selectedData.length; j++){
							updatedData.push(selectedData[j]);
						}
					}
					else{
						if(!includeIndex.includes(i)){
							updatedData.push(listOfData[i]);
						}
					}
				}
			}
			else{
				for(var i = 0; i < listOfData.length; i++){

					if(i == lastIndex){
						updatedData.push(dragData)
					}
					else if(i == dragItemIndex){
						for(var j = 0; j < selectedData.length; j++){
							updatedData.push(selectedData[j]);
						}
					}
					else{
						if(!includeIndex.includes(i)){
							updatedData.push(listOfData[i]);
						}
					}
				}
			}
			var result = this.removeDuplicateRecords(component, event, updatedData)
			return result;
		}
	}

})