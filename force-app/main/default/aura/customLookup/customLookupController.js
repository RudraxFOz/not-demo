({
    /*hideChildRec : function(component,event,helper){       
      component.set("v.listOfSearchRecords", null );
      var showANdHideChildRec = component.find("mainDivIdOfPar");
        $A.util.addClass(showANdHideChildRec, 'slds-is-close');
        $A.util.removeClass(showANdHideChildRec, 'slds-is-open');
    }, */

    keyPressController : function(component, event, helper) {
        console.log("heloooooo---"); 
        var getInputkeyWordValue = component.get("v.SearchKeyWord");
        console.log("getInputkeyWordValue.length---",getInputkeyWordValue.length );
        console.log("getInputkeyWordValue.length---",getInputkeyWordValue.length > 2);
        if( getInputkeyWordValue.length > 2 ) {
          var forOpenHideChildRec = component.find("mainDivIdOfPar");
            $A.util.addClass(forOpenHideChildRec, 'slds-is-open');
            $A.util.addClass(forOpenHideChildRec, 'slds-is-close');
          helper.searchHelper(component,event,getInputkeyWordValue);
        } else { 
            component.set("v.listOfSearchRecords", null ); 
            var forOpenHideChildRec = component.find("mainDivIdOfPar");
            $A.util.addClass(forOpenHideChildRec, 'slds-is-close');
            $A.util.removeClass(forOpenHideChildRec, 'slds-is-open');
        }
    },

    removeThePill :function(component,event,heplper){
        var showAndHidePillValue = component.find("id-for-pill");
        var showAndHideInput = component.find("lookupField"); 
          $A.util.addClass(showAndHidePillValue, 'slds-hide');
          $A.util.removeClass(showAndHidePillValue, 'slds-show');
          $A.util.addClass(showAndHideInput, 'slds-show');
          $A.util.removeClass(showAndHideInput, 'slds-hide');
        component.set("v.SearchKeyWord",null);
        component.set("v.listOfSearchRecords", null );
        component.set("v.selectedRecord", {} );   
    },

    handleComponentEvent : function(component, event, helper) { 
        var selectedAccountGetFromEvent = event.getParam("recordByEvent");
        component.set("v.selectedRecord" , selectedAccountGetFromEvent); 
        var showAndHidePillValue = component.find("id-for-pill");
          $A.util.addClass(showAndHidePillValue, 'slds-show');
          $A.util.removeClass(showAndHidePillValue, 'slds-hide');
        var forOpenHideChildRec = component.find("mainDivIdOfPar");
          $A.util.addClass(forOpenHideChildRec, 'slds-is-close');
          $A.util.removeClass(forOpenHideChildRec, 'slds-is-open');
        var showAndHideInput = component.find("lookupField");
          $A.util.addClass(showAndHideInput, 'slds-hide');
          $A.util.removeClass(showAndHideInput, 'slds-show');  
    }
})