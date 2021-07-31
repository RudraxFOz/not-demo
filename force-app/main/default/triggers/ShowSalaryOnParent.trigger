trigger ShowSalaryOnParent on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    
    if( trigger.isBefore && trigger.isInsert ) {
        ShowSalaryOnParentHandler1.onBeforeInsert(trigger.new);

    } else if( trigger.isAfter && trigger.isInsert ) {
        ShowSalaryOnParentHandler1.onAfterInsert(trigger.new);

    } else if( trigger.isBefore && trigger.isUpdate ) {
        //ShowSalaryOnParentHandler1.onBeforeUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isAfter && trigger.isUpdate ) {
        ShowSalaryOnParentHandler1.onAfterUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isBefore && trigger.isDelete ) {
        //ShowSalaryOnParentHandler1.onBeforeDelete(trigger.old);
    } else if ( trigger.isAfter && trigger.isDelete ) {
        ShowSalaryOnParentHandler1.onAfterDelete(trigger.old);

    }// else if ( trigger.isAfter && trigger.isUndelete ) {
    //     //ShowSalaryOnParentHandler1.onAfterUndelete(trigger.new);

    // }  
     
}