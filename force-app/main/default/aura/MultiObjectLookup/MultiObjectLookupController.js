({
    onfocus : function(component,event,helper){
        console.log("===hlooee==hellooo==");
        $A.util.addClass(component.find("mySpinner"), "slds-show");
        //  var forOpen = component.find("searchRes");
        //     $A.util.addClass(forOpen, 'slds-is-open');
        //     $A.util.removeClass(forOpen, 'slds-is-close');
         // Get Default 5 Records order by createdDate DESC  
          var getInputkeyWord = '';
          //helper.searchHelper(component,event,getInputkeyWord);
     },
     onblur : function(component,event,helper){       
        
         component.set("v.listOfSearchRecords", null );
         var forclose = component.find("searchRes");
         $A.util.addClass(forclose, 'slds-is-close');
         $A.util.removeClass(forclose, 'slds-is-open');
     },
     keyPressController : function(component, event, helper) {
        console.log(event.getParams().keyCode);
        if(event.getParams().keyCode == 13){
            alert('Enter key pressed');
          }
        // get the search Input keyword   
          var getInputkeyWord = component.get("v.SearchKeyWord");
        // check if getInputKeyWord size id more then 0 then open the lookup result List and 
        // call the helper 
        // else close the lookup result List part.   
         if( getInputkeyWord.length > 2 ){
              var forOpen = component.find("searchRes");
                $A.util.addClass(forOpen, 'slds-is-open');
                $A.util.removeClass(forOpen, 'slds-is-close');
             helper.searchHelper(component,event,getInputkeyWord);
         }
         else{  
              component.set("v.listOfSearchRecords", null ); 
              var forclose = component.find("searchRes");
                $A.util.addClass(forclose, 'slds-is-close');
                $A.util.removeClass(forclose, 'slds-is-open');
           }
     },
     
   // function for clear the Record Selaction 
     clear :function(component,event,heplper){
          var pillTarget = component.find("lookup-pill");
          var lookUpTarget = component.find("lookupField"); 
         
          $A.util.addClass(pillTarget, 'slds-hide');
          $A.util.removeClass(pillTarget, 'slds-show');
         
          $A.util.addClass(lookUpTarget, 'slds-show');
          $A.util.removeClass(lookUpTarget, 'slds-hide');
       
          component.set("v.SearchKeyWord",null);
          component.set("v.listOfSearchRecords", null );
          component.set("v.selectedRecord", {} );   
     },
     
   // This function call when the end User Select any record from the result list.   
     handleComponentEvent : function(component, event, helper) {
         console.log("==check condtion===");
     // get the selected Account record from the COMPONETN event 	 
        var selectedAccountGetFromEvent = event.getParam("recordByEvent");
        component.set("v.selectedRecord" , selectedAccountGetFromEvent); 
        
         var forclose = component.find("lookup-pill");
            $A.util.addClass(forclose, 'slds-show');
            $A.util.removeClass(forclose, 'slds-hide');
   
         var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
         
         var lookUpTarget = component.find("lookupField");
             $A.util.addClass(lookUpTarget, 'slds-hide');
             $A.util.removeClass(lookUpTarget, 'slds-show');  
       
    },
    
    handleChange : function (component, event, helper ) {
        console.log("==select object==",event.getParam("value"));
        var  str = "KeyboardEvent: key='" + event.getParams().keyCode + "' | code='" +
            event.code + "'";
            console.log("==str===",str);
        var selectObj = event.getParam("value");
        component.set("v.selectObj",selectObj); 
        var stand = 'standard:'+selectObj;
        console.log("==stand==",stand);
        component.set("v.ifTrue",false);
        component.set("v.IconName",stand);
        component.set("v.label",selectObj);
       // component.set("v.ifTrue",true);  searchRes
        console.log("==get==",component.get("v.IconName"));    
    },


    selectRecord : function(component, event, helper){      
      // get the selected record from list  
        var getSelectRecord = component.get("v.listOfSearchRecords");
        //console.log("==getSelectRecord==",getSelectRecord);
        //var selectedValue= event.getSource().get("v.value");
        //var searchText = component.find("searchinput1").get("v.value");
        console.log("===selectedValue==", event.target );
        var target = event.target ;
        var SelIndex = target.getAttribute("data-selectedIndex");
        console.log("==SelIndex==",SelIndex);
      // call the event   
        var compEvent = component.getEvent("oSelectedRecordEvent");
        console.log("==compEvent==",compEvent);
      // set the Selected sObject Record to the event attribute.  
        compEvent.setParams({"recordByEvent" : getSelectRecord });  
      // fire the event
        compEvent.fire();
  },

    
})