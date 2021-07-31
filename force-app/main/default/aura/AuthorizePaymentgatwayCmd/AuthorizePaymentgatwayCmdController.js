({

    doInit: function( component, event, helper ) {
        var yearF = 2018;
        var url = $A.get('$Resource.StaticForLoginBackgourd');
        component.set('v.backgroundImageURL', url);
        var rowItemList = component.get("v.AccList");
        // var a = JSON.stringify(rowItemList);
        // console.log('a - ',a);
        // var arr_from_json = JSON.parse( a );
        var clonedAcc = [];
        
        for(var i=1; i<=60; i++) {
            yearF = yearF + 1 ;
            clonedAcc.push(yearF);
            //component.set("v.yearForCard",yearF);
        }
        component.set("v.yearForCard",clonedAcc); 
    },
    
    CheckNumberForAmt : function(component, event, helper) {
        console.log("-----");
        // var amtPay = component.get("v.amtForPay");
        // console.log("--amtPay---",amtPay);
        // var onlyNumber = [1,2,3,4,5,6,7,8,9,0];
        // for (var i = 1; i<onlyNumber.length; i++) {
        //     if( onlyNumber[i] === amtPay ) {

        //     } else {
        //         console.log("enter numbr only");
        //     }
        // }

        var amtPay = component.get("v.amtForPay");
        var inputRGEX = /^[a-zA-Z0-9]*$/;
        var inputResult = inputRGEX.test(amtPay);
          if(!(inputResult))
          {     
            component.get("v.amtForPay",inputResult.replace(/[^a-z0-9\s]/gi, ''));
            //this.value = this.value.replace(/[^a-z0-9\s]/gi, '');
          }



    },

    CheckLength : function(component, event, helper) {
        //NOT(REGEX( Custom_Phone__c, "[0-9+\\-\\(\\)\\s]*"));
        var val = component.find("number").get('v.value');
        var comp = component.find("number");
        if(val.length > 16){
            var comp = component.find("number");
            comp.set('v.value',val.substring(0,16)); 
            component.set("v.sizeOfCard",16);
        }
    },

    CheckLengthForCvv : function(component, event, helper) {
        var val = component.find("numberForCvv").get('v.value');
        if(val.length > 3){
            var comp = component.find("numberForCvv");
            comp.set('v.value',val.substring(0,3)); 
            component.set("v.sizeOfCvv",3);
        }


        var sizeCvv = component.get("v.sizeOfCvv");
        var sizeCard = component.get("v.sizeOfCard");
        if ( sizeCvv == 3 && sizeCard == 16 ) {
            component.set("v.disableButton",false);
        }
    },

    inputLimiter: function(component, event) {
        var allow = component.get("v.cardNumber");
        //var searchInput = component.find("searchInput");
        //var searchValue = searchInput.get("v.value");
        console.log("====",allow.size);
        // var AllowableCharacters = '';
        // if (allow == 'Letters'){AllowableCharacters=' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';}
        //if (searchValue == 'Numbers'){AllowableCharacters='1234567890';}
       // console.log("====",AllowableCharacters);
        // if (allow == 'NameCharacters'){AllowableCharacters=' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-.\'';}
        // if (allow == 'NameCharactersAndNumbers'){AllowableCharacters='1234567890 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-\'';}
        // if (allow == 'Currency'){AllowableCharacters='1234567890.';}

        // var k = document.all?parseInt(event.keyCode): parseInt(event.which);
        // if (k!=13 && k!=8 && k!=0){
        //     if ((event.ctrlKey==false) && (event.altKey==false)) {
        //     return (AllowableCharacters.indexOf(String.fromCharCode(k))!=-1);
        //     } else {
        //     return true;
        //     }
        // } else {
        //     return true;
        // }
        var sizeCvv = component.get("v.sizeOfCvv");
        var sizeCard = component.get("v.sizeOfCard");
        if ( sizeCvv === 3 && sizeCard === 16 ) {
            component.set("v.disableButton",false);
        }
    } ,

    handleError : function(component, event){
        /* do any custom error handling
         * logic desired here */
        // get v.errors, which is an Object[]
        var errorsArr  = event.getParam("errors");
        console.log("error ======",errorsArr );
        for (var i = 0; i < errorsArr.length; i++) {
            console.log("error " + i + ": " + JSON.stringify(errorsArr[i]));
        }
    },

    handleClearError : function(component, event) {

        /* do any custom error handling
         * logic desired here */
    },

    selectMonth : function(component, event) {
        var sMonth = component.find("selectM").get("v.value");
        console.log("sMonth====",sMonth);
    },

    selectYear : function(component, event) {
        var sYear = component.find("selectY").get("v.value");
        console.log("sYear====",sYear);
    },

    cheackPayment : function(component, event, helper) {
        var sMonth = component.find("selectM").get("v.value");
        console.log("sMonth====",sMonth);
        var sYear = component.find("selectY").get("v.value");
        console.log("sYear====",sYear); 
        var cardNumber = component.get("v.cardNumber");
        var cvvNumber = component.get("v.ccvNumber");
        var amtPay = component.get("v.amtForPay");
        console.log(cardNumber.length);
        console.log(cvvNumber.length);
        console.log(sMonth.length > 0 );
        if (cardNumber.length > 12 && cvvNumber.length === 3 &&  sMonth !== 'None' && sYear !== 'None' && amtPay.length > 0) {
            helper.cheackPaymentHelper( component, event, sMonth, sYear );
            
        } else  {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Please Fill Deatils!",
                "message": "Enter the Full Detials",
                "key": 'info_alt',
                "type": 'warning'
            });
            toastEvent.fire();
        }
        //helper.getAccountList( component, pageNumber, pageSize );
    }
})