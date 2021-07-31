trigger DeletedAttemptOnAccount on Account (before insert, before delete, after delete, after undelete) {
    if(Trigger.isDelete && Trigger.isBefore){
        //List acc = [SELECT Id, (SELECT Id FROM Opportunities ) FROM Account WHERE Id IN : Trigger.old];
        
        DeletedAttemptOnAccountHelper.deleteRecordOnBefore(Trigger.oldMap);
        //AccountProcessor1.countContacts('StringName');
        
        //DeletedAttemptOnAccountHelper.deleteRecordOnAfter(IdOfAcc);

    } else if(Trigger.isDelete && Trigger.isAfter){
        System.debug('==Trigger.isAfter===Trigger.new=='+System.Trigger.new);
        System.debug('==Trigger.isAfter===Trigger.old=='+System.Trigger.old);
         Set<Id> conSet = new Set<Id>();
        List<Account> listofaccts1 = [SELECT Id, Name,Deleted_Attempt__c, (SELECT Id, Name FROM Contacts )
                           FROM Account where id IN :trigger.old]; 
        System.debug('==listofaccts1==listofaccts1=='+listofaccts1);
        //System.debug('==listofaccts1==listofaccts1=='+listofaccts1);
        For(Account acc : listofaccts1) {
            conSet.add(acc.Id);
            System.debug('==acc==acc=='+acc);
            System.debug('==accObj.Contacts.size()=='+acc.Contacts.size());
            For(Contact con : acc.Contacts) {
                System.debug('==con==con=='+con);
            }
        }
            //DeletedAttemptOnAccountHelper.deleteRecordOnAfter11(conSet);

    }

}