public class ObjectAuraController {
    @AuraEnabled
    public static ObjectDataTableWrapper getAccountData(Decimal pageNumber, Decimal pageSize) {   
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
        //Offset for SOQL
        Integer offset = (pNumber - 1) * pSize; 
        //Total Records
        Integer totalRecords = [SELECT COUNT() FROM Account];
        Integer recordEnd = pSize * pNumber;
        //Instance of Account DataTable Wrapper Class
        ObjectDataTableWrapper objDT =  new ObjectDataTableWrapper();  
        objDT.pageSize = pSize;
        objDT.pageNumber = pNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.accountList = [SELECT  ID, Name, Type, Number_of_Contacts__c, Phone, LastModifiedDate, (SELECT Id, LastName  FROM Contacts) FROM Account ORDER BY CreatedDate desc  LIMIT :pSize OFFSET :offset];
        System.debug('ggffff'+ objDT.accountList);
        
        for (Account acc : objDT.accountList) {
            objDT.countTheContact = acc.contacts.size();
            System.debug('gg===='+objDT.countTheContact);
        }
        return objDT;
    }

    @AuraEnabled
    public static ObjectDataTableWrapper  saveAccount (Account acc, Decimal pageNumber, Decimal pageSize) {
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
        //Offset for SOQL
        System.debug('Name of account==' + acc);
        insert acc;
        Integer recordEnd = pSize * pNumber;
        Integer offset = (pNumber - 1) * pSize;
        Integer totalRecords = [SELECT COUNT() FROM Account];
        ObjectDataTableWrapper objDT =  new ObjectDataTableWrapper();  
        objDT.pageSize = pSize;
        objDT.pageNumber = pNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.accountList = [SELECT  ID, Name, Type, Number_of_Contacts__c, Phone, LastModifiedDate, (SELECT Id, LastName  FROM Contacts) FROM Account ORDER BY CreatedDate desc  LIMIT :pSize OFFSET :offset];
        System.debug(' objDT.recordStart=='+ objDT.recordStart);
        System.debug('objDT.recordEnd=='+objDT.recordEnd);
        System.debug('objDT.totalRecords=='+objDT.totalRecords);
        return objDT;

    }

    @AuraEnabled
    public static Account editAccountOne(Account OneAccount, String AccId){
        System.debug('OneAccount::::'+OneAccount);
        Update OneAccount;
        return OneAccount;
       
    }


    // @AuraEnabled
    // public static List<Account> saveAccountss(List<Account> ListAccount){
    //     System.debug(ListAccount);
    //     Insert ListAccount;
    //     return ListAccount ;
        
    // }

    
    @AuraEnabled
    public static ObjectDataTableWrapper  saveContact ( Contact con , String accId ) {
       
        //Offset for SOQL
        System.debug('id='+ con);
        System.debug('id of acc='+ accId);
        con.AccountId = accId;
        insert con;
        ObjectDataTableWrapper objDT =  new ObjectDataTableWrapper();  
        objDT.contactList = [SELECT  ID, Salutation, FirstName, LastName, Phone FROM Contact WHERE AccountId =: accId LIMIT 100];
        System.debug('awwty'+ objDT.contactList);
       // return [SELECT id, Salutation, FirstName__c, LastName__c, Phone FROM Contact LIMIT 100];
        return objDT;
        
    }

    @AuraEnabled
    public static ObjectDataTableWrapper delteAccountById(String accid, Decimal pageNumber, Decimal pageSize) {
        System.debug(accid);
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
        //Offset for SOQL
        Integer offset = (pNumber - 1) * pSize;
         //Total Records
        Integer recordEnd = pSize * pNumber;
        Account delAccount=[SELECT Id, Name, Type, Number_of_Contacts__c, Phone, LastModifiedDate, (SELECT Id, LastName  FROM Contacts) FROM Account  WHERE id=:accid ];
        System.debug(delAccount);
      
        delete delAccount;
        
        Integer totalRecords = [SELECT COUNT() FROM Account];
        ObjectDataTableWrapper objDT =  new ObjectDataTableWrapper();  
        objDT.pageSize = pSize;
        objDT.pageNumber = pNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.accountList = [SELECT  ID, Name, Type, Number_of_Contacts__c, Phone, LastModifiedDate, (SELECT Id, LastName  FROM Contacts) FROM Account ORDER BY CreatedDate desc LIMIT :pSize OFFSET :offset];
        System.debug(' objDT.recordStart=='+ objDT.recordStart);
        System.debug('objDT.recordEnd=='+objDT.recordEnd);
        System.debug('objDT.totalRecords=='+objDT.totalRecords);
        
        return objDT;
        
    }

    @AuraEnabled
    public static ObjectDataTableWrapper saveUpdateRecord(String selectedMenuItemId, Decimal pageNumber, Decimal pageSize) {
        Integer pSize = (Integer)pageSize;
        Integer pNumber = (Integer)pageNumber;
        System.debug('this is id'+selectedMenuItemId);
        //Offset for SOQL
        Integer offset = (pNumber - 1) * pSize;
        //Total Records
        Integer recordEnd = pSize * pNumber;
        Account uptAccount=[SELECT Id, Name, Type, Number_of_Contacts__c, Phone, LastModifiedDate, (SELECT Id, LastName  FROM Contacts) FROM Account WHERE id=:selectedMenuItemId];
        System.debug('this is update recodr'+uptAccount);
        update uptAccount;
        //return [SELECT  ID, Name, Type, Number_of_Contacts__c FROM Account ORDER BY Name LIMIT :pSize OFFSET :offset];
        Integer totalRecords = [SELECT COUNT() FROM Account];
        ObjectDataTableWrapper objDT =  new ObjectDataTableWrapper();  
        objDT.pageSize = pSize;
        objDT.pageNumber = pNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.accountList = [SELECT  ID, Name, Type, Number_of_Contacts__c,  Phone, LastModifiedDate, (SELECT Id, LastName  FROM Contacts) FROM Account ORDER BY CreatedDate desc LIMIT :pSize OFFSET :offset];
        System.debug(' objDT.recordStart=='+ objDT.recordStart);
        System.debug('objDT.recordEnd=='+objDT.recordEnd);
        System.debug('objDT.totalRecords=='+objDT.totalRecords);
        return objDT;
    } 


    @AuraEnabled
    public static List<Contact> getContactRecords(string accId) {
        System.debug('id of conatc:'+accId);
        return [SELECT id, Salutation, FirstName, LastName, Phone FROM Contact WHERE AccountId =: accId LIMIT 100];
    }

    //Wrapper Class For Account DataTable  
    public class ObjectDataTableWrapper {
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
        @AuraEnabled
        public List<Contact> contactList {get;set;}
        @AuraEnabled
        public Integer countTheContact {get;set;}
    }

    @AuraEnabled
    public static List < String > deleteRecords(List < String > lstRecordId) {
        // for store Error Messages  
        List < String > oErrorMsg = new List < String > ();
        // Query Records for delete where id in lstRecordId [which is pass from client side controller] 
        List < contact > lstDeleteRec = [select Id from contact where id IN: lstRecordId];

        Database.DeleteResult[] DR_Dels = Database.delete(lstDeleteRec, false);
        for (Database.DeleteResult dr: DR_Dels) {
            if (dr.isSuccess()) {
                system.debug('successful delete contact');
            } else {
                // Operation failed, so get all errors   
                oErrorMsg.add('');
                for (Database.Error err: dr.getErrors()) {
                oErrorMsg.add(err.getStatusCode() + ': ' + err.getMessage());
            }
        }
    }
        return oErrorMsg;
    }


   

    @AuraEnabled
    public static List<Account> saveAccounts(List<Account> accList){
        Insert accList;
       return [ SELECT  ID, Name, Type, Number_of_Contacts__c, Phone, LastModifiedDate, (SELECT Id, LastName  FROM Contacts) FROM Account ORDER BY CreatedDate desc  ];
    }

     @AuraEnabled
    public static void saveEditAcc(Account accList, String accId){
        System.debug('hii1'+accList);
        System.debug('hii2'+accId);
         Update accList;
        Account acc = [SELECT  ID, Name, Type, Number_of_Contacts__c, Phone, LastModifiedDate, (SELECT Id, LastName  FROM Contacts) FROM Account WHERE id=:accid ];
         System.debug('hii3'+acc);
       
       //return [ SELECT  ID, Name, Type, Number_of_Contacts__c, Phone, LastModifiedDate FROM Account ORDER BY CreatedDate desc  ];
    }
}