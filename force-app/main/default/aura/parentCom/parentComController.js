({
	/* parentExprController.js */
    updateParentAttr: function(cmp) {
        cmp.set("v.parentAtt", "updated parent attribute");
    },
    
     onParentAttrChange: function(cmp, evt) {
        console.log("P parentAttr has changed");
        console.log("P old value: " + evt.getParam("oldValue"));
        console.log("P current value: " + evt.getParam("value"));
    }
})