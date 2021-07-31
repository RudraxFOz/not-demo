({

	doInit : function(component, event, helper) {
 		helper.doInit(component, event,helper);       
	},

	selectOptionSubject : function(component, event, helper) { 
        helper.selectOptionSubjectHelper(component, event, helper);
	},
	
	nextButton : function ( component, event, helper ) {
		//console.log("==allRadioAnswer===",component.get("v.allRadioAnswer"));   
		//console.log("==allCheckBoxAnswer===",component.get("v.allCheckBoxAnswer")); 
		component.set("v.radioGrpValue",'Null');
		component.find('previousDisable').set('v.disabled',false);
		var index = component.get('v.numberForShowQuestion');
		console.log("==index==",index);
		index++;
		component.set("v.numberForShowQuestion",index);
		var showQuestion =  component.get("v.questions")[index];
		component.set("v.questionsLst", showQuestion);
		component.set('v.radioGrpValue',showQuestion.yourAnswer);
		component.set('v.checkGrpValue',showQuestion.yourAnswer);
		 
		if( component.get("v.questions").length == index+1) {
			component.find('nextDisable').set('v.disabled',true);
		}
	},
    
    previousButton : function( component, event, helper) {

		component.find('nextDisable').set('v.disabled',false);
		var index = component.get('v.numberForShowQuestion');
		index--;
		component.set("v.numberForShowQuestion",index);
		var showQuestion =  component.get("v.questions")[index];
		component.set("v.questionsLst", showQuestion);
		component.set('v.radioGrpValue',showQuestion.yourAnswer);  
		component.set('v.checkGrpValue',showQuestion.yourAnswer); 
		if( index == 0) {
			component.find('previousDisable').set('v.disabled',true);
		}
    },
	 
    selectCheckBox : function (component, event, helper) {

		var checkBoxGrpValue = component.get("v.checkGrpValue");
        var testTeam = component.get("v.questionsLst");
		var aaa = component.find("auraId");
		var disableButton =  event.getSource().get('v.value');
		
		if(checkBoxGrpValue.length > 2  ) {
			helper.selectCheckBox(component, event, helper, checkBoxGrpValue);
		} 
		
	},

	selectRadioButton : function (component, event, helper) {
		
		var disableButton = component.find('disablebuttonid');
		var radioGrpValue = component.get("v.radioGrpValue");  
		if( radioGrpValue != undefined || radioGrpValue != 'Null' ) {
			helper.selectRadioButton(component, event, helper, radioGrpValue);
		}
	},

	submitData : function (component, event, helper) {
		if (component.find('input1').get("v.value") != '' && component.find('input2').get("v.value") != '' && component.find('input3').get("v.value") != '' && component.find('input4').get("v.value") != '') {
		
			helper.submitData(component, event, helper);

		} else {
			var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
               
                title: "Warning!",
                type : 'warning',
                message: "Please fill the all reqiured input."
            });
            toastEvent.fire();
		}
	},

	set_timer : function(component, event, helper) {

		helper.callSetInterval(component, event, helper);
		component.set("v.isModalOpen", false);
	},

	stop_timer : function(component, event, helper) {
		helper.stop_timer(component, event, helper)
		component.set("v.isModalOpen", true);
	},
	
	submitAllQuestion : function(component, event, helper) {
		helper.submitAllQuestion(component, event, helper);
	},
	showSpinner: function(component, event, helper) {
        // make Spinner attribute true for displaying loading spinner 
        component.set("v.spinner", true); 
	},
	hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hiding loading spinner    
        component.set("v.spinner", false);
	},

	showAllQuestion : function (component, event, helper) {
		console.log("enter the name===");
		component.set("v.isModalOpen1",true);
		// $A.createComponent(
        //     ['lightning:tab', {
		// 		'aura:id': 'allQueId',
		// 		'label': 'All question'
		// 	}],
		// 	["ui:outputText",{
		// 		"value" : "test"
		// 	}],
		// 	function(components, status, errorMessage){
		// 		if (status === "SUCCESS") {
		// 			var tab = components[0];
		// 			var outputText = components[1];
		// 			// set the body of the lightning:tab to be the ui:outputText
		// 			tab.set("v.body", outputText);
		
		// 			//now do as you were doing before
		// 			var tabset = component.find('tabset');
		// 			var tabsetBody = tabset.get('v.body');
		// 			tabsetBody.push(newTab);
		// 			tabset.set('v.body', tabsetBody);
		// 		}
		// 	}
		// );
	},

	closeModel : function (component, event, helper) {
		//component.find("newtag").destroy();
		component.set("v.isModalOpen1",false);
		//component.destroy();
		// var cmpTarget = component.find('MainDiv');
        // $A.util.removeClass(cmpTarget, 'slds-modal__container');
	},

	navigateToRecord : function (component, event, helper) {
		var idx = event.target.getAttribute('data-index');
		console.log("==idx==",idx);
		
		var showQuestion =  component.get("v.questions")[idx];
		component.set("v.numberForShowQuestion",idx);
		component.set("v.questionsLst", showQuestion);
		component.set('v.radioGrpValue',showQuestion.yourAnswer);
		component.set('v.checkGrpValue',showQuestion.yourAnswer);
		component.set("v.isModalOpen1",false);
		if( idx == 0) {
			component.find('previousDisable').set('v.disabled',true);
		} else {
			component.find('previousDisable').set('v.disabled',false);
		}
		var idxSize = component.get("v.numberForShowQuestion");
		idxSize++;
		if( component.get("v.questions").length == idxSize) {
			component.find('nextDisable').set('v.disabled',true);
		} else {
			component.find('nextDisable').set('v.disabled',false);
		}  
	}
})