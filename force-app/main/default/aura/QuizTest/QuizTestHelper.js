({
	doInit : function(component, event, helper) {
        var action = component.get('c.fetchSubject');
		action.setCallback(this, function(response){
			if(response.getState() === "SUCCESS") {
                console.log('parent products : '+JSON.stringify(response.getReturnValue()));
                var res = response.getReturnValue() ;
                component.set('v.lstOfSubject',response.getReturnValue());
                var ss = component.get('v.lstOfSubject');
                let button1 = component.find('previousDisable');
                button1.set('v.disabled',true);
                let button2 = component.find('nextDisable');  
                button2.set('v.disabled',true);
                let button3 = component.find('submitDisable');  
                button3.set('v.disabled',true);
            } else {
                console.log("failed with state : "+state);
            }
		});
		$A.enqueueAction(action);
    },

    selectOptionSubjectHelper : function(component, event, helper) {
       
        var demo = component.find("selectSub").get("v.value");
        console.log("hhhh",demo);
        if ( demo == 'Null' ) {
            console.log("check if conditin");
            let button1 = component.find('previousDisable');
            button1.set('v.disabled',true);
            let button2 = component.find('nextDisable');  
            button2.set('v.disabled',true);
            let button3 = component.find('submitDisable');  
            button3.set('v.disabled',true);
        } else {
            let button2 = component.find('nextDisable');  
            button2.set('v.disabled',false);
            let button3 = component.find('submitDisable');  
            button3.set('v.disabled',false);
        }
        var action = component.get('c.getQuestionAnswers');
        action.setParams({
            "subjectName" : component.find("selectSub").get("v.value")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnVal = response.getReturnValue();

                console.log("==returnVal==",returnVal);
                // var finalList = [];
                // for( var i=0; i<returnVal.length; i++ ) {
                //     var answers = returnVal[i].Answer1s__r; 
                //     console.log("answer==",answers); 
                //     for( var j=0; j<answers.length; j++ ) {
                //         answers[j].label = answers[j].Option__c;
                //         answers[j].value = answers[j].Option__c;             
                //     }
                //     finalList.push(returnVal[i]);         
                // }
                component.set("v.questions", returnVal);
                var index = component.get('v.numberForShowQuestion');
                var showQuestion = returnVal[index];
                component.set("v.questionsLst", showQuestion);
                console.log('---------- : '+JSON.stringify(showQuestion));
              /*  console.log("check the response==", component.get("v.questions"));
                var showQuestion = [];
                for( var i=0; i< 1; i++ ) {
                    console.log("iiiii===",i);
                    component.set("v.numberForShowQuestion",i);
                    if( component.get("v.questions").length> i ) {
                        showQuestion.push(response.getReturnValue()[i]);
                    }
                }
                */
                
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
       
    }
})