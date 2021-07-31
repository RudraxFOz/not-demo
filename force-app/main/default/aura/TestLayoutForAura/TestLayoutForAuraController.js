({
	handleClick : function(component, event, helper) {
        
        var x = document.getElementById("input12");
        console.log('==x=='+x.name); 
        console.log('==x=='+x.value); 
        console.log("value: " + event.getSource().get("v.value"));
    	console.log("name: " + event.getSource().get("v.name"));  
        var toMail = component.find("someId").get("v.value");   	
        console.log('==toMail=='+toMail);
        console.log('==toMail==tt=='+component.find("someId").get("v.name"));
        
        console.log("cmp.getElements(): ", component.getElements());
        // access the DOM in c:domLocker
        console.log("div1: ", component.find("div1").getElement());
        console.log("button1: ", component.find("button1"));
		
	},
    
    handleClick1 : function(component, event, helper) { 
        
        //console.log('==x==event.target.value;=='+event.target.Name); 
        console.log("value: " + event.getSource().get("v.value"));
    	console.log("name: " + event.getSource().get("v.name"));
    },
    
    handleFocus: function (cmp, event) {
        console.log('Input Seven has recieved the focus.');
    },
    handleBlur: function (cmp, event) {
        console.log('released the focus.');
    },
    
    callDynmicCmd1 : function(component, event, helper) {
        $A.createComponent('c:ModalPopup', {
            title: 'Please enter your name',
             
        }, function attachModal(modalCmp, status) {
            if (component.isValid() && status === 'SUCCESS') {
                var body = component.get("v.body");
                body.push(modalCmp);
                component.set("v.body", body);    
            }
        });
    },
    
    callDynmicCmd : function(component, event, helper) {
        $A.createComponent(
            "lightning:button",
            {
                "aura:id" : "DyanamicId",
                "label"   : "Destroy Me",
                "onclick" : component.getReference("c.DestroyMe")
            },
            "lightning:button",
            {
                "aura:id" : "DyanamicId1",
                "label"   : "Destroy Me1",
                "onclick" : component.getReference("c.DestroyMe1")
            },
            function(newButton, newButton1, status, errorMessage){
                if(status == "SUCCESS") {
                    var body = component.get("v.body");
                    body.push(newButton);
                    body.push(newButton1);
                    component.set("v.body",body);
                    
                } else if(status === "ERROR") {
                    console.log("==Test is come=="+errorMessage);
                }
            }
        )
    },
    
    DestroyMe : function(cmp) {
        // Find the button by the aura:id value
        //console.log("button: " + cmp.find("UniqueAuraId"));
        var comp = cmp.find("DyanamicId")
        comp.destroy();
        //cmp.set("v.IsBottonVisible", false);
    }
})