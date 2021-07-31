({

	doInit : function(component, event, helper) {
 		helper.doInit(component, event,helper);       
	},

	selectOptionSubject : function(component, event, helper) { 
        helper.selectOptionSubjectHelper(component, event, helper);
	},
	
	nextButton : function ( component, event, helper ) {
		let button1 = component.find('previousDisable');
		button1.set('v.disabled',false);
		var name = component.get("v.numberForShowQuestion");
		var cheack = component.get("v.questions");
		var showQuestion = [];
		for( var i=name+1; i< name+2; i++ ) {
			if ( component.get("v.questions").length-1 == i ) {
				let button1 = component.find('nextDisable');
				button1.set('v.disabled',true);
			}
			component.set("v.numberForShowQuestion",i);
			if( component.get("v.questions").length> i )
				showQuestion.push(cheack[i]);
		}
		component.set("v.questionsLst", showQuestion)
	},
    
    previousButton : function( component, event, helper) {
		let button1 = component.find('nextDisable');
		button1.set('v.disabled',false);
        var name = component.get("v.numberForShowQuestion");
        var cheack = component.get("v.questions");
		var showQuestion = [];
		for(var i=name-1; i <= name-1; i++) {
			if ( i<=0) {
				let button1 = component.find('previousDisable');
				button1.set('v.disabled',true);
			}
			component.set("v.numberForShowQuestion",i);
			if( component.get("v.questions").length> i )
				showQuestion.push(cheack[i]);
		}
		component.set("v.questionsLst", showQuestion)
    },
	 
    selectTrueAnswer : function (component, event, helper) {

		var radioGrpValue = component.get("v.radioGrpValue");
        var testTeam = component.get("v.questionsLst");
        var aaa = component.find("auraId");
        console.log("==aaa==",aaa);
        console.log('option' + event.getSource().getElements);
        for( var i=0; i<component.get("v.questionsLst").length; i++ ) {
            var answers = component.get("v.questionsLst")[i].Answer1s__r; 
            for( var j=0; j<answers.length; j++ ) {
                console.log("answers==",answers[j]);
                console.log("answers==@@@",answers[j].Correct_Answer__c == true);
                if( answers[j].Correct_Answer__c == true && answers[j].Option__c ==  component.get("v.radioGrpValue") ) {
					console.log("your answer is correct");
					//$A.util.addClass();
					//slds-radio [type=radio]:checked+.slds-radio__label.backgroundColour ="pink"
				
					//slds-form-element__label.backgroundColour ="pink"
                } else {
                    console.log("your answer is worng");
                }
                       
         	}
        }
	}
})