public with sharing class TestOfContactHandler {
     public Static void onBeforeInsert(List<Contact> insertNewConList) { 
       // insetValue(insertNewConList);
      
    }   
    public Static void onAfterInsert(List<Contact> insertNewConList) { 
        
       //insetValue(insertNewConList);

    }
    public Static void onBeforeUpdate( List<Contact> newListForInsert, Map<Id,Contact> oldMapForUpt) { 
        


    }
    public Static void onAfterUpdate( List<Contact> newListForInsert, Map<Id,Contact> oldMapForUpt ) { 
        
        //updateLst(newListForInsert,oldMapForUpt);
       
    }
    public Static void onBeforeDelete(List<Contact> lstOfConForDelete) { 
        
        
    }
    public Static void onAfterDelete(Map<Id,Contact> oldMapForDelete) { 


    }
    public Static void onAfterUndelete(List<Contact> newUndeleteList) { 

    }


    public Static void insetValue( List<Contact> insertNewConList ) {
        System.debug('hhhhh');
        Set<Id> accId = new Set<Id>();
        for( Contact acc : insertNewConList ) {
            System.debug('helllll--==-='+acc);
            accId.add(acc.AccountId);
        }
        List<Account> cons = [SELECT Id, Name,  BillingCity FROM Account WHERE Id IN: accId];
        List<Contact> updLst = new List<Contact>();
        for (Account acc : cons ) {
            for(Contact con : insertNewConList ) {
                System.debug('==con=='+con);
                if( con.AccountId == acc.Id) {
                    con.MailingCity = acc.BillingCity ; 
                    updLst.add(con);
                }
            }
        }

        if( updLst.size() > 0) {
            update updLst ;
        }
    }


}