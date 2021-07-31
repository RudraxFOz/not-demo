({
    doInit : function(component, event, helper) {
		var action = component.get('c.fetchParentRecords');
		action.setCallback(this, function(response){
			if(response.getState() === "SUCCESS") {
                //console.log('parent products : ',JSON.stringify(response.getReturnValue()));
               	component.set('v.parentProducts',response.getReturnValue());
            }
            else{
                console.log("failed with state : "+state);
            }
		});
		$A.enqueueAction(action);
    },
    
	navigateToChildProducts : function(component, event, helper) {
		console.log("@@@@",event.getSource().get('v.name'));
		console.log("@@@@",event.getSource().get('v.value'));
	    var pageReference = {
	    	type : 'standard__component',
	    	attributes : {
	    		componentName : 'c__ProductAllRecordCmd1',
	    	},
	    	state : {
	    		'c__parentRecordName' : event.getSource().get('v.name'),
	    		'c__parentRecordId' : event.getSource().get('v.value')
	    	}
	    };
	    //component.set('v.pageReference',pageReference);
		var navService = component.find("navService");
	    navService.navigate(pageReference);
	}
})