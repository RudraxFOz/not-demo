({
    doInit: function(component, event, helper) {
        var opts = [
            { value: "Sent", label: "Sent" },
            { value: "Responded", label: "Responded" } 
        ];
        component.set("v.listOfCamaignStatus", opts);
    },
    createRecord: function (component, event, helper) {
        console.log(component.find("inputText").get("v.value"));
        var fileInput = component.find("file").getElement();
        var file = fileInput.files[0];
        if (file) {
            var reader = new FileReader();
            reader.readAsText(file, "UTF-8");
            reader.onload = function (event) {
                var csv = event.target.result;
                var result = helper.CSV2JSON(component, helper, csv);
                helper.createContact(component, helper, result );   
            }
            reader.onerror = function (event) {
                console.log("error reading file");
            }
        }
    },   
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for display loading spinner 
         component.set("v.Spinner", true); 
    },
     
  // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
      // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
     }
})