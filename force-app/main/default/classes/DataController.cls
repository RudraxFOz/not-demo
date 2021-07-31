public with sharing class DataController {
    @AuraEnabled
    public static wrapper getAccounts(){
        
        System.debug('Inside getAccounts');
        wrapper wrapList = new wrapper();
        Map<String, Schema.SObjectType> m = Schema.getGlobalDescribe();
        List<String> strFields = new List<String>();
        String fldString;
        List<Account> listAcc = new List<Account>();
        Schema.SObjectType s = m.get('Account');
        Schema.DescribeSObjectResult r = s.getDescribe();
        Map<String,Schema.SObjectField> fields = r.fields.getMap();
        
        for(String field : fields.keyset()) {
            Schema.DescribeFieldResult describeResult = fields.get(field).getDescribe();
            if (describeResult.isCreateable() && !describeResult.isNillable() && !describeResult.isDefaultedOnCreate()) {
                System.debug('-----Fields Required-----'+field);
                strFields.add(field);
            }
        }
       System.debug('-----strFields Required-----'+strFields);
       fldString = string.join(strFields,',');
       System.debug('fldString----------'+fldString);
       String query = 'SELECT Id, ';
        for(String st : strFields){
            query += st+' ,';
        }
        query += '(SELECT Id, Name FROM Contacts) FROM Account Limit 5';
        System.debug('qq  ' + query);
        System.debug('qq  ' + Database.query(query));
        wrapList.listAccount = Database.query(query);
        wrapList.requiredFields = strFields;
        return wrapList;      
    }

    @AuraEnabled
    public static void updateAccount(String conId, String AccId, SObject SObj){

    }
     public class wrapper{
        @AuraEnabled
        public List<Account> listAccount;
        @AuraEnabled
        public List<String> requiredFields;
    }
}