Trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> taskList = new List<Task>();
    Boolean validStages = true;
    for (Opportunity opp : [SELECT Id, StageName FROM Opportunity WHERE StageName = 'Closed Won' AND Id IN :Trigger.new]){
            taskList.add(new Task(Subject = 'Follow Up Test Task',

                                  WhatId = opp.Id));
    }
    
    List<Id> oid = new List<ID>();
        for(Opportunity opp:trigger.new)
        {
        oid.add(opp.id);
        }
    
    Map<Id, Opportunity> OppMap = Trigger.NewMap;
    List<OpportunityContactRole> oppl = [select id,Role, OpportunityId from OpportunityContactRole where OpportunityId IN:oid];
    
    for(opportunity opp1:trigger.new)
    {
    for(OpportunityContactRole opp : oppl)
    {
    if(opp.Role=='Business User')
    {
    OppMap.get(opp1.id).addError('Please update Opportunityproduct');
    validStages = false;
    //opp.addError('Please update Opportunityproduct');
    }
    }
    }
    

    for(Opportunity opp : Trigger.new){
    System.debug('==opp =='+opp );
        for(OpportunityContactRole oppConRole : opp.OpportunityContactRoles){
            System.debug('==oppConRole=='+oppConRole);
        }
    }

    if(taskList.size()>0){

        //insert taskList;
    }
}