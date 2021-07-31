trigger UpdateTask on Task__c (before insert, after insert, before update, after update) {
    if(Trigger.isInsert && Trigger.isBefore) {
        UpdateTaskTriggerHandller.updateTaskSequence(trigger.new);
    }
    if(Trigger.isInsert && Trigger.isAfter) {
        //UpdateTaskTriggerHandller.updateTaskSequence(trigger.new);
    }
    if(Trigger.isUpdate && Trigger.isBefore) {
        UpdateTaskTriggerHandller.updateTask(trigger.new);
        
    }
    if(Trigger.isUpdate && Trigger.isAfter) {
        //UpdateTaskTriggerHandller.updateTask(trigger.new);
    }

}