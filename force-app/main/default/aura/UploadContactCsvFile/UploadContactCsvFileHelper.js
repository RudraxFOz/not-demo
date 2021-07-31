({
    CSV2JSON: function (component, helper, csv) { 
        var csvArray = [];  
        csvArray =  csv.split('\n');;
        var jsonObj = [];
        var headers = csvArray[0].split(',');
        for(var i = 1; i < csvArray.length; i++) {
            var data = csvArray[i].split(',');
            var obj = {};
            for(var j = 0; j < data.length; j++) {
                console.log("---comm---");
                obj[headers[j].trim()] = data[j].trim();
            }
            jsonObj.push(obj);
        }
        var json = JSON.stringify(jsonObj);
        return json;
    },
        
    createContact : function (component, helper, jsonstr){
        var action = component.get("c.insertData");   
        action.setParams({
            "strfromJson" : jsonstr,
            "camaignName" : component.find("inputText").get("v.value"),
            "camaignMemberStatus" : component.find("status").get("v.value")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log('==state==',state);
            if (state === "SUCCESS") {  
                alert("Contact Inserted Succesfully");            
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                    alert('Unknown');
                }
            }
        }); 
        $A.enqueueAction(action);      
    }
})