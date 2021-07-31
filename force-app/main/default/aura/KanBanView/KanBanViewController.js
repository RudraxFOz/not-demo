({
    doInit: function(component, event, helper) {
        
        helper.doInitHelper(component, event);
    },

    onSelectObj : function (component, event, helper) {

        helper.fetchPickListVal(component, 'Name', 'listSkillsOptions');
    },

    handleDualList : function (component, event, helper) {
        var selectedFields = component.get("v.selectedSkillsItems");
        if(selectedFields.length == 0){
            component.set("v.showModelForKanbag",false);
        } else {
            component.set("v.showModelForKanbag",true);
        }
    }
})