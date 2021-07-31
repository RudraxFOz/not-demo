({
	doInit : function(component, event, helper) {		
		helper.getAccountRecordsHelper(component, event);
	},

	allowDrop: function(component, event, helper) {
        console.log("Hellooo allowDrop");
        event.preventDefault();
    },
    
    drag: function (component, event, helper) {
        console.log("Hellooo drag");
        event.dataTransfer.setData("text", event.target.id);						
        var list = event.target.getAttribute("data-produto");  
        console.log("--list@@@---",list);
        component.set('v.selectListName', list);       
        var index = event.currentTarget.value
        console.log("---index---@@drag--",index);
        component.set('v.indexOfSelectAcc', index);
    },	
    
    drop: function (component, event, helper) {   
        console.log("Hellooo Drop");
        event.preventDefault();        
        var data = event.dataTransfer.getData("text");   
        console.log("Hellooo Drop data",data);     
        var index = event.currentTarget.value    
        var listName = component.get('v.selectListName');
        if (listName == 'list1') {        	       	
            var classOfCurrentTar = event.currentTarget.className     
            console.log("---classOfCurrentTar----",classOfCurrentTar); 	
        	var accListD = component.get('v.accList');
        	for(var i = 0; i < accListD.length; i++){        		
        		if(data == accListD[i].Id){
        			component.set('v.selectAcc', accListD[i]);
        			break;
        		}
        	}

        	if (classOfCurrentTar.includes('list1')) {
        		var status = helper.isItemSelected(component, event, 1);        		
                var selectedData = component.get('v.SelectedData');
                console.log("---selectedData---",selectedData);
        		if(status == true && selectedData.length > 1){
        			var dropIndex = event.target.dataset.dragId;
        			helper.setData(component, event, dropIndex, 1);
        		} else {
	        		var dropIndex = event.target.dataset.dragId;
	        		if (dropIndex != undefined && dropIndex != null && dropIndex != '') {	        			
	        			var listOfData = component.get('v.accList');
	        			var dragElementIndex = component.get('v.indexOfSelectAcc');
	        			if (dragElementIndex != dropIndex) {
		        			var updatedData = helper.sortData(component, event, listOfData, dragElementIndex, dropIndex)        			
		        			component.set('v.accList', updatedData);
		        		}
	        		} else {
	        			console.log('invalid index : ');
	        		}
	        	}
        	} else {  		
	        	var newData = component.get('v.accList');
	        	var list2 = component.get('v.accSelectList');
		        for (var i = 0; i < newData.length; i++) {
		        	if(newData[i].isSelected){
		        		list2.push({'Id': newData[i].Id, 'Name': newData[i].Name, 'isSelected' : false})
		        		newData.splice(i, 1);
		        		i--;
		        	}        	
		        }
		        if (list2.length == null) {	        	
			        component.set('v.accSelectList', list2);
			        component.set('v.accList',  newData);
			    } else {
			    	for (var i = 0; i < newData.length; i++) {
			        	if (newData[i].Id == data) {
			        		list2.push({'Id': newData[i].Id, 'Name': newData[i].Name, 'isSelected' : false})
			        		newData.splice(i, 1);
			        		i--;
			        	}        	
		        	}	
		        	component.set('v.accSelectList', list2);
			        component.set('v.accList', newData);
			    }	        	
	        }
        } else if (listName == 'list2') {
        	var setDragData = component.get('v.accSelectList');
        	for (var i = 0; i < setDragData.length; i++) {        		
        		if (data == setDragData[i].Id) {
        			component.set('v.selectAcc', setDragData[i]);
        			break;
        		}
        	}
        	var classOfCurrentTar = event.currentTarget.className
        	if (classOfCurrentTar.includes('list2')) {   
        		var status = helper.isItemSelected(component, event, 2);
        		var selectedData = component.get('v.SelectedData');
        		if (status == true && selectedData.length > 1) {
        			var dropIndex = event.target.dataset.dragId;
        			helper.setData(component, event, dropIndex, 2);
        		} else {  		     		
					var dropIndex = event.target.dataset.dragId;
	        		if (dropIndex != undefined && dropIndex != null && dropIndex != '') {
	        			var listOfData = component.get('v.accSelectList');
	        			var dragElementIndex = component.get('v.indexOfSelectAcc');
	        			//send data for interchange the position of the drag & drop element.
	        			if (dragElementIndex == dropIndex) {
	        			} else {
		        			var updatedData = helper.sortData(component, event, listOfData, dragElementIndex, dropIndex)
		        			component.set('v.accSelectList', updatedData);
		        		}
	        		} else {
	        			console.log('invalid index : ');
	        		}
	        	}
        	} else { 
	        	var list2 = component.get('v.accList');
	        	var newData = component.get('v.accSelectList');
		        for (var i = 0; i < newData.length; i++) {
		        	if (newData[i].isSelected) {		        		
		        		list2.push({'Id': newData[i].Id, 'Name': newData[i].Name, 'isSelected' : false, 'AccountNumber': newData[i].AccountNumber, 'Industry': newData[i].Industry})
		        		newData.splice(i, 1);
		        		i--;
		        	}        	
		        }		        
		        if (list2.length == null) {
			        component.set('v.accList', list2);
			        component.set('v.accSelectList', newData);
			    } else {
			    	for (var i = 0; i < newData.length; i++) {
			        	if (newData[i].Id == data) {
			        		//list2.push(newData[i]);
			        		list2.push({'Id': newData[i].Id, 'Name': newData[i].Name, 'isSelected' : false, 'AccountNumber': newData[i].AccountNumber, 'Industry': newData[i].Industry})
			        		newData.splice(i, 1);
			        		i--;
			        	}        	
		        	}	
		        	component.set('v.accList', list2);
			        component.set('v.accSelectList', newData);
			    }	        	
	        }
        }                
    },

    itemSelected: function(component, event, helper) {        	
    	if (event.ctrlKey) {
    		helper.changeSelectedRowColor(component, event, 1);
    	} else {
            helper.changeSelectedRowColor(component, event, 2);
        } 
    },    

    showData: function(component, event, helper) {       	 	
    	helper.showSelectedDataHelper(component, event);
    }     
})