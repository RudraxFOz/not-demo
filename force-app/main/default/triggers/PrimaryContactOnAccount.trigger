trigger PrimaryContactOnAccount on Contact (before insert, after insert, before update, before delete) {

    if( trigger.isBefore && trigger.isInsert ) {
        PrimaryContactOnAccountHandler.onBeforeInsert(trigger.new);

    } else if( trigger.isAfter && trigger.isInsert ) {
        PrimaryContactOnAccountHandler.onAfterInsert(trigger.new);

    } else if( trigger.isBefore && trigger.isUpdate ) {
        PrimaryContactOnAccountHandler.onBeforeUpdate(trigger.new);

    } /*else if( trigger.isAfter && trigger.isUpdate ) {
        PrimaryContactOnAccountHandler.onAfterUpdate(trigger.new);

    }*/ else if( trigger.isBefore && trigger.isDelete ) {
        PrimaryContactOnAccountHandler.onBeforeDelete(trigger.old);
    }

    // } else if ( trigger.isAfter && trigger.isDelete ) {
    //     //PrimaryContactOnAccountHandler.onAfterDelete(trigger.new);

    // } else if ( trigger.isAfter && trigger.isUndelete ) {
    //     //PrimaryContactOnAccountHandler.onAfterUndelete(trigger.new);

    // }  

}