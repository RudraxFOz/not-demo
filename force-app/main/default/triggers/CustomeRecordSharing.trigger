/**
* @ description : CustomeRecordSharing trigger That is use for call the CustomeRecordSharingHandler class.
* @ author      : Suresh Kumar
* @ date        : 02/07/2019
* @ Modify date  : 
* @ Modify By  : 
*/
trigger CustomeRecordSharing on Matter_Team_Member__c (before insert, after update, after insert, before update, before delete, after delete, after undelete) {
    
    if (trigger.isBefore && trigger.isInsert) {
       CustomeRecordSharingHandler.onBeforeInsert(trigger.new);     
    } 
    else if(trigger.isAfter && trigger.isInsert) {
        CustomeRecordSharingHandler.onAfterInsert(trigger.new);  
    } 
    else if(trigger.isBefore && trigger.isUpdate) {
        CustomeRecordSharingHandler.onBeforeUpdate(trigger.new, trigger.oldMap); 
    } 
     if (trigger.isAfter && trigger.isUpdate) { 
        CustomeRecordSharingHandler.onAfterUpdate( trigger.new, trigger.oldMap);   
    } 
    if(trigger.isBefore && trigger.isDelete) {
        //CustomeRecordSharingHandler.onBeforeDelete(trigger.old); 
    } 
    if(trigger.isAfter && trigger.isDelete) {
       // CustomeRecordSharingHandler.onAfterDelete(trigger.old); 
    }  
    if(trigger.isAfter && trigger.isUndelete) {
        CustomeRecordSharingHandler.onAfterUndelete(trigger.new); 
    }
}