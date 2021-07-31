({

    render : function(component, helper) {
        console.log("---entry in render---");

        var ret = this.superRender();
        //component.set("v.IconName",component.get("v.IconName")+"To ");
        var disableDiv = component.find('searchRes');
        disableDiv.set('v.disabled',true); 
        return ret;
    },

    afterRender : function(component, helper){
        console.log("---entry in afterRender---");
        this.superAfterRender();
        component.set("v.IconName",component.get("v.IconName")+"To ");
    },
 
    rerender : function(component, helper){
        console.log("---entry in rerender---");        
        this.superRerender();
        component.set("v.IconName",component.get("v.IconName"));
    },
 
})