({
    createNewBoat : function(component, event, helper) {

        var createRecordEvent = $A.get('e.force:createRecord');
        if ( createRecordEvent ) {
            createRecordEvent.setParams({
                'entityApiName': 'Boat__c' 
            });
            createRecordEvent.fire();
        } else {
            /* Create Record Event is not supported */
            alert("Boat creation not supported");
        }

    }
})