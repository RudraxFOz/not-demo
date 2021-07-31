trigger Trigger1 on AllInOne__c (before insert) {
    for(AllInOne__c al : Trigger.New) {
        
    }
    AllInOne__c[] con = [SELECT Last_Name__c FROM AllInOne__c WHERE Id IN : Trigger.New];

}