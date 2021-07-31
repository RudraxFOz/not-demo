trigger TestTrigger on Matter_Team_Member__c (after insert, after update, after delete) {

    
    if(trigger.isAfter && trigger.isInsert){
        MatterTeamMemberHandler.OnAfterInsert(trigger.new);
    }
    if(trigger.isAfter && trigger.isUpdate){
        MatterTeamMemberHandler.OnAfterUpdate(trigger.new ,trigger.oldmap);
    }
    if(Trigger.isDelete && Trigger.isAfter){
        MatterTeamMemberHandler.OnAfterDelete(Trigger.old); 
    }

}