trigger FixTheAmount on Bank_Account__c (before insert) {
    for(Bank_Account__c c:Trigger.New) {
        c.Amount__c=6000;
    }
}