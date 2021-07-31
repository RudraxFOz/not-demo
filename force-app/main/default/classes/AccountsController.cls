public with sharing class AccountsController {
   
    @AuraEnabled
    public static Account saveAccount (Account acc) {
        insert acc;
        return acc;
    }
    @AuraEnabled
    public static ContactDataTableWrapper getContactData(Decimal pageNumber, Decimal pageSize) {
         
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
         
        //Offset for SOQL
        Integer offset = (pNumber - 1) * pSize;
         
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Account];
        Integer recordEnd = pSize * pNumber;
 
        //Instance of Contact DataTable Wrapper Class
        ContactDataTableWrapper objDT =  new ContactDataTableWrapper();  
        objDT.pageSize = pSize;
        objDT.pageNumber = pNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.accountList = [SELECT  Name, Type, Number_of_Contacts__c FROM Account ORDER BY Name LIMIT :pSize OFFSET :offset];
        System.debug(objDT.accountList);
        return objDT;
    }
     
    //Wrapper Class For Contact DataTable  
    public class ContactDataTableWrapper {
        @AuraEnabled
        public Integer pageSize {get;set;}
        @AuraEnabled
        public Integer pageNumber {get;set;}
        @AuraEnabled
        public Integer totalRecords {get;set;}
        @AuraEnabled
        public Integer recordStart {get;set;}
        @AuraEnabled
        public Integer recordEnd {get;set;}
        @AuraEnabled
        public List<Account> accountList {get;set;}
    }
}