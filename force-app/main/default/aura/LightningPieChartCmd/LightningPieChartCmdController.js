({
    afterScriptsLoaded : function(component, event, helper)  {
    
        //helper.doInit(component,event,helper);
        //doInit : function(component, event, helper) {
            var action = component.get("c.fetchAllObject");
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {           
                    var allValues = response.getReturnValue();
                    component.set("v.pickl", allValues);
                }        	         
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                     errors[0].message);
                        }
                    } 
                    else {
                        console.log("Unknown Error");
                    }
                }
            });
            $A.enqueueAction(action);
        },
        
        doSearch : function(component, event, helper) {

            var dynamicChildLst1 ='';
            var action2 = component.get('c.fetchChildOfObject');
            action2.setParams({
                "selectedObject": component.get('v.selectedValue')
            });
         
            action2.setCallback(this, function(response) {
                var state = response.getState();
                if (state == "SUCCESS") {
                    var dynamicChildLst = response.getReturnValue();
                    console.log("==dynamicChildLst==",dynamicChildLst);
                    dynamicChildLst1 = dynamicChildLst;
                    component.set("v.dynamicChildLst", dynamicChildLst);
                }
            });
           
            var pickselected = component.find("selectid").get("v.value");
            console.log('pickselected--->' + pickselected);
            component.set('v.selectedValue', pickselected);
            var selected = component.get('v.selectedValue');
            console.log('Selected--->' + selected);
            var action = component.get("c.fetchChildObj");
            action.setParams({selectedObject : selected});
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {           
                    var allValues = response.getReturnValue();
                   // console.log('allValues--->' + JSON.stringify(allValues)); 
                    component.set("v.mydata", allValues);
                    var data = component.get("v.mydata");
                    var mydatalist = [];
                   // console.log(data);
                   // console.log("===console.log(data);==",component.get("v.dynamicChildLst"));
                    var mydatalist1 = component.get("v.dynamicChildLst");
                    //var mydatalist1 = component.get("v.dynamicChildLst");
                    console.log("==mydatalist1===",mydatalist1);
                   // console.log("==mydatalist1==",mydatalist1);
                    //for(var i in allValues){ 
                    
                    //var1:'somevalue'
                    //data.newAttribute = 'newvalue' var 
                    var array1 = [500,1];
                    var array2 = [500,2];
                    var array3 = [500,8];
                    var array4 = [800,4];
                    var array5 = [100,6];
                    for (var i=0; i<allValues.length; i++ ){
                        //console.log("==alllvava==@==",allValues[i]);
                        var subArray = allValues[i];
                        var data = {};
                        //console.log("==mydatalist1==@mydatalist1==",Object.keys(subArray).length);
                        //console.log("==@@@==dynamicChildLst1==@==",allValues[0].dynamicChildLst1[10]);
                       // for (var j=0; j<Object.keys(subArray).length; j++){
                      // for (var [key, value] of Object.entries(subArray)) { 
                        for(var key in subArray) {
                            if ( key != 'Id' && key != 'Name' ) {
                                var markers = [];
                                console.log("==keyey==second loop==",key);
                                Object.defineProperty(data, key, {
                                    value : subArray[key].length,
                                    configurable: true
                                });
                                mydatalist.push(data);
                                for( var allKey in dynamicChildLst1) {
                                    //console.log("===allkey==three loop===",dynamicChildLst1[allKey]);
                                    //console.log("===allKey==",dynamicChildLst1[allKey]);
                                    if( key == dynamicChildLst1[allKey]) {
                                       // console.log("===vv==",subArray[key].length);
                                        // markers[key] = value.length;
                                        // key = markers[key];
                                       
                                       // mydatalist.push(array);
                                    }
                                    console.log("==keekek==",key);
                                }
                                // if (subArray.hasOwnProperty(key)) {
                                //     console.log("===asas==",key,subArray[key]);
                                // }
                            }
                            console.log("===@@vv@@==",markers);
                            // if ( key != 'Id' && key != 'Name' ) { 
                            //     console.log("check the if condtion",value.length);
                            //     //if( key)
                            //     //mydatalist.key = value.length;
                            //    // data.addAttribute(key,value);
                            //     Object.defineProperty(data, key, {
                            //         value: value.length,
                            //         configurable: true
                            //       });
                            //     //data.key = value
                            //     mydatalist.push(data);
                            //     //mydatalist.push(value.length);
                            //     console.log("=@==myDataList=@@@=",mydatalist); 
                            // }
                            
                            //     var propertyName = Object.getOwnPropertyNames(subArray); 
                            //     console.log("===",key, value); 
                            //     console.log("111222==223=",propertyName.hasOwnProperty(key));  
                                // if (subArray.hasOwnProperty(key)) {

                                // }
                                //console.log("==@==2=",Object.getOwnPropertyNames(subArray));
                        // for(var j in dynamicChildLst1){ 
                        //     console.log("@@@==dynamicChildLst1==@==",allValues[i].dynamicChildLst1[j] != '');
                        //     if(allValues[i].dynamicChildLst1[j] != '') {
                        //         console.log("@@@==@@@1==@==");
                        //         //console.log("==alllvava==@==",allValues[i].Accounts__r);
                        //        // mydatalist.push(allValues[i].dynamicChildLst1[j].length); 
                        //    }
                        // }
                        }
                       
                        
                    }
                    // mydatalist.push(array1);
                    // mydatalist.push(array2);
                    // mydatalist.push(array3);
                    // mydatalist.push(array4);
                    // mydatalist.push(array5);
                    console.log("=@==myDataList==",mydatalist); 
                    helper.piechart(component,event,helper,mydatalist);
                }        	         
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                     errors[0].message);
                        }
                    } 
                    else {
                        console.log("Unknown Error");
                    }
                }
            });

            $A.enqueueAction(action2);
            $A.enqueueAction(action);
        }

       
   // }    
    
})