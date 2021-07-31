({
    createObjectData: function(component, event) {
        // get the AccList from component and add(push) New Object to List  
        var rowItemList = component.get("v.AccList");
        rowItemList.push({
            'sobjectType': 'Account',
            'Name': '',
            'Type': '',
            'Phone': '',
            'disable':false
        });
        // set the updated list to attribute (AccList) again    
        component.set("v.AccList", rowItemList);
    },

    createObjectDataForClone: function(component, event) {
        var getTheSelectAtt = event.getParam("forAccListAcc");
        console.log("===ss",JSON.stringify(getTheSelectAtt));
        var rowItemList = component.get("v.AccList");
        // var a = JSON.stringify(rowItemList);
        // console.log('a - ',a);
        // var arr_from_json = JSON.parse( a );
        var clonedAcc = { 'sobjectType': 'Account', 
                          'Name': getTheSelectAtt.Name,
                          'Type': getTheSelectAtt.Type,
                          'Phone':getTheSelectAtt.Phone,
                          'disable':getTheSelectAtt.disable
                        };
        rowItemList.push(clonedAcc);
        component.set("v.AccList", rowItemList);
    },

    // helper function for check if first Name is not null/blank on save  
    validateRequired: function(component, event) {
        var isValid = true;
        var allAccountRows = component.get("v.AccList");
        for (var indexVar = 0; indexVar < allAccountRows.length; indexVar++) {
            if (allAccountRows[indexVar].Name  == '') {
                isValid = false;
                alert('First Name Can\'t be Blank on Row Number ' + (indexVar + 1));
            }
        }
        return isValid;
    }
})