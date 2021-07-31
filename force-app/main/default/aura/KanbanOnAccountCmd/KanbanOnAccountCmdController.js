({
    doInit: function(component, event, helper) {
        console.log("heello");
        var action = component.get("c.getKanbanAccList");
        action.setCallback(this, function(response){
            var state = response.getState();
            var demo = response.getReturnValue();
            console.log("---demo----",demo);
            console.log("---state----",state);
            if (state === "SUCCESS") {
                component.set("v.accList", response.getReturnValue());
                console.log("---accList----",component.get("v.accList"));  
            }
        });
        $A.enqueueAction(action);
    },

    
    allowDrop: function(component, event, helper) {
        event.preventDefault();
    },
    
    drag: function (component, event, helper) {
        console.log("helllllllll",event.target.id);
       // event.dataTransfer.setData("text", event.target.id);
       var parentId = document.getElementById(event.target.id).parentElement.id;
       console.log("helllllllll@@@",parentId);
       component.set("v.startId",event.target.id);
       component.set("v.parentId",parentId);
    },
    
    drop: function (component, event, helper) {
        // console.log("@@@@helllllllll");
        // event.preventDefault();
        // var data = event.dataTransfer.getData("text");
        // console.log("@@@@helllllllll",data);
        // var idOfCurrentCom = event.currentTarget;
        // console.log("@@@@idOfCurrentCom",document.getElementById(data));
        // idOfCurrentCom.appendChild(document.getElementById(data));
        // helper.updatePickVal(component,data,component.get("v.kanbanPicklistField"),idOfCurrentCom.getAttribute('data-Pick-Val'));

        var drag = component.get("v.startId");
        console.log("@@@@helllllllll@@@",drag);
        var div = event.target.id;
        var fragment = document.createDocumentFragment();
        console.log("@@@@fragment@@@",drag);
        fragment.appendChild(document.getElementById(drag));
        document.getElementById(div).appendChild(fragment);
        var c = document.getElementById(div).children;
        console.log("@@@@fct@@@",c);
        var x = document.getElementById('drag1').parentElement.id;
        console.log("@@@@xxt@@@",x);
        var fragment = document.createDocumentFragment();
        fragment.appendChild(document.getElementById(c[0].id));
        document.getElementById(component.get("v.parentId")).appendChild(fragment);
    }

})