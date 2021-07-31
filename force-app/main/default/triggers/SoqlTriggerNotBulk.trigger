trigger SoqlTriggerNotBulk on Account (before insert) {

    for(Account c : Trigger.New) {
        Opportunity[] op=[SELECT Id,Name,CloseDate FROM Opportunity WHERE AccountId=:c.Id];
    }
}