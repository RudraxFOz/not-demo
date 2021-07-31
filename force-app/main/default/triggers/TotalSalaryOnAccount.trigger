trigger TotalSalaryOnAccount on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    if( trigger.isBefore && trigger.isInsert ) {

        TotalSalaryOnAccountHandler.onBeforeInsert(trigger.new);

    } else if( trigger.isAfter && trigger.isInsert ) {

        TotalSalaryOnAccountHandler.onAfterInsert(trigger.new);

    } else if( trigger.isBefore && trigger.isUpdate ){

        TotalSalaryOnAccountHandler.onBeforeUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isAfter && trigger.isUpdate ) {

        TotalSalaryOnAccountHandler.onAfterUpdate(trigger.new, trigger.oldMap);
         
    } else if( trigger.isBefore && trigger.isDelete ) {

        TotalSalaryOnAccountHandler.onBeforeDelete(trigger.old);

    } else if ( trigger.isAfter && trigger.isDelete ) {

       TotalSalaryOnAccountHandler.onAfterDelete(trigger.old);

    } else if ( trigger.isAfter && trigger.isUndelete ) {

        TotalSalaryOnAccountHandler.onAfterUndelete(trigger.new);

    }  
}