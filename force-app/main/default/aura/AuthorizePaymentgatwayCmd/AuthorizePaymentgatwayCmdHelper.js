({
    cheackPaymentHelper : function(component, event, sMonth, sYear) {

        var action = component.get("c.authorizeCard");
        action.setParams({
            "cardNum": component.get("v.cardNumber"),
            "cvvCode": component.get("v.ccvNumber"),
            "selectMc": component.find("selectM").get("v.value"),
            "selectYc": component.find("selectY").get("v.value"),
            "APIkey": "8zQYF7f7r",
            "transKey": "9nEp79YN59sxa2qW",
            "Amt": component.get("v.amtForPay")
        });
        action.setCallback(this, function(response) {
            var states = response.getReturnValue();
            console.log("====",states); 
            console.log("====",JSON.stringify(states));
            console.log("==cvvResultCode===",states.transactionResponse.cvvResultCode);
            if ( states.transactionResponse.cvvResultCode === "P" ) {
                var stateCode = states.transactionResponse.messages[0].code;
                var stateText = states.transactionResponse.messages[0].description;
                if ( stateCode == 1 ) {
                    // var toastEvent = $A.get("e.force:showToast");
                    // toastEvent.setParams({
                    //     "title": "Success!",
                    //     "message": stateText,
                    //     "key": 'info_alt',
                    //     "type": 'success'
                    // });
                    // toastEvent.fire();
                    this.showToastForSucc(component, event, helper, stateText);
                }
            } else if ( states.transactionResponse.cvvResultCode === "" &&  states.transactionResponse.errors.length > 0 ) {
                console.log("====787");
                if ( states.transactionResponse.errors.length === 2 ) {
                    console.log("566====787");
                    var errorStateCode1 = states.transactionResponse.errors[1].errorCode;
                    var errorStateText1 =  states.transactionResponse.errors[1].errorText;
                    if ( errorStateCode1 == 8 ) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "!Invalid",
                            "message": errorStateText1,
                            "key": 'info_alt',
                            "type": 'error'  
                        });
                        toastEvent.fire();
                    } else if ( errorStateCode1 == 11 ) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "!Invalid",
                            "message": errorStateText1,
                            "key": 'info_alt',
                            "type": 'error'  
                        });
                        toastEvent.fire();
                    }   

                } else if(  states.transactionResponse.errors.length === 1 ) {
                    console.log("welcome");
                    var errorStateCode1 = states.transactionResponse.errors[0].errorCode; 
                    var errorStateText1 =  states.transactionResponse.errors[0].errorText;
                    if ( errorStateCode1 === 6 ) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "!Invalid",
                            "message": errorStateText1,
                            "key": 'info_alt',
                            "type": 'error'  
                        });
                        toastEvent.fire(); 
                    } else if ( errorStateCode1 == 11 ) {
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "!Invalid", 
                                "message": errorStateText1,
                                "key": 'info_alt',
                                "type": 'error'  
                            });
                            toastEvent.fire();
                    } else if ( errorStateCode1 == 8 ) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "!Invalid",
                            "message": errorStateText1,
                            "key": 'info_alt',
                            "type": 'error'  
                        });
                        toastEvent.fire(); 
                    } else if ( errorStateCode1 == 17 ) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "!Invalid",
                            "message": errorStateText1,
                            "key": 'info_alt',
                            "type": 'error'  
                        });
                        toastEvent.fire();
                    } else if ( errorStateCode1 == 49 ) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "!Invalid",
                            "message": errorStateText1,
                            "key": 'info_alt',
                            "type": 'error'  
                        });
                        toastEvent.fire();
                    } else if ( errorStateCode1 == 5 ) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            "title": "!Invalid",
                            "message": errorStateText1,
                            "key": 'info_alt',
                            "type": 'error'  
                        });
                        toastEvent.fire();
                    } 
                } else if ( states.transactionResponse.messages.length === 1 ) {
                    console.log("last else");
                }
            } else if( states.transactionResponse.cvvResultCode === "M" ) {
                var stateCode = states.transactionResponse.messages[0].code;
                var stateText = states.transactionResponse.messages[0].description;
                // var toastEvent = $A.get("e.force:showToast");
                // toastEvent.setParams({
                //     "title": "Success!",
                //     "message": stateText,
                //     "key": 'info_alt',
                //     "type": 'success'
                // });
                // toastEvent.fire();
                this.showToastForSucc(component, event, helper, stateText);
            } else if( states.transactionResponse.cvvResultCode === "N" ) {
                var errorStateCode1 = states.transactionResponse.errors[0].errorCode;
                var errorStateText1 =  states.transactionResponse.errors[0].errorText;
                if ( errorStateCode1 === 65 ) {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "!Invalid",
                        "message": errorStateText1,
                        "key": 'info_alt',
                        "type": 'error'  
                    });
                    toastEvent.fire(); 
                }
            } else if( states.transactionResponse.cvvResultCode === "U" ) { 
                var stateCode = states.transactionResponse.messages[0].code;
                var stateText = states.transactionResponse.messages[0].description;
                if ( stateCode == 1 ) {
                    // var toastEvent = $A.get("e.force:showToast");
                    // toastEvent.setParams({
                    //     "title": "Success!",
                    //     "message": stateText,
                    //     "key": 'info_alt',
                    //     "type": 'success'
                    // });
                    // toastEvent.fire();
                    this.showToastForSucc(component, event, helper, stateText);
                }
            } else if( states.transactionResponse.cvvResultCode === "S" ) { 
                var stateCode = states.transactionResponse.messages[0].code;
                var stateText = states.transactionResponse.messages[0].description;
                // if ( stateCode == 1 ) {
                //     var toastEvent = $A.get("e.force:showToast");
                //     toastEvent.setParams({
                //         "title": "Success!",
                //         "message": stateText,
                //         "key": 'info_alt',
                //         "type": 'success'
                //     });
                //     toastEvent.fire();
                // }
                helper.showToastForSucc(component, event, helper, stateText);
            } else if ( states.transactionResponse.cvvResultCode === "" ) {
                console.log("bvbvbvb");

            }
            component.set("v.cardNumber","");
            component.set("v.ccvNumber",""); 
            component.set("v.amtForPay",""); 
            //component.set("v.monthForCard","Month");
            //component.set("v.yearForCard","Year");
        }); 
        $A.enqueueAction(action);
    },

    showToastForSucc : function (component, event, helper, stateText) {
        console.log("--=-=-==");
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": stateText,
            "key": 'info_alt',
            "type": 'success'
        });
        toastEvent.fire();
    }
})