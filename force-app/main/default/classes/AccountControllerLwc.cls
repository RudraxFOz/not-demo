public with sharing class AccountControllerLwc {
    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        System.debug('==searchKey=='+searchKey);
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, AccountNumber FROM Account WHERE Name LIKE :key  LIMIT 10];
    }
}