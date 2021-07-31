trigger ConatcOnTrigger on Contact (before insert,after update,before delete,after undelete) {
    
     if(Trigger.isInsert) {
        HelperForAccountandContact.countTheTotal();
         HelperForAccountandContact.methodOnContact(Trigger.New);
    }
     if(Trigger.isUpdate) {
        HelperForAccountandContact.countTheTotal();
    }
     if(Trigger.isDelete) {
         System.debug('==trigger.old=='+trigger.old);
         for(Contact con : [SELECT Id, FirstName, LastName FROM Contact WHERE AccountId != null AND Id IN : trigger.old]) {
             System.debug('==con=='+con);
             Contact actualRecord = trigger.oldMap.get(con.Id); 
            //con.adderror('Cant Delete');
             con.addError('Can not delete this Contact');
         }
        //HelperForAccountandContact.countTheTotal();
    }
     if(Trigger.isUndelete) {
        HelperForAccountandContact.countTheTotal();
    }


}