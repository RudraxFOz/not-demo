trigger MyStudentOnTrigger on MyStudent__c (after insert,after update,after delete,after undelete) {
    if(Trigger.isInsert) {
        HelperForSummaryRoll.fact();
    }
     if(Trigger.isUpdate) {
        HelperForSummaryRoll.fact();
    }
     if(Trigger.isDelete) {
        HelperForSummaryRoll.fact();
    }
     if(Trigger.isUndelete) {
        HelperForSummaryRoll.fact();
    }

}