({
	getValueFormApp : function(component, event, helper) {
		var showResultValue = event.getParams("get_result");
        component.set("v.get_result",showResultValue);
	}
})