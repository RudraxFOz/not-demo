({
    handleSectionToggle : function(component, event, helper) {
        var openSection = event.getParam('openSections');
        console.log("===openSections==",openSection);

        if( openSection.length === 0 ) {
            component.set("v.activeSectionMessage","All Section are open");
        } else {
            component.set("v.activeSectionMessage","Open Section: "+ openSection.join(', '));
        }
    },

    initRec: function (cmp, event, helper) {
        var myBreadcrumbs = [
            {label: 'Account', name: 'objectName' },
            {label: 'Record Name', name: 'record' }
        ];
        cmp.set('v.myBreadcrumbs', myBreadcrumbs);
    },
    navigateTo: function (cmp, event, helper) {
        //get the name of the breadcrumb that's clicked
        var name = event.getSource().get('v.name');

        //your custom navigation here
    }
})