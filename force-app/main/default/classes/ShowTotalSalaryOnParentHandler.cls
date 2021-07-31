public with sharing class ShowTotalSalaryOnParentHandler {
    public Static void onBeforeInsert(List<Contact> insertNewConList) { 
      //insertNewCon(insertNewConList);
      insertAndDeleteRecord(insertNewConList);
    }   

    public Static void onAfterInsert(List<Contact> insertNewConList) { 
        System.debug('@@@chech for inserttime come in update@@@'); 
        //insertNewConAftr(insertNewConList);
        //insertAndDeleteRecord(insertNewConList);
    }

    public Static void onBeforeUpdate( List<Contact> newListForInsert, Map<Id,Contact> oldMapForUpt) { 
        //insertNewConAftr(insertNewConList);
        System.debug('chech for inserttime come in update');
        //updateList(newListForInsert, oldMapForUpt);
        
    }
    public Static void onAfterUpdate( List<Contact> newListForInsert, Map<Id,Contact> oldMapForUpt ) { 
        updateList(newListForInsert, oldMapForUpt);
    }
    public Static void onBeforeDelete(List<Contact> lstOfConForDelete) { 
        
        
    }
    public Static void onAfterDelete(Map<Id,Contact> oldMapForDelete) { 
        System.debug('Delete Record:'+oldMapForDelete);
        //deleteFunction(oldMapForDelete);
    }
    // public Static void onAfterUndelete(List<Contact> newUndeleteList) { 
        
    // } insertNewCon

    public Static void insertNewCon( List<Contact> insertNewConList ) {
        System.debug('helooooooo');
        Set<Id> setOFAcc = new Set<Id>();
        for( Contact con : insertNewConList ) {
            setOFAcc.add(con.AccountId);
        }
        Map<ID, Account> acctsToUpdate = new Map<ID, Account>([SELECT Id, TotalSalary__c, (SELECT Id, Name FROM Accounts__r)  FROM Account WHERE Id IN :setOFAcc]);
        for( Account acc : acctsToUpdate.values() ){
            System.debug('=acc='+acc);
            Decimal totalValue = 0;
            for( Contact  con : insertNewConList ) {
                if (con.AccountId == acc.Id && con.Salary__c != NULL) {
                    //Contact  c = new Contact();
                    totalValue += con.Salary__c ;
                }
            } 
            acc.TotalSalary__c = totalValue;
            System.debug('TotalSalary==='+ acc.TotalSalary__c);
        }

        if(acctsToUpdate.values().size() > 0) {
            insert acctsToUpdate.values();
        }

    }


    public Static void insertNewConAftr( List<Contact> insertNewConList ) {
        Set<Id> setOFAcc = new Set<Id>();
        for( Contact con : insertNewConList ) {
            
            setOFAcc.add(con.AccountId);
        }
        //insertAndDeleteRecord(setOFAcc);
    }


    public Static void updateList( List<Contact> newListForInsert, Map<Id,Contact> oldMapForUpt ) {
        Set<Id> setOFAcc = new Set<Id>();
        for( Contact con : newListForInsert ) {
            System.debug('===@@new@@@@ ==='+con.lastName+' Salary '+ con.Salary__c +' AccountName '+con.AccountId );
            setOFAcc.add(con.AccountId);
        }

        for( Contact con : oldMapForUpt.values() ) { 
            System.debug('===@@old@@@@ ==='+con.lastName+' Salary '+ con.Salary__c +' AccountName '+con.AccountId );
            setOFAcc.add(con.AccountId);
        }
        Map<ID, Contact> contactsForAccounts = new Map<ID, Contact>([SELECT Id ,AccountId, lastName, Salary__c FROM Contact WHERE AccountId IN :setOFAcc AND Salary__c != null ]);
        Map<ID, Account> acctsToUpdate = new Map<ID, Account>([SELECT Id, Name, TotalSalary__c FROM Account WHERE Id IN :setOFAcc]);
        for (Account acct : acctsToUpdate.values()) {
            System.debug('account Name==='+acct.Name);
            Account acc = new Account(); 
            Decimal totalValue = 0;
            for (Contact con : contactsForAccounts.values()) {
                System.debug('===@@oldMapForUpt@@ ==='+con.lastName +' Salary '+ con.Salary__c );
                if (con.AccountId == acct.Id && con.Salary__c != NULL) {
                    System.debug('come 11111');
                    totalValue += con.Salary__c; 
                }    
            }
            acct.TotalSalary__c = totalValue;
            System.debug('come 11111@@@'+acct.TotalSalary__c);
        }

        if(acctsToUpdate.values().size() > 0) {
            update acctsToUpdate.values();
        }
    }

    public Static void deleteFunction( Map<Id,Contact> oldMapForDelete ) {

       
        //insertAndDeleteRecord(setOFAcc);
    }


    public Static void insertAndDeleteRecord( List<Contact> insertNewConList ) {
        System.debug('00000000000000000');
        // for (Contact con : contactsForAccounts.values()) {
            //     if (con.AccountId == acctsToUpdate.get(con.AccountId).Id && con.Salary__c != NULL ) {
            //         System.debug('come 11111');
            //         totalValue += con.Salary__c; 
            //         // if () {

            //         // }
            //     }
            // }
        Set<Id> setOFAcc = new Set<Id>();
        Set<Id> idOfTop = new Set<Id>();  
        for( Contact con : insertNewConList ) {
            setOFAcc.add(con.AccountId);
        }
        Set<Id> setOfParentId = new Set<Id>();
        //Map<id,Decimal> sumValues= new Map<id,Decimal>();
        List<Decimal> totalSalary = new List<Decimal>();
        Map<ID, Contact> contactsForAccounts = new Map<ID, Contact>([SELECT Id ,AccountId, Salary__c  FROM Contact WHERE AccountId IN :setOFAcc AND Salary__c != null ]);
        Map<ID, Account> acctsToUpdate = new Map<ID, Account>([SELECT Id, TotalSalary__c, Parent_Account__c, TotalSalaryObjParent__c FROM Account WHERE Id IN :setOFAcc]);
        List<Account> lst = new List<Account>();
        Decimal valueForStore = 0;
        Decimal parentValue = 0 ;
        Decimal valueSt = 0 ; 
        for (Account acct : acctsToUpdate.values()) {
            Account aa = new Account();
            System.debug('Parent_Account__c==='+acct.Parent_Account__c);
            System.debug('@@ttt==='+acct);
            setOfParentId.add(acct.Parent_Account__c);
            idOfTop.add(acct.TotalSalaryObjParent__c);
            //Account acc = new Account(); 
            Decimal totalValue = 0;
            parentValue = acct.TotalSalary__c ;
            System.debug('parentValue=='+parentValue);

            // for (Contact con : contactsForAccounts.values()) {
            //     if (con.AccountId == acctsToUpdate.get(con.AccountId).Id && con.Salary__c != NULL ) {
            //         System.debug('come 11111');
            //         totalValue += con.Salary__c; 
            //         // if () {

            //         // }
            //     }
            // }
           
            for( Contact c : insertNewConList ) {
                totalValue += c.Salary__c ;
                valueSt += c.Salary__c ;
            }
            aa.Id = acct.Id ;
            System.debug('totaSal=='+totalValue);
            if( acct.Parent_Account__c == Null ) {
      
            }
            if( parentValue == Null) {
                aa.TotalSalary__c = totalValue  ;
                valueForStore = totalValue ;
            } else {
                aa.TotalSalary__c = totalValue + parentValue ;
                valueForStore = totalValue + parentValue ;  
            }
            lst.add(aa);
            System.debug('==totalValue@@=='+totalValue);
            System.debug('come 11111@@@'+acct.TotalSalary__c);
        }

        Map<Id, Account> accLst = new Map<Id, Account>([SELECT Id, Name, TotalSalary__c, TotalSalaryObjParent__c FROM Account WHERE Id IN : setOfParentId]);
        List<Account> accLst1 = new List<Account>();
        System.debug('accLst===@=='+accLst);
        Decimal  parentTotalSal = 0 ;
        for ( Account a : accLst.values()) {
            Account aa1 = new Account();
            idOfTop.add(a.TotalSalaryObjParent__c);
            parentTotalSal = a.TotalSalary__c ;
            System.debug('parent==='+parentTotalSal);
            //if ()
            aa1.Id = a.Id ;
            aa1.TotalSalary__c = valueForStore ; 
            //a.TotalSalary__c = parentTotalSal + valueSt ;
            accLst1.add(aa1);
            System.debug('a.TotalSalary__c===@=='+a.TotalSalary__c);
        }
        System.debug('valueForStore===@=='+valueForStore);
        //System.debug('a.TotalSalary__c===@=='+a.TotalSalary__c);
        Map<Id, TotalSalaryObj__c> topLst = new Map<Id, TotalSalaryObj__c>([SELECT Id, Name, TotalSalary__c FROM TotalSalaryObj__c WHERE Id IN : idOfTop]);
        List<TotalSalaryObj__c> accLst2 = new List<TotalSalaryObj__c>();
        for( TotalSalaryObj__c top : topLst.values() ) {
            TotalSalaryObj__c aa1 = new TotalSalaryObj__c();
            aa1.Id = top.Id ;
            aa1.TotalSalary__c = valueForStore ;
            accLst2.add(aa1);
        }
        // if(acctsToUpdate.values().size() > 0) {
        //     update acctsToUpdate.values();
        // }
         if(lst.size() > 0) {
            update lst ;
        }

        // if( accLst.values().size() > 0) {
        //     update accLst.values();
        // }
         if( accLst1.size() > 0) {
            update accLst1 ;
        }

        // if( topLst.values().size() > 0) {
        //     update topLst.values();
        // }
         if( accLst2.size() > 0) {
            update accLst2 ;
        }
    }
}