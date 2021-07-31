trigger TotalSalaryTrigger on TotalSalaryObj__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {


     if( trigger.isBefore && trigger.isInsert ) {

        TotalSalaryTriggerHandler.onBeforeInsert(trigger.new);

    } else if( trigger.isAfter && trigger.isInsert ) {

        TotalSalaryTriggerHandler.onAfterInsert(trigger.new);

    } else if( trigger.isBefore && trigger.isUpdate ){

        TotalSalaryTriggerHandler.onBeforeUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isAfter && trigger.isUpdate ) {

        TotalSalaryTriggerHandler.onAfterUpdate(trigger.new, trigger.oldMap);
         
    } else if( trigger.isBefore && trigger.isDelete ) {

        TotalSalaryTriggerHandler.onBeforeDelete(trigger.old);

    } else if ( trigger.isAfter && trigger.isDelete ) {

       TotalSalaryTriggerHandler.onAfterDelete(trigger.old);

    } else if ( trigger.isAfter && trigger.isUndelete ) {

        TotalSalaryTriggerHandler.onAfterUndelete(trigger.new);

    }  
    
}