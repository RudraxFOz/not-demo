({
    doInitHelper : function( component, event, helper ) {
        console.log("@@@the action=="); 
        var action = component.get('c.fetchSubject');
        console.log("the action==",action);
		action.setCallback(this, function(response){
			if(response.getState() === "SUCCESS") {
                //console.log('parent products : ',JSON.stringify(response.getReturnValue()));
                var res = response.getReturnValue() ;
                console.log("the reposn==",res.Id); 
                component.set('v.lstOfSubject',response.getReturnValue());
                var ss = component.get('v.lstOfSubject');
                console.log("zzzzz==",ss);
            } else {
                console.log("failed with state : "+state);
            }
		});
		$A.enqueueAction(action);
    },

    selectOptionSubjectHelper : function(component, event, helper) {
       
        var demo = component.find("selectSub").get("v.value");
        console.log("==demo==",demo);
        //var dddd = event.target.Id;
        //console.log("===dddd==",dddd);
        var action = component.get('c.showQuestion');
        action.setParams({
            "subjectName" : component.find("selectSub").get("v.value")
        });
        console.log("the action==",action);
		action.setCallback(this, function(response){
			if(response.getState() === "SUCCESS") {
                console.log("the reposn==",response.getReturnValue()); 
                var allResponse = response.getReturnValue();
                console.log("====the reposn==",allResponse);
                var finalList = [];
                var lll = [];
                for(var i=0; i<allResponse.length; i++) {
                    if( allResponse[i].RecordType.Name == 'Single Choose') {
                        console.log("hello come");

                    } else {
                        console.log("hello else");
                    }
                    var answers = allResponse[i].OptionForAnswer__r;
                    //console.log("answers==",allResponse[i].OptionForAnswer__r.length);
                    for(var j=0; j<answers.length; j++) {

                        console.log("answers==");
                        // answers[j].label = answers[j].Option__c;
                        // answers[j].value = answers[j].Option__c;
                        // console.log("@@@answers==",answers[j].label);
                        // console.log("@@@answers==",answers[j].value);
                    }
                    
                    
                }
                // finalList.push(allResponse);
                // console.log("===hello else===",finalList);
                component.set("v.Questions", allResponse);

                console.log("ccc",component.get("v.Questions"));
                // console.log('===allResponse.answerParentLst==',allResponse.answerParentLst); 
                // component.set('v.lstOfSingleQuestion',allResponse.answerParentLst);
                // component.set('v.lstOfMutipleQuestion',allResponse.multiAnswerLst);
                // component.set('v.lstOfOnlySingleQuestion',allResponse.onlySingleAnswerLst);
                // var ss = component.get('v.lstOfSingleQuestion');
                // console.log("zzzzz==",ss);
               //	component.set('v.lstOfSubject',response.getReturnValue());
            } else {
                console.log("failed with state : "+state);
            }
		});
		$A.enqueueAction(action);
    }
})