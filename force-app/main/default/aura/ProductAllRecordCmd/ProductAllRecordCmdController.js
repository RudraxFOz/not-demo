({

    doInit: function( component, event, helper ) {

       // console.log("@@@@",JSON.stringify(component.get("v.pageReference").state));   booleanBulbCard
        var booleanStateaa = component.get("v.pageReference").state.c__booleanBulbCard;
        console.log("!!@@@",JSON.stringify(booleanStateaa));
        component.set("v.booleanBulbCard",booleanStateaa);
    },

    bulbWatt : function(component, event, helper) { 
        // SELECT Id, Name, Product__r.Name FROM Product_Attribute_Value__c WHERE Product_Attribute__r.Name IN ('type','Type') 

    }
})