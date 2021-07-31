({
    NavigatetoBubl : function(component, event, helper) {

        // var evt = $A.get("e.force:navigateToComponent");
        // console.log("==evt===",evt);
        // evt.setParams({
        //     componentDef : "c:ProductAllRecordCmd",
        //     componentAttributes: {
        //         booleanBulbCard : "true"
        //     }
        // });
        // evt.fire();
        console.log("hello");
        var navService = component.find("navService");
        console.log("==navService==",navService);
        // var pageReference = {
        //                     "type": "standard__component",
        //                     "attributes": {
        //                                     "componentName": "c__ProductAllRecordCmd"
        //                                   }, 
        //                     "state": {
        //                         "c__booleanBulbCard":"true"
        //                     }
        //                    };


                           var pageReference = {
            
                            "type": "standard__component",
                            "attributes": {
                                "componentName": "c__ProductAllRecordCmd"    
                            },    
                            "state": {
                                "c__booleanBulbCard": "true"     
                            }
                        };
        navService.navigate(pageReference);
        
       
    },

    // NavigatetoShoes : function(component, event, helper) {

    //     var evt = $A.get("e.force:navigateToComponent");
    //     console.log("==evt===",evt);
    //     evt.setParams({
    //         componentDef : "c:ProductAllRecordCmd",
    //         componentAttributes: {
    //             booleanShoesCard : "true"
    //         }
    //     });
    //     evt.fire();

    // },

    // NavigatetoTshirt : function(component, event, helper) {

    //     var evt = $A.get("e.force:navigateToComponent");
    //     console.log("==evt===",evt);
    //     evt.setParams({
    //         componentDef : "c:ProductAllRecordCmd",
    //         componentAttributes: {
    //             booleanTshirtCard : "true"
    //         }
    //     });
    //     evt.fire();

    // }
})