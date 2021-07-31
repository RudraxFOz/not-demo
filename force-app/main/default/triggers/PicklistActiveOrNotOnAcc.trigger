trigger PicklistActiveOrNotOnAcc on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    if( trigger.isBefore && trigger.isInsert ) {

        //PicklistActiveOrNotOnAccHandler.onBeforeInsert(trigger.new);

    } else if( trigger.isAfter && trigger.isInsert ) {

        PicklistActiveOrNotOnAccHandler.onAfterInsert(trigger.new);

    //} else if( trigger.isBefore && trigger.isUpdate ) {

        //PicklistActiveOrNotOnAccHandler.onBeforeUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isAfter && trigger.isUpdate ) {

        PicklistActiveOrNotOnAccHandler.onAfterUpdate(trigger.new, trigger.oldMap);

    //} else if( trigger.isBefore && trigger.isDelete ) {

        //PicklistActiveOrNotOnAccHandler.onBeforeDelete(trigger.old);

    } else if ( trigger.isAfter && trigger.isDelete ) {

        PicklistActiveOrNotOnAccHandler.onAfterDelete(trigger.oldMap);

    } else if ( trigger.isAfter && trigger.isUndelete ) {
        
        //PicklistActiveOrNotOnAccHandler.onAfterUndelete(trigger.new);

    }  
     
    
}