({
    doInit : function(component) {
        //console.log('page reference is : '+JSON.stringify(component.get('v.pageReference')));
        //var parentProductId = component.get('v.pageReference').state.c__parentRecordId;
        //var parentProductName = component.get('v.pageReference').state.c__parentRecordName;
        //console.log("===",parentProductName);
        //console.log("===@@@",parentProductId);
        var parentProductId11 = '01t6F00000BLHiPQAX';
        var parentProductName11 = 'T-Shrit';
        component.set('v.parentProductName',parentProductName11);
        component.set('v.parentProductId',parentProductId11);
        var parentProductId1 = component.get('v.parentProductId');
        var parentProductName1 = component.get('v.parentProductName');
        console.log("===",parentProductId1);
        console.log("===@@@",parentProductName1);
        var action = component.get('c.fetchChildRecords');
        action.setParams({
            parentProductID : parentProductId1
        });
        action.setCallback(this, function(response){
            if(response.getState()=='SUCCESS') {
                var demo = response.getReturnValue();
                console.log("hiiiiiiii",JSON.stringify(demo));
                var productAttributes =  [];
                component.set('v.allFetchedRecords',response.getReturnValue());
                for(var product in response.getReturnValue()) {
                    console.log("--product---",product);
                    var contains =  productAttributes.some(w => w.ProductAttributeId === response.getReturnValue()[product].Product_Attribute__c);
                    //console.log("--contains---",contains);
                    //console.log("--!!contains---",!contains);
                    if(! contains) {
                        var val = [];
                        productAttributes.push({
                            ProductAttributeId : response.getReturnValue()[product].Product_Attribute__c,
                            ProductAttributeName : response.getReturnValue()[product].Product_Attribute__r.Name,
                            values : val
                        }); 
                    }
                    console.log("---11productAttributes---",productAttributes);
                }
                console.log("---222productAttributes---",productAttributes);
                
                if(!$A.util.isEmpty(productAttributes)) { 
                    for(var product in response.getReturnValue()) {
                        var index = productAttributes.findIndex(x => x.ProductAttributeId ===response.getReturnValue()[product].Product_Attribute__c);
                        console.log("---index--",index);
                        var productAttr = productAttributes[index].values;
                        var attrval = response.getReturnValue()[product].Value__c.toUpperCase();
                        if(!$A.util.isEmpty(productAttr)) {
                            if(!productAttr.includes(attrval)) {
                                productAttr.push(attrval);
                            }
                        } 
                        else {
                            productAttr.push(attrval);
                        }
                        productAttributes[index].values = productAttr;
                    }
                    console.log("---productAttributes---",productAttributes);
                    component.set('v.productAttributes',productAttributes); 
                }
                
                var selecedValuesArray = {};
                for(var attr in productAttributes) {
                	selecedValuesArray[productAttributes[attr].ProductAttributeName] = ''
                }
                console.log(' selected values array in init (expected blank) : '+JSON.stringify(selecedValuesArray));
                component.set('v.selectedValues',selecedValuesArray);
                var attrNameArray = Object.keys(component.get('v.selectedValues'));
                console.log(' -- attrNameArray -- ',attrNameArray);
                var cmpbtn = component.find('ltng-btn');
                console.log("---cmpbtn---",cmpbtn);
                cmpbtn.forEach(function(item) {
                    if(attrNameArray[0] != item.get('v.name')) {
                        item.set('v.disabled',true);
                    }
                });
            }
        });
        $A.enqueueAction(action);   
    },

    handleclick : function(component,event) {
    	component.set('v.result','');
        var cmpbtn = component.find('ltng-btn');
        console.log("---cmpbtn---",cmpbtn);
        var prev_attr = component.get('v.previousAttribute');
        console.log("---prev_attr---",prev_attr);
        var selecedValuesArray = {};
        if( ! $A.util.isEmpty(component.get('v.selectedValues')) ) {
            selecedValuesArray = component.get('v.selectedValues');
        }
        
        if(! $A.util.isEmpty(prev_attr) && prev_attr != event.getSource().get('v.name')) {
            var val = selecedValuesArray[prev_attr];
            if(! $A.util.isEmpty(selecedValuesArray) ) {
                cmpbtn.forEach(function(item) {
                    if( prev_attr == item.get('v.name') && val!=item.get('v.label')){
                        item.set('v.disabled','true');
                    }
                });
            }      
        }
        var name = [];
        cmpbtn.forEach(function(item){
            if(! name.includes(item.get('v.name'))) {
                name.push( item.get('v.name') );
            }
        });

        cmpbtn.forEach(function(item) {
            if( event.getSource().get('v.name') == item.get('v.name') ){
                item.set('v.variant','neutral');
            }
        });
        
        event.getSource().set('v.variant','success');
        var values;
        console.log("-=-=-=selecedValuesArray-=-=-",JSON.stringify(selecedValuesArray));
        if( ! $A.util.isEmpty(selecedValuesArray[event.getSource().get('v.name')])) {
            values = selecedValuesArray[event.getSource().get('v.name')];
        }
        values = event.getSource().get('v.label');
        selecedValuesArray[event.getSource().get('v.name')] = values;
        console.log(' ==== selecedValuesArray ===== : '+JSON.stringify(selecedValuesArray));
        component.set('v.selectedValues',selecedValuesArray);
        var allFetchedRecords = component.get('v.allFetchedRecords');
        console.log("----allFetchedRecords---",JSON.stringify(allFetchedRecords));
        var RemainingRecordsParentId = [];
        var lastElement = selecedValuesArray[event.getSource().get('v.name')];
        console.log(' lastElement :: --- ', component.get('v.remainingParentRecords'));
        if( $A.util.isEmpty( component.get('v.remainingParentRecords'))){
            console.log("hello if");
            for(var product in  allFetchedRecords) {
                var val = allFetchedRecords[product].Value__c;
                val = val.toUpperCase();
                if(allFetchedRecords[product].Product_Attribute__r.Name == event.getSource().get('v.name') && val == lastElement) {
                    RemainingRecordsParentId.push(allFetchedRecords[product].Product__c);
                }
            }
        } else {
            console.log("hello else");
            //console.log('length of remaining records : '+component.get('v.remainingParentRecords').length);
            for(var remain_parent in component.get('v.remainingParentRecords')) {
                console.log('entered');
                var val = component.get('v.remainingParentRecords')[remain_parent].Value__c;
                val = val.toUpperCase();
                console.log('val : '+val);
                if(component.get('v.remainingParentRecords')[remain_parent].Product_Attribute__r.Name == event.getSource().get('v.name') && val == lastElement) {
                    RemainingRecordsParentId.push(component.get('v.remainingParentRecords')[remain_parent].Product__c);
                }
            }
        }
        console.log(' RemainingRecordsParentId : '+JSON.stringify(RemainingRecordsParentId));
        var tempArray = [];
        if( $A.util.isEmpty( component.get('v.remainingParentRecords'))){
            for(var product in  allFetchedRecords) {
                if(RemainingRecordsParentId.includes(allFetchedRecords[product].Product__c) && allFetchedRecords[product].Product_Attribute__r.Name != event.getSource().get('v.name')) {
                    tempArray.push(allFetchedRecords[product]);
                }
            }
        } else {      
            console.log(' remaining Parent records : ',JSON.stringify(component.get('v.remainingParentRecords')));
            console.log('remaining parent record id : ',JSON.stringify(RemainingRecordsParentId));
            for(var product in  component.get('v.remainingParentRecords')) {
                if(RemainingRecordsParentId.includes(component.get('v.remainingParentRecords')[product].Product__c) && component.get('v.remainingParentRecords')[product].Product_Attribute__r.Name != event.getSource().get('v.name')) {
                    tempArray.push(component.get('v.remainingParentRecords')[product]);
                }
            }
        }
        console.log(' tempArray : '+JSON.stringify(tempArray));
        if( ! $A.util.isEmpty(tempArray)) {
        	component.set('v.remainingParentRecords',tempArray);
        }
        
        var remainValues = [];
       	if( ! $A.util.isEmpty( component.get('v.remainingParentRecords'))) {
       		for(var product in component.get('v.remainingParentRecords')) {
       			var val = component.get('v.remainingParentRecords')[product].Value__c;
            	val = val.toUpperCase();
            	if(! remainValues.includes(val)){
                    remainValues.push(val);
                }
       		}
       	}
       	var attrNameArray = Object.keys(component.get('v.selectedValues'));
       	var indexOfNextAttr = attrNameArray.indexOf(event.getSource().get('v.name'))+1;
       	console.log('in the end ======Remain Values ==== : '+remainValues);
       	console.log(' attrNameArray[indexOfNextAttr] : '+attrNameArray[indexOfNextAttr]);
       	console.log(' selecedValuesArray[attrNameArray[indexOfNextAttr]] : '+selecedValuesArray[attrNameArray[indexOfNextAttr]]);
       	cmpbtn.forEach(function(item){
            if( remainValues.includes(item.get('v.label')) && ! $A.util.isEmpty(attrNameArray[indexOfNextAttr]) && item.get('v.name') ==  attrNameArray[indexOfNextAttr] && $A.util.isEmpty(selecedValuesArray[attrNameArray[indexOfNextAttr]])) {
                item.set('v.disabled',false);
            } else if((item.get('v.name') == event.getSource().get('v.name') && remainValues.includes(item.get('v.label')))) {	
                item.set('v.disabled',false);
            } else if(item.get('v.variant') == 'success') {
            	item.set('v.disabled',false);
            }else {	
                item.set('v.disabled',true);
            }
        });
        console.log(' remaining Parent records : ',JSON.stringify(component.get('v.remainingParentRecords')));
        component.set('v.previousAttribute',event.getSource().get('v.name'));
    },

   

    resetValues : function(component) {
    	component.set('v.previousAttribute','');
    	component.set('v.result','');
    	var arr = [];
    	var selecedValuesArray = {};
        for(var attr in component.get('v.productAttributes')) {
            selecedValuesArray[component.get('v.productAttributes')[attr].ProductAttributeName] = '';
        }
        console.log(' selected values array in init (expected blank) : '+JSON.stringify(selecedValuesArray));
        component.set('v.selectedValues',selecedValuesArray);
        component.set('v.remainingParentRecords',arr);
        var attrNameArray = Object.keys(component.get('v.selectedValues'));
        console.log(' -- attrNameArray -- ',attrNameArray);
        var cmpbtn = component.find('ltng-btn');
        cmpbtn.forEach(function(item) {
            console.log('item name : ',item.get('v.name'));
            console.log('attrNameArray[0] : ',attrNameArray[0]);
            if(attrNameArray[0] != item.get('v.name')) {
                item.set('v.disabled',true);
            } else {
                item.set('v.disabled',false);
            }
            item.set('v.variant','neutral');
        });
    },

 
    showProductId : function(component) {
    	var flag = 0;
    	for(var data in Object.values(component.get('v.selectedValues'))){
    		if( $A.util.isEmpty( Object.values(component.get('v.selectedValues'))[data] )) {
    			flag = 1;
    			component.set('v.result','Please Select All Attributes');
    			break;
    		} else {

    		}
    	}
    	if(flag == 0) {
    		console.log(' selected Values : ', JSON.stringify(component.get('v.selectedValues')));
    		var remainRecords = component.get('v.remainingParentRecords');
    		console.log(' remainRecords : '+JSON.stringify(remainRecords));
    		if( ! $A.util.isEmpty(remainRecords) ) {
    			var allValues = Object.values(component.get('v.selectedValues'));
    			console.log(' allValues : '+allValues);
    			console.log(' allValues[allValues.length-1] : '+allValues[allValues.length-1]);
    			for(var product in remainRecords) {
    				var val = remainRecords[product].Value__c.toUpperCase();
    				console.log('val : '+val);
    				if(val == allValues[allValues.length-1]) {
    					component.set('v.result',remainRecords[product].Product__c);
    					break;
    				}
    			}
    		}
    	}
    }

})