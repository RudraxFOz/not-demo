trigger TestProject1 on Matter_Team_Member__c (before insert, after update) {
    
    // inserting new records
    if (Trigger.isInsert) {
        List<Matter__Share> sharesToCreate = new List<Matter__Share>();
        Matter__Share MatterShare =  CallHelperByTrigger.insertRec(trigger.new);
        sharesToCreate.add(MatterShare);
        if (!sharesToCreate.isEmpty()) {
            insert sharesToCreate;
        }
        
    } else if (Trigger.isUpdate) { 
        System.debug('==oldMap=='+trigger.oldMap);
        List<Matter__Share> sharesToCreate = new List<Matter__Share>();
        List<Matter_Team_Member__c> oldList = new List<Matter_Team_Member__c>();
        List<ID> shareIdsToDelete = new List<ID>();
        for (Matter_Team_Member__c job : Trigger.old) {
            System.debug('---oldJob'+job);
            shareIdsToDelete.add(job.Matter__c);
        }
        
        List<Matter_Team_Member__c> checkAllMember = [ SELECT Id, Name, Matter__c FROM Matter_Team_Member__c WHERE Matter__c IN : shareIdsToDelete];
        System.debug('---checkAllMember---'+checkAllMember);
        
        for (Matter_Team_Member__c job : checkAllMember) {
            
                        
        }
        List<Matter__Share> shareListToDelete = [SELECT Id FROM Matter__Share WHERE ParentId  IN : shareIdsToDelete AND RowCause = 'MatterApexReason__c' ];  
       //List<Matter_Team_Member__Share> shareListToDelete = [ SELECT Id FROM Matter_Team_Member__Share WHERE ParentId  IN : shareIdsToDelete ];
        system.debug('shares records : ' + shareListToDelete);
        if(!shareListToDelete.isEmpty()) {
            system.debug('Successfully delete : ');
            Database.delete(shareListToDelete, false);
        }
        List<Matter__Share> sharesToCreateAfterUpdate = new List<Matter__Share>();
        Matter__Share MatterShare =  CallHelperByTrigger.insertRec(trigger.new);
        sharesToCreateAfterUpdate.add(MatterShare);
        if (!sharesToCreateAfterUpdate.isEmpty()) {
            insert sharesToCreateAfterUpdate;
        }
    }
}