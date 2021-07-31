trigger TestOfContact on Contact (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

      if( trigger.isBefore && trigger.isInsert ) {

        TestOfContactHandler.onBeforeInsert(trigger.new);

    } else if( trigger.isAfter && trigger.isInsert ) {

        TestOfContactHandler.onAfterInsert(trigger.new);

    } else if( trigger.isBefore && trigger.isUpdate ) {

        //TestOfContactHandler.onBeforeUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isAfter && trigger.isUpdate ) {

        TestOfContactHandler.onAfterUpdate(trigger.new, trigger.oldMap);

    } else if( trigger.isBefore && trigger.isDelete ) {

        //TestOfContactHandler.onBeforeDelete(trigger.old);

    } else if ( trigger.isAfter && trigger.isDelete ) {

        TestOfContactHandler.onAfterDelete(trigger.oldMap);

    } else if ( trigger.isAfter && trigger.isUndelete ) {

        //TestOfContactHandler.onAfterUndelete(trigger.new);

    }  
     
    
}