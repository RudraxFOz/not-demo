public class CallHelperByTrigger {
    
    public Static Matter__Share insertRec(List<Matter_Team_Member__c> insertList) {
        Matter__Share MatterShare = new Matter__Share();
        for (Matter_Team_Member__c job : insertList) {
            MatterShare.ParentId = job.Matter__c;
            System.debug('--Matt--'+ MatterShare.ParentId);
            if(job.User__c != null) {
                System.debug('--Helloe user');
                MatterShare.UserOrGroupId = job.User__c;
            } else {
                System.debug('--Helloe user Second');
                MatterShare.UserOrGroupId = job.OwnerId;
            }
            MatterShare.AccessLevel = 'edit';
            MatterShare.RowCause = Schema.Matter__Share.RowCause.MatterApexReason__c; 
        }
        return MatterShare;
    }
    
}