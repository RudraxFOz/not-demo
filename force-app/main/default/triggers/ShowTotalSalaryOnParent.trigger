trigger ShowTotalSalaryOnParent on Contact (before insert, after insert, before update, after update, after delete, after undelete) {

    if( trigger.isBefore && trigger.isInsert ) {
        ShowTotalSalaryOnParentHandler.onBeforeInsert(trigger.new);

    } else if( trigger.isAfter && trigger.isInsert ) {
        ShowTotalSalaryOnParentHandler.onAfterInsert(trigger.new);

    } else if( trigger.isBefore && trigger.isUpdate ) {
        //ShowTotalSalaryOnParentHandler.onBeforeUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isAfter && trigger.isUpdate ) {
        ShowTotalSalaryOnParentHandler.onAfterUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isBefore && trigger.isDelete ) {
        //ShowTotalSalaryOnParentHandler.onBeforeDelete(trigger.old);
    } else if ( trigger.isAfter && trigger.isDelete ) {
        ShowTotalSalaryOnParentHandler.onAfterDelete(trigger.oldMap);

    }// else if ( trigger.isAfter && trigger.isUndelete ) {
    //     //ShowTotalSalaryOnParentHandler.onAfterUndelete(trigger.new);

    // }  

}