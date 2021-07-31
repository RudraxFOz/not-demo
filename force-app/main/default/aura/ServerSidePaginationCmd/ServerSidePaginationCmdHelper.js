({
    /* doInitHelper funcation to fetch all records, and set attributes value on component load */
    doInitHelper : function(component,event){ 
        var action = component.get("c.getsObjects");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var responseOfObj = response.getReturnValue();
                if(responseOfObj.length > 0){
                    component.set('v.allObject', responseOfObj);
                    console.log("==responseOfObj==",responseOfObj);
                }
            }
            else{
                alert('Error...');
            }
        });
        $A.enqueueAction(action);  
    },

    fetchPickListVal : function(component, event, helper, fieldName, targetAttribute) {
        console.log("tetetess",component.find('selectObject').get('v.value'));
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.find('selectObject').get('v.value')
           
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var opts = [];
                var allValues = response.getReturnValue();
                console.log("allValues==",allValues);
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                console.log('==opts==',opts);
                component.set("v.listSkillsOptions", opts);
            }else{
                alert('Callback Failed...');
            }
        });
        $A.enqueueAction(action);
        
    },

    showRecordByQueryHelper : function (component, event) {
        var action = component.get("c.getFieldsRecord");
        action.setParams({
            "selectedObj" : component.find('selectObject').get('v.value'),
            "fieldsName" : component.get("v.selectedSkillsItems"),
            "recLimits" : component.get("v.pageSize")
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                //console.log("===11allValues==",JSON.stringify(JSON.parse(allValues)));
                var Demo2 = JSON.stringify(allValues);  
                console.log("==Demo222==",Demo2);
                var dd = allValues;
                
                var headerTable = [];
                var pageSize = component.get("v.pageSize");
                var headerTable1 = component.get("v.selectedSkillsItems");
                for (var i = 0; i < headerTable1.length; i++) {
                    //headerTable.push(headerTable1[i]);
                    headerTable.push({
                        label: headerTable1[i],
                        value: headerTable1[i]
                    });
                }
                component.set('v.tableHeader',headerTable);
                var opts = [];
                var allValues = response.getReturnValue();
                console.log('==allValues==',allValues);
                var ListOfRecords = [];
                
                var i = 0;
                for( i ;i< allValues.length;i++){
                  
                    var j = 0;
                    var Records = [];
                   
                    for( j ;j< headerTable1.length;j++){
                      
                        Records.push(allValues[i].sObj[headerTable1[j]]);
                    } 
                    if(component.get("v.manageCheackBoxState").includes(allValues[i].sObj.Id)){
                        ListOfRecords.push({"id": allValues[i].sObj.Id, "isSelected": true, "rec" : Records});
                    }else{
                        ListOfRecords.push({"id": allValues[i].sObj.Id, "isSelected": false, "rec" : Records});
                    }
                  
                    //ListOfRecords.push({"id": allValues[i].sObj.Id, "isSelected": false, "rec" : Records});
                   
                    if(i == 0) {         
                        component.set("v.firstId",allValues[i].sObj.Id);
                    }
                    component.set("v.lastId",allValues[i].sObj.Id);
                }
                console.log('ListOfRecords   = ',ListOfRecords);
                var Demo = JSON.stringify(ListOfRecords);  
                console.log("==Demo==",Demo);
                var Demo1 = JSON.parse(Demo);
                console.log("==Demo1==",Demo1);
                component.set("v.PaginationList",ListOfRecords);

                var totalRecordsList = allValues[0].totalCount;
                component.set("v.totalRecordsCount", totalRecordsList);
                component.set("v.startPage",0);
                component.set("v.endPage",pageSize-1);
                console.log('==totalRecordsList=',totalRecordsList);
                console.log('==pageSize=',pageSize);
                var totalPages = totalRecordsList / pageSize;
                console.log("==totalPages11=",totalPages);
			    if(Math.ceil(totalPages) != Math.floor(totalPages)){
				    totalPages = parseInt(totalPages) + 1;
                }
                console.log("==totalPages22=",totalPages);
                component.set("v.totalPagesCount", totalPages);
                component.set("v.disablePrevious",false);
                 
               
                console.log('==opts==',opts);
                console.log('tete==',component.get("v.PaginationList"));

                
            }else{
                alert('Callback Failed...');
            }
        });
        $A.enqueueAction(action);

    },
    // navigate to next pagination record set   
    next : function(component,event,sObjectList,end,start,pageSize, helper){
        //console.log('tetetete');
        this.callNextAndPrevious(component, event,helper, pageSize);
        //component.set("v.disablePrevious",true);
       
    },
   // navigate to previous pagination record set   
    previous : function(component,event,sObjectList,end,start,pageSize, helper){
        this.callNextAndPrevious(component, event, helper, pageSize);
       
    },
    last : function(component, event, helper, sObjectList, end, start, pageSize) {
        this.callNextAndPrevious(component, event, helper, pageSize);
    },
    first : function(component, event, helper, sObjectList, end, start, pageSize) {
        this.callNextAndPrevious(component, event, helper, pageSize);
    },
    callNextAndPrevious : function(component, event, helper, pageSize) {
        console.log("==page ==Size",pageSize);
        //console.log('tetetete===next==previous');
        var buttonVal = event.getSource().get("v.name");
      
        console.log("=buttonValue==",buttonVal);
            var action = component.get("c.fetchRecList");
            if(buttonVal == 'Last') {
                var pageSize = component.get("v.pageSize");
                console.log('==pageSize==',pageSize);
                var totalPages = component.get("v.totalPagesCount");
                console.log('==totalPages==',totalPages);
                var totalRecords = component.get("v.totalRecordsCount");
                console.log('==totalRecords==',totalRecords);
                var limit   = pageSize - (totalPages * pageSize - totalRecords);
                console.log('==limit==',limit);
                //component.set("v.pageSize",limit);
            }
            action.setParams({ "recLimits" : component.get("v.pageSize"),
                            "lastPageLimit" :  limit,
                          "buttonValue" : event.getSource().get("v.name"),
                          "LastId" : component.get("v.lastId"),
                          "firstId" : component.get("v.firstId"),
                          "selectedObj" : component.find('selectObject').get('v.value'),
                          "fieldsName" : component.get("v.selectedSkillsItems"),
                          "previousButtonLst" : true
                         });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                 var allValues = response.getReturnValue();
                 //component.set('v.listOfAllAccounts', oRes);
                //console.log("come inside",oRes);
                if(allValues.length > 0){
                   var PaginationLst = [];
                   var PaginationLst1 = [];
                   var headerTable1 = component.get("v.selectedSkillsItems");
                   var ListOfRecords = [];
                
                   var i = 0;
                   for( i ;i< allValues.length;i++){
                     
                       var j = 0;
                       var Records = [];
                      
                       for( j ;j< headerTable1.length;j++){
                         
                           Records.push(allValues[i].sObj[headerTable1[j]]);
                       }  
                        if(component.get("v.manageCheackBoxState").includes(allValues[i].sObj.Id)){
                            ListOfRecords.push({"id": allValues[i].sObj.Id, "isSelected": true, "rec" : Records});
                        }else{
                            ListOfRecords.push({"id": allValues[i].sObj.Id, "isSelected": false, "rec" : Records});
                        }

                       //ListOfRecords.push({"id": allValues[i].sObj.Id, "isSelected": true, "rec" : Records});
                       if(i == 0) {         
                           component.set("v.firstId",allValues[i].sObj.Id);
                       }
                       component.set("v.lastId",allValues[i].sObj.Id);
                   }
                   console.log('ListOfRecords   = ',ListOfRecords);
                   //this.sort();
                   component.set("v.PaginationList",ListOfRecords);
                    
                        if(buttonVal == 'previous') {
                            console.log("tetete");
                            var fieldName = 'Id' ;
                            var sortDirection = 'asc'
                            //var data = component.get("v.PaginationList");
                            var reverse = sortDirection !== 'desc';
                            //sorts the rows based on the column header that's clicked
                           // PaginationLst1.sort(this.sortBy(fieldName, reverse))
                            //component.set("v.PaginationList", PaginationLst1);
                          
                        }
                        
                       
                        
                    //}
                    console.log("tetete==PaginationLst==ooooo",PaginationLst1);
                    // component.set("v.firstId",PaginationLst1[0].Id);
                    // component.set("v.lastId",PaginationLst1[5].Id);
                    if(buttonVal == 'previous') {
                        console.log("tetete");
                        var fieldName = 'Id' ;
                        var sortDirection = 'desc';
                        //var data = component.get("v.PaginationList");
                        var reverse = sortDirection !== 'asc';
                        console.log("==reverse==",reverse);
                        //sorts the rows based on the column header that's clicked
                       // PaginationLst1.sort(this.sortBy(fieldName, reverse))
                        //component.set("v.PaginationList", PaginationLst1);
                      
                    }
                    console.log("tetete==PaginationLst==",PaginationLst1); 
                    console.log('=firstId==',component.get("v.firstId"));
                    console.log('=lastId==',component.get("v.lastId"));
                   
                }
               
            }
           
        });
        $A.enqueueAction(action);
        
    },


    selectAllCheckbox : function(component, event) {
        var selectedHeaderCheck = component.get("v.masterCheckBox");
        console.log('==selectedHeaderCheck==',selectedHeaderCheck);
        var updatedAllRecords = [];
        var updatedPaginationList = [];
        var PaginationList = component.get("v.PaginationList"); 
        var cheackBoxState = component.get("v.manageCheackBoxState");
        if(cheackBoxState == null){
            cheackBoxState = [];
        }
        for (var i = 0; i < PaginationList.length; i++) {
            if (selectedHeaderCheck == true) {
                PaginationList[i].isSelected = true;
                
                cheackBoxState.push(PaginationList[i].id);
            } else {
                PaginationList[i].isSelected = false;
            }
            
            updatedPaginationList.push(PaginationList[i]);
        }
        console.log("==cheackBoxState==",cheackBoxState);
        component.set("v.manageCheackBoxState",cheackBoxState);
        console.log("==manageCheackBoxState==",component.get("v.manageCheackBoxState"));
        component.set("v.selectedCount", PaginationList.length);
        component.set("v.PaginationList", updatedPaginationList);

    },

    checkboxSelect : function(component, event) {
        var selectedRec = event.getSource().get("v.value");
        console.log('==selectedRec==',selectedRec);
            
        var getSelectedNumber = component.get("v.selectedCount");
        if (selectedRec == true) {
            var selectedRec1 = event.getSource().get("v.text");
            console.log('==selectedRec@1122==',selectedRec1);
            var cheackBoxState = component.get("v.manageCheackBoxState");
            if(cheackBoxState == null){
                cheackBoxState = [];
            }
            cheackBoxState.push(selectedRec1);
            component.set("v.manageCheackBoxState",cheackBoxState);
     
            console.log("chechch==",component.get("v.manageCheackBoxState"));
            getSelectedNumber++;
            console.log("==selectedRec111=",component.get("v.PaginationList"));
        } else {
            getSelectedNumber--;
            //component.find("selectAllId").set("v.value", false);
            component.set("v.masterCheckBox",false);
        }
        component.set("v.selectedCount", getSelectedNumber);
        if (getSelectedNumber == component.get("v.pageSize")) {   
            component.set("v.masterCheckBox",true);
            var cheackBoxState = component.get("v.manageCheackBoxState");
            var PaginationListForAllSel = component.get("v.PaginationList");
            if(cheackBoxState == null){
                cheackBoxState = [];
            }
            cheackBoxState.push(PaginationListForAllSel);
            component.set("v.manageCheackBoxState",cheackBoxState);
     
        }
    },
   
    sortData: function (component, fieldName, sortDirection) { 
        var data = component.get("v.PaginationList");
        console.log("==data==",data[0].objAccount);
        var reverse = sortDirection !== 'asc';
        //sorts the rows based on the column header that's clicked
        data.sort(this.sortBy(fieldName, reverse))
        component.set("v.PaginationList", data);
    },
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
            function(x) {return x[field]};
        //checks if the two rows should switch places
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
        //console.log
    },

    sort : function(component, event){
        var previousSortField = component.get("v.sortField");
        console.log('==previousSortField==',previousSortField);
        var currentSortField = event.currentTarget.dataset.field;
        console.log('==currentSortField==',currentSortField);
		component.set("v.sortField", currentSortField);
		if(previousSortField == currentSortField){
			this.sortDirection(component, event);
			this.sortingByJs(component, component.get("v.PaginationList"), currentSortField, component.get("v.sortDirection"));
		}else{
            component.set("v.sortDirection", 'ASC');
            console.log('comememe');
			this.sortingByJs(component, component.get("v.PaginationList"), currentSortField, component.get("v.sortDirection"));
		}
		
	},

	sortingByJs : function(component, records, sortField, sortDirection){
		var records = records.sort((a, b) => (a[sortField] > b[sortField]) ? 1 : -1);
		component.set("v.PaginationList", records);
	},

	
	sortDirection : function(component, event){
		var sortDirection = component.get("v.sortDirection");
		sortDirection = sortDirection == 'ASC' ? 'DESC' : 'ASC';
		component.set("v.sortDirection", sortDirection);
	}
})