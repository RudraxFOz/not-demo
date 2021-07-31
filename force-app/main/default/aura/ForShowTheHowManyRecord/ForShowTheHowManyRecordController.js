({
        doInit: function(component, event, helper) {
            var pageNumber = component.get("v.PageNumber");  
            var pageSize = component.find("pageSize").get("v.value"); 
            helper.getAccountList(component, pageNumber, pageSize);
        },
         
        handleNext: function(component, event, helper) {
            var pageNumber = component.get("v.PageNumber");  
            var pageSize = component.find("pageSize").get("v.value");
            pageNumber++;
            helper.getAccountList(component, pageNumber, pageSize);
        },
         
        handlePrev: function(component, event, helper) {
            var pageNumber = component.get("v.PageNumber");  
            var pageSize = component.find("pageSize").get("v.value");
            pageNumber--;
            helper.getAccountList(component, pageNumber, pageSize);
        },
         
        onSelectChange: function(component, event, helper) {
            var page = 1
            var pageSize = component.find("pageSize").get("v.value");
            helper.getAccountList(component, page, pageSize);
        },

    
})