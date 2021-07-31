({
	doInit : function(component, event, helper) {
        var action = component.get('c.fetchSubject');
		action.setCallback(this, function(response){
			if(response.getState() === "SUCCESS") {
                var res = response.getReturnValue() ;
                component.set('v.lstOfSubject',response.getReturnValue());
                for( var i=0; i<res.length; i++ ) {
                    var instraction = res[i].Instructions__r; 
                }
                console.log("==instraction==",instraction);
                //instraction.Number_of_questions__c = 11;
                component.set("v.instructionsLst",instraction);
                console.log("==instraction1111==",JSON.stringify(component.get("v.instructionsLst.Total_Time_For_Question__c")));
                $A.util.addClass( component.find('hideShowQuestion'), 'slds-hide');  
                $A.util.addClass(component.find("hideShowAllQuestionAfterSubmit"), 'slds-hide');
                $A.util.addClass( component.find('showScore'), 'slds-hide');
               
            } else {
                console.log("failed with state : "+state);
            }
		});
		$A.enqueueAction(action);
    },

    selectOptionSubjectHelper : function(component, event, helper) {

        var demo = component.find("selectSub").get("v.value");
        if ( demo == 'Null' ) {
            component.find('previousDisable').set('v.disabled',true);
            component.find('nextDisable').set('v.disabled',true);
            component.find('submitDisable').set('v.disabled',true);
        } else {
            component.find('nextDisable').set('v.disabled',false);
            component.find('submitDisable').set('v.disabled',false);
        }
        var action = component.get('c.getQuestionAnswers');
        action.setParams({
            "subjectName" : component.find("selectSub").get("v.value")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var returnVal = response.getReturnValue();
                var finalList = [];
                for( var i=0; i<returnVal.length; i++ ) {
                    var answers = returnVal[i].Answer1s__r; 
                    for( var j=0; j<answers.length; j++ ) {
                        answers[j].label = answers[j].Option__c;
                        answers[j].value = answers[j].Option__c;             
                    }
                    returnVal[i].yourAnswer = '';
                    returnVal[i].yourAnswerCheckBox = '';
                    returnVal[i].correctAnswer = '';  
                    returnVal[i].correctAnswerCheckbox = '';   
                    returnVal[i].variable2 = false;
                    returnVal[i].allChechboxTrue = ''; 
                    returnVal[i].checkboxFalse = ''; 
                    finalList.push(returnVal[i]);         
                }
                component.set("v.questions", finalList);
                component.set("v.lengthOfQuestion", component.get("v.questions").length)
                component.set("v.questions1", finalList);
                var index = component.get('v.numberForShowQuestion');
                component.set("v.questionsLst", returnVal[index]);   
                $A.util.addClass(component.find('hideSubject'), 'slds-hide');
                $A.util.removeClass(component.find('hideShowQuestion'), 'slds-hide');
                $A.util.addClass(component.find('hideShowQuestion'), 'slds-show');
                component.set("v.totalSecond",component.get("v.instructionsLst.Total_Time_For_Question__c"));
                this.callSetInterval(component, event, helper);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
       
    },

    callSetInterval : function (component, event, helper) {
        var hoursLabel =document.getElementById("hours");
        var minutesLabel = document.getElementById("minutes");
        var secondsLabel = document.getElementById("seconds");
        
        var my_int = setInterval(function(){ helper.setTime(component, helper, hoursLabel, minutesLabel, secondsLabel)}, 1000);
        //console.log("==my_int==",my_int);
        component.set("v.my_int",my_int);
    },

    setTime : function(component, helper, hoursLabel, minutesLabel, secondsLabel) {
       
        // console.log("==hoursLabel==",hoursLabel);
        // console.log("==minutesLabel==",minutesLabel);
        // console.log("==secondsLabel==",secondsLabel);
        
        var totalSecond = component.get("v.totalSecond");
        if(totalSecond == 0 ) {
            this.submitAllQuestion(component, event, helper);
        }
        totalSecond--;
        //console.log("totalSeconds==",totalSecond);
        component.set("v.totalSecond",totalSecond);
        secondsLabel.innerHTML = this.pad(totalSecond%60);
        minutesLabel.innerHTML = this.pad(parseInt(totalSecond/60));
        hoursLabel.innerHTML = this.pad(parseInt(totalSecond/60/60));
    },


    pad : function(val) {
        // if(val == 00 ) {
        //     this.submitAllQuestion(component, event, helper);
        // }
        //console.log("==val==",val);
        var valString = val + "";
        //console.log("==valString.length==",valString.length);
        if(valString.length < 2) {
            return "0" + valString;
        } else {
            return valString;
        }
    },

    stop_timer : function(component, event, helper) {
        var hoursLabel =document.getElementById("hours");
        component.set("v.hoursLabel",hoursLabel.innerHTML);
        var minutesLabel = document.getElementById("minutes");
        component.set("v.minutesLabel",minutesLabel.innerHTML);
        var secondsLabel = document.getElementById("seconds");
        component.set("v.secondsLabel",secondsLabel.innerHTML);
        var stopTime = component.get("v.my_int");
        clearInterval(stopTime);
    },

    selectRadioButton : function(component, event, helper, radioGrpValue) {
        var arrayOfAnswers = component.get('v.questionsLst');
        console.log("==arrayOfAnswers==",JSON.stringify(arrayOfAnswers));
        var arrayOfTotalRadioAnswer = component.get('v.allRadioAnswer');
        for( var i=0; i<arrayOfAnswers.Answer1s__r.length; i++ ) { 
            if( arrayOfAnswers.Answer1s__r[i].Correct_Answer__c == true  ) { 		
                arrayOfTotalRadioAnswer.push({
                    questionId:arrayOfAnswers.Id,
                    question:arrayOfAnswers.Question_Text__c,
                    yourAnswer:radioGrpValue, 
                    correctAnswer: arrayOfAnswers.Answer1s__r[i].Option__c
                });
            }       
        }

        component.set("v.allRadioAnswer",arrayOfTotalRadioAnswer);
        console.log("allRauido===",component.get("v.allRadioAnswer"));
        var index = component.get('v.numberForShowQuestionForRadio');
        console.log("==index==",index);  
        console.log("==mananana==",component.get("v.allRadioAnswer")[index].correctAnswer);
        arrayOfAnswers.yourAnswer = radioGrpValue;
        arrayOfAnswers.variable2 = false ;
        arrayOfAnswers.correctAnswer = component.get("v.allRadioAnswer")[index].correctAnswer;
        //component.set("v.questionsLst1", arrayOfAnswers); 
        console.log("==questionsLst1==",JSON.stringify(component.get("v.questions1")));
        index++;
        component.set('v.numberForShowQuestionForRadio',index);
        var totalCorrect = component.get("v.totalCorrect");
        var totalWorng = component.get("v.totalWorng");
        //var totalUnanswer = component.get("v.totalUnanswer");
        if( arrayOfAnswers.yourAnswer ==  arrayOfAnswers.correctAnswer && arrayOfAnswers.yourAnswer != '') {
            totalCorrect++;

        } else if( arrayOfAnswers.yourAnswer !=  arrayOfAnswers.correctAnswer && arrayOfAnswers.yourAnswer != '') {
            totalWorng++;
        }
        component.set("v.totalCorrect",totalCorrect);
        component.set("v.totalWorng",totalWorng);
        //component.set("v.totalUnanswer",totalUnanswer);
    },


    selectCheckBox : function(component, event, helper, checkBoxGrpValue) {

        var arrayOfAnswers = component.get('v.questionsLst');
        var k = 0 ;
        var countCorrectAnswer = 0;
        var totalCorrect = component.get("v.totalCorrect");
        var totalWorng = component.get("v.totalWorng");
        
        var arrayOfTotalCheckBoxAnswer = component.get('v.allCheckBoxAnswer');
        for( var i=0; i<arrayOfAnswers.Answer1s__r.length; i++ ) { 
            console.log("==corrcet answer==",arrayOfAnswers.Answer1s__r[i].Correct_Answer__c)
            if( arrayOfAnswers.Answer1s__r[i].Correct_Answer__c == true  ) { 
                countCorrectAnswer++;
                arrayOfTotalCheckBoxAnswer.push({
                    questionId:arrayOfAnswers.Id,
                    yourAnswer:checkBoxGrpValue[k],
                    correctAnswer: arrayOfAnswers.Answer1s__r[i].Option__c
                });
                k++;
            }       
        }
        console.log("==countCorrectAnswer==",countCorrectAnswer);
        component.set("v.allCheckBoxAnswer",arrayOfTotalCheckBoxAnswer);
        arrayOfAnswers.yourAnswer = checkBoxGrpValue;
        arrayOfAnswers.variable2 = true ;
        //arrayOfAnswers.yourAnswerCheckBox = checkBoxGrpValue;
        console.log("==cheheheh===",component.get("v.allCheckBoxAnswer"));
        var index = component.get('v.numberForShowQuestionCheckBox');
        var pushCorrectCheckBoxValue = [];
        var indez = 1;
        for(i=0; i<countCorrectAnswer; i++) {
           
            pushCorrectCheckBoxValue.push(component.get("v.allCheckBoxAnswer")[index].correctAnswer);
            index++;
            component.set("v.numberForShowQuestionCheckBox",index);
            if ( pushCorrectCheckBoxValue[i] == checkBoxGrpValue[i] ) {
                console.log("come threeee time");
                //var test = 'This is correct';
                indez++;
                
            } 
        }

        if (indez == 4 ) {
            totalCorrect++;
        } else {
            totalWorng++;
        }
        component.set("v.totalCorrect",totalCorrect);
        component.set("v.totalWorng",totalWorng);
        console.log("==indez===",indez);
        arrayOfAnswers.allChechboxTrue = indez ;  
        //arrayOfAnswers.checkboxFalse = test1 ;
        console.log("==pushCorrectCheckBoxValue==",pushCorrectCheckBoxValue);
        arrayOfAnswers.correctAnswer = pushCorrectCheckBoxValue;
        console.log("==questionsLst1==",JSON.stringify(component.get("v.questions1")));
    },

    submitData : function (component, event, helper) {

        var action = component.get('c.insertData');
        action.setParams({
            "firstName" : component.find('input1').get("v.value"),
            "lastName" : component.find('input2').get("v.value"),
            "email" : component.find('input3').get("v.value"),
            "phone" : component.find('input4').get("v.value")
            
        });
        action.setCallback(this, function(response){
            console.log("response.getState()==",response.getState());
            if(response.getState() === "SUCCESS") {
                var res = response.getReturnValue() ;
                console.log("==res== : "+res);
                component.set("v.submitAndStart",true);
                $A.util.addClass(component.find('hideAccountData'), 'slds-hide');
                component.find('previousDisable').set('v.disabled',true);
                component.find('nextDisable').set('v.disabled',true);
                component.find('submitDisable').set('v.disabled',true);
            } else if( response.getState() === "ERROR" ) {
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                
                    title: "Warning!",
                    type : 'warning',
                    message: "This record is alread exits."
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
        
    },

    submitAllQuestion : function (component, event, helper) {

        // var newlst =[];
        // $A.createComponent("lightning:tab",{
        //     "label":"All Question",
        //     "onactive":component.getReference("c.showAllQuestions")
        // }, function(newTab ,status, error) {
        //     if( status == "SUCCESS") {
        //         newlst.push(newTab);
        //         component.set("v.moreTabs",newlst);
        //     } else{
        //         throw new Error(error);
        //     }
        // });
        
        console.log("====hehehe====");
        var totalUnanswer = component.get("v.totalUnanswer");
        var showAll = component.get("v.questions1");
        console.log("==showAll==",showAll.length); 
        //console.log("==showAll==",showAll.size);
       // console.log("==showAll==",JSON.stringify(showAll));
        //console.log("==showAll==",showAll.size);
        for( var i=0; i<showAll.length; i++) {
            //console.log("@@@===hehehe====");
            //console.log("hehehe====");
            console.log("==tetetet==",showAll[i].yourAnswer ==  showAll[i].correctAnswer);
            if(showAll[i].yourAnswer == '') {
                totalUnanswer++;
                console.log("hehehe====111===");
            }
            // } else if( showAll[i].yourAnswer ==  showAll[i].correctAnswer && showAll[i].variable2 == false) {
            //     totalCorrect++;
            //     console.log("==totalCorrect==");
    
            // } else if( showAll[i].yourAnswer !=  showAll[i].correctAnswer && showAll[i].yourAnswer != '') {
            //     totalWorng++;
            //     console.log("==totalWrong==");
            // }
    
        }
        component.set("v.totalUnanswer",totalUnanswer);
        // component.set("v.totalCorrect",totalCorrect);
        // component.set("v.totalWorng",totalWorng);
        console.log("see the nmber===",component.get("v.totalUnanswer"));
        $A.util.addClass(component.find("insructionId"), 'slds-hide');
        $A.util.removeClass( component.find('showScore'), 'slds-hide');
        $A.util.addClass( component.find('showScore'), 'slds-show');   
        $A.util.removeClass(component.find("hideShowAllQuestionAfterSubmit"), 'slds-hide');  
        $A.util.addClass(component.find("hideShowAllQuestionAfterSubmit"), 'slds-show');
        //$A.util.removeClass(component.find("hideShowQuestion"), 'slds-show');
        $A.util.addClass(component.find("hideShowQuestion"), 'slds-hide');
    },

    showAllQuestions : function(component, event, helper) {

    }

   

})