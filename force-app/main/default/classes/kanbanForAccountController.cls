public with sharing class kanbanForAccountController {

    @AuraEnabled
    public static List<Account> getKanbanAccList() {
        // String query = 'SELECT Id, ';
        // for(String s:objFields){
        //     query += s+' ,';
        // }
        // query = query.removeEnd(',');
        // query += ' FROM ' + objName;
        // System.debug('qq  ' + query);
        // System.debug('qq qqq ' + Database.query(query));
        // List<Account> accList = []
        return  [SELECT Id,Name FROM Account LIMIT 8];  
    }
}