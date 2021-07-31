trigger RollUpSummary on Contact (before insert, after insert, before update, after update,  before delete, after delete, after undelete) {
    Set<Id> accIds = new Set<Id>();
    if(trigger.isBefore && trigger.isInsert) {
        for(Contact con : trigger.new){
            //con.LastName = 'ComeToTest';
        }
    } else if(trigger.isBefore && trigger.isUpdate) {
        for(Contact con : trigger.new){
            //con.LastName = 'BeforeUpdateCon';
        }         
    } else if(trigger.isBefore && trigger.isDelete){
        for(Contact con : trigger.old){
            //con.LastName = 'BeforeUpdateCon';
            //Account actualRecord = oldMapObject.get(accObj.Id); 
            //con.adderror('Cant Delete');
        }   
        
    } else if(trigger.isAfter && trigger.isInsert){
        List<Contact> conList = new List<Contact>();
        List<String> conList1 = new List<String>();
        
        
        for(Contact con : [SELECT Id, LastName, City__c FROM Contact WHERE Id IN :trigger.new]){
            System.debug('==con=='+con);
            con.LastName = 'ComeToTest1';
            con.City__c = 'ComeToCity1';
            //con.
            System.debug('==con.LastName=='+con.LastName);
            conList.add(con);
            
            conList1.add(con.LastName);
            System.debug('==conList=='+conList);
        }
        //RecursiveTriggerHandler.onlyForTestPur1(conList1);
        RecursiveTriggerHandler.onlyForTestPur(conList1);
        if(!conList.isEmpty()){
            //update conList;
        }  
    } else if(trigger.isAfter && trigger.isUpdate){
        List<Contact> conList = new List<Contact>();
        System.debug('==trigger.new=='+trigger.new);
        if(RecursiveTriggerHandler.isFirstTime && RecursiveTriggerHandler.isUndeleteValue){
            RecursiveTriggerHandler.isFirstTime = false;
            for(Contact con : [SELECT Id, LastName, City__c FROM Contact WHERE Id IN :trigger.new]){
                System.debug('==con=='+con);
                con.LastName = 'AfterUpdateCon';
                conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }  
        
    } else if(trigger.isAfter && trigger.isDelete){
        for(Contact con : trigger.old){
            //con.LastName = 'BeforeUpdateCon';
            //Account actualRecord = oldMapObject.get(accObj.Id); 
            //con.adderror('Cant Delete');
        }   
     
    } else if(trigger.isAfter && trigger.isUndelete){
        List<Contact> conList = new List<Contact>();
        RecursiveTriggerHandler.isUndeleteValue = false;
        for(Contact con : [SELECT Id, LastName, City__c FROM Contact WHERE Id IN :trigger.new]){
            System.debug('==con=='+con);
            con.LastName = 'AfterUndeleteCon';
            //con.City__c = 'ComeToCity1';
            //con.
            System.debug('==con.LastName=='+con.LastName);
            conList.add(con);
            System.debug('==conList=='+conList);
        }
        if(!conList.isEmpty()){
            update conList;
        }    
    }   
}