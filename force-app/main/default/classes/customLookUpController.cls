public class customLookUpController {
    @AuraEnabled
    public static List < sObject > fetchValueOfSobject(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        List < sObject > returnListOfSobject = new List < sObject > ();  
        String sQuery =  'SELECT id, Name FROM ' +ObjectName + ' WHERE Name LIKE: searchKey order by createdDate DESC LIMIT 8';
        List < sObject > lstOfRecords = Database.query(sQuery);
        for (sObject obj: lstOfRecords) {
            returnListOfSobject.add(obj);
        }
        return returnListOfSobject;
    }
}