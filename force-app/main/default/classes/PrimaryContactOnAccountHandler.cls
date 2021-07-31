public with Sharing class PrimaryContactOnAccountHandler {

    public static boolean isExecuting = false;
    
    public Static void onBeforeInsert(List<Contact> insertNewConList) { 
        removeAllCheackedBox(insertNewConList, 'beforeInsert');
    }
    
    public Static void onAfterInsert(List<Contact> insertNewConList) { 
        cheackedThekBox(insertNewConList);
    }

    public Static void onBeforeUpdate(List<Contact> insertNewConList) { 
        removeAllCheackedBox(insertNewConList, 'beforeUpdate');
       
    }
    // public Static void onAfterUpdate( List<Contact> newListForInsert) { 
    //     //System.debug('111hhhhhhhhhhhh');
    //     //updateThePrimaryCon(newListForInsert);
    // }
    public Static void onBeforeDelete(List<Contact> lstOfConForDelete) { 
        deleteRecordOfCon(lstOfConForDelete);
        
    }
    // public Static void onAfterDelete(List<Contact> afterDeleteList) { 
        
    // }
    // public Static void onAfterUndelete(List<Contact> newUndeleteList) { 
    //     //insertRecordForCustomeSharing(newUndeleteList);      
    // }


    public static void removeAllCheackedBox (List<Contact> insertNewConList, String checkTrigger) {

        if( PrimaryContactOnAccountHandler.isExecuting ){
			// if was executed during the same context 
			// avoid recursion
			return;
		}
        PrimaryContactOnAccountHandler.isExecuting = true; 
        if(checkTrigger.equalsIgnoreCase('beforeInsert')) {
            System.debug('when record is insert');
            onlyCallAtInsert(insertNewConList);           
          
        } else if ( checkTrigger.equalsIgnoreCase('beforeUpdate') ) {
            System.debug('when record is update');
            for( Contact con : insertNewConList ) {
                if (con.ConditionCheack__c == true ) {
                    //con.addError('Can not edit this record Because this is primary contact');
                    onlyCallAtInsert(insertNewConList);
                } else {
                   // onlyCallAtInsert(insertNewConList);
                   con.addError('Can not edit this record Because this is primary contact');
                }
            }   
        }
    }

    public Static void onlyCallAtInsert ( List<Contact> insertNewConList ) {
            System.debug('record insert in bulk');
            set<id> accId = new set<id>();
            Set<Id> contactIds = new Set<Id>();
            List<Account> accountToUpdate = new List<Account>();
           
            Integer count = 1 ; 
            for( Contact con : insertNewConList ) {
                if( insertNewConList.size() < 2) {
                    System.debug('if size is 1');
                    if( con.AccountId != null) {
                        Account acc = new Account(Id = con.AccountId, Primary_Contact__c = con.LastName);
                        System.debug('--acc---'+acc);
                        accountToUpdate.add(acc);
                    }
                } else {
                    System.debug('if size is more than  1');
                    if( con.ConditionCheack__c == true ) {
                        count++ ;
                    }
                    System.debug('--count--'+count);
                    if ( count < 3 ) {
                        System.debug('Only come one Time');
                        if( con.ConditionCheack__c == true ) {
                            Account acc = new Account(Id = con.AccountId, Primary_Contact__c = con.LastName);
                            System.debug('--acc---'+acc);
                            accountToUpdate.add(acc);
                        }    
                    } 

                }
                accId.add(con.accountId);
                contactIds.add(con.Id);
            } 
            System.debug('--accountToUpdate---'+accountToUpdate);
            update accountToUpdate;
            List<Contact> lstOfCon = [SELECT Id, Name, ConditionCheack__c FROM Contact WHERE accountId IN: accId AND ConditionCheack__c = true AND Id NOT IN: contactIds];
            Map<Id,Contact> mapOfCon = new Map<Id,Contact>(lstOfCon);
        
            List<Contact> updateLstForCon = new List<Contact>();
            if(!lstOfCon.isEmpty()) {
                for( Contact con : lstOfCon) {
                    con.ConditionCheack__c = false ;
                    updateLstForCon.add(con);
                }
                update updateLstForCon ;
            }  

    }


    public static void  cheackedThekBox(List<Contact> insertNewConList) {

        List<Contact> insertLstForCon = new List<Contact>(); 
        Integer count = 1 ;
        for( Contact con : insertNewConList ) { 
            if (insertNewConList.size() < 2) {
                if( con.ConditionCheack__c == false ) {
                    Contact aux  = new Contact(Id = con.Id); 
                    aux.ConditionCheack__c = true;
                    insertLstForCon.add(aux);
                }
            } else {
                System.debug('come Here'); 
                if( con.ConditionCheack__c == true ) {
                    count++ ;
                }
                System.debug('--count--'+count);
                if(count < 3 ) {
                    System.debug('not come in');
                    if( con.ConditionCheack__c == false ) {
                        System.debug('hwloooo');
                        Contact conx  = new Contact(Id = con.Id);       
                        //conx.ConditionCheack__c = true ;
                        System.debug('hwloooo');
                        insertLstForCon.add(conx);
                    } 
                }  else {
                    Contact conx  = new Contact(Id = con.Id);       
                    conx.ConditionCheack__c = false ;
                    System.debug('hwloooo');
                    insertLstForCon.add(conx);
                } 
            } 
        }
        
        update insertLstForCon ;      
    }

    public Static void deleteRecordOfCon(List<Contact> lstOfConForDelete) {
        System.debug('--lstOfConForDelete---'+lstOfConForDelete);
        for(Contact con : lstOfConForDelete ) {
            System.debug('--Con.Name---'+con.Name);
            if( con.ConditionCheack__c == true ) {
                con.ConditionCheack__c.addError('This is Primary Record For delete this record assign the primary another reocrd');
            }
        }
    }
}