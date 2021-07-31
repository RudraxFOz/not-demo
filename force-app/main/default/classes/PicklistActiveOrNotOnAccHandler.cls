public with sharing class PicklistActiveOrNotOnAccHandler {
    
    public Static void onBeforeInsert(List<Account> insertNewConList) { 
       
      
    }   
    public Static void onAfterInsert(List<Account> insertNewConList) { 
        
        insetValue(insertNewConList);

    }
    public Static void onBeforeUpdate( List<Account> newListForInsert, Map<Id,Account> oldMapForUpt) { 
        

    }
    public Static void onAfterUpdate( List<Account> newListForInsert, Map<Id,Account> oldMapForUpt ) { 
        
        updateLst(newListForInsert,oldMapForUpt);
       // updateLstForTeam(newListForInsert,oldMapForUpt);
       
    }
    // public Static void onBeforeDelete(List<Account> lstOfConForDelete) { 
        
        
    // }
    public Static void onAfterDelete(Map<Id,Account> oldMapForDelete) { 


    }
    public Static void onAfterUndelete(List<Account> newUndeleteList) { 

    }


    public Static void insetValue( List<Account> insertNewConList ) {
        System.debug('hhhhh');
        Set<Id> accId = new Set<Id>();
        for( Account acc : insertNewConList ) {
            System.debug('helllll--==-='+acc);
            accId.add(acc.Id);
        }
        List<Contact> cons = [SELECT Id, Name, AccountId, MailingCity FROM Contact WHERE AccountId IN: accId];
        List<Contact> updLst = new List<Contact>();
        for (Account acc : insertNewConList ) {
            for(Contact con : cons ) {
                System.debug('==con=='+con);
                if( con.AccountId == acc.Id) {
                    con.MailingCity = acc.BillingCity ; 
                    updLst.add(con);
                }
            }
        }

        if( !updLst.isEmpty()) { 
            update updLst ;
        }
    } 

    
    public Static void updateLst( List<Account> insertNewConList, Map<Id,Account> oldMapForUpt ) {
       
        Set<Id> accId = new Set<Id>();
        for( Account acc : insertNewConList ) {
            accId.add(acc.Id);
        }
        List<Opportunity> opps = [SELECT Id, Name, AccountId, StageName, Account.Type FROM Opportunity  WHERE AccountId IN: accId AND StageName NOT IN ('Closed Lost', 'Closed Won') ];
        for( Account acc : insertNewConList ) { //||  oldMapForUpt.get(acc.Id).Statuss__c == 'None' && acc.Statuss__c == 'Not Active'
        //System.debug('==acc==='+oldMapForUpt.get(acc.Id).Statuss__c == 'Null' ); 
            if ( acc.Statuss__c == 'Not Active' ) { 
                for( Opportunity op : opps ) { 
                    //System.debug('op.StageName==='+op.StageName);
                    // if (op.StageName == 'Prospecting' || op.StageName == 'Qualification' || op.StageName == 'Needs Analysis' || op.StageName == 'Value Proposition' || op.StageName == 'Id. Decision Makers' || op.StageName == 'Perception Analysis' || op.StageName == 'Proposal/Price Quote' || op.StageName == 'Negotiation/Review') {
                    //     acc.addError('You can not change the Picklist For Change close the opportunity stage'); 
                    // } 
                    if(!(op.StageName == 'Closed Lost' || op.StageName == 'Closed Won')) {
                        acc.addError('You can not change the Picklist For Change close the opportunity stage'); 
                    }
                }
            }
        } 

        List<Contact> cons = [SELECT Id, Name, AccountId, MailingCity FROM Contact WHERE AccountId IN: accId];
        List<Contact> updLst = new List<Contact>();
        for (Account acc : insertNewConList ) {
            for(Contact con : cons ) {
                System.debug('==con=='+con);
                if( con.AccountId == acc.Id) {
                    con.MailingCity = acc.BillingCity ; 
                    updLst.add(con);
                }
            }
        }

        if( !updLst.isEmpty()) { 
            update updLst ;
        }
    }



        
}