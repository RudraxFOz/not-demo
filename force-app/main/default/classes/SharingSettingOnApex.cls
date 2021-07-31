public with sharing class SharingSettingOnApex {
    
    public static void sharingMethodTest() {
        List<Account> accList = [SELECT Id, Name, CreatedDate, LastModifiedDate  FROM Account LIMIT 30];
        System.debug('==acclIst=='+accList);
    }

}