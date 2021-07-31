@isTest
public  class ClientSidePaginationControllerTest {
    static testMethod void PositiveTest(){
        // String label = 'labelTest' ;
        // String value = 'valueTest' ;
        // SObject sObj = 'Account' ;
        // SObjectWrapper objWrapper = new SObjectWrapper();
        // objWrapper.label = label ;
        // objWrapper.value = value ;
        // SObjectWrapperForRecord obj = new SObjectWrapperForRecord();
        // obj.sObj = sObj ;
        String objectName = 'Account';
        List<String> lst = new List<String>();
        lst.add('Name');
        lst.add('Phone');
        ClientSidePaginationController.getSobject();
        ClientSidePaginationController.getFields(objectName);
        ClientSidePaginationController.getRecords(objectName, lst);
    }
}