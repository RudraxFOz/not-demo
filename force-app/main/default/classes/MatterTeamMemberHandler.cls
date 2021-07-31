public with sharing class MatterTeamMemberHandler {
     //Map to matter record id and related user Id
    public static Map<Id, Id> mapOfMatterIdAndUserId =  new Map<Id, Id>();
    //Map to matter record id and related user from where we will remove the access
    public static Map<Id, Id> removePermissionMap =  new Map<Id, Id>();
    
    //This method will trigger after insert matter team member record
    public static void OnAfterInsert(Matter_Team_Member__c[] newMatterTeamMember) {
        
        for(Matter_Team_Member__c matt : newMatterTeamMember){
            if(matt.Matter__c != null)
                mapOfMatterIdAndUserId.put(matt.Matter__c,matt.User__c );
        }
        // call method that provide access to matter record for user
        assignPermissionToUsers(mapOfMatterIdAndUserId);
    }
    public static void OnAfterUpdate(Matter_Team_Member__c[] newMatterTeamMember ,Map<Id,Matter_Team_Member__c > triggerOldMap){
       
       // For loop to iterate matter team member
       for(Matter_Team_Member__c  matt :newMatterTeamMember){
          
           //Check the condition and create a map when both user and matter is changes on matter team member
           if(matt.User__c != triggerOldMap.get(matt.id).User__c && matt.Matter__c != triggerOldMap.get(matt.id).Matter__c){
                mapOfMatterIdAndUserId.put(matt.Matter__c,matt.User__c );
                removePermissionMap.put(triggerOldMap.get(matt.id).Matter__c,  triggerOldMap.get(matt.id).User__c);
           }
           //Check the condition and create a map when user change on matter team member
           else if(matt.User__c != triggerOldMap.get(matt.id).User__c && matt.Matter__c == triggerOldMap.get(matt.id).Matter__c){
                mapOfMatterIdAndUserId.put(matt.Matter__c,matt.User__c );
                removePermissionMap.put(matt.Matter__c,  triggerOldMap.get(matt.id).User__c);
           }
            //Check the condition and create a map when  matter change on matter team member
           else if(matt.Matter__c != triggerOldMap.get(matt.id).Matter__c && matt.User__c == triggerOldMap.get(matt.id).User__c){
                mapOfMatterIdAndUserId.put(matt.Matter__c,matt.User__c );
                removePermissionMap.put(triggerOldMap.get(matt.id).Matter__c,  matt.User__c);
           }
       }
       // call method that provide remove access to matter record for user
       removePermissionToUsers(removePermissionMap);
       // call method that provide access to matter record for user
       assignPermissionToUsers(mapOfMatterIdAndUserId); 
    }
    //This method will execute when we will delete matter team member records
    public static void OnAfterDelete(Matter_Team_Member__c[] deletedMatterTeamMember) {
       
        for(Matter_Team_Member__c matt : deletedMatterTeamMember){
            if(matt.Matter__c != null)
                removePermissionMap.put(matt.Matter__c,matt.User__c );
        }
        removePermissionToUsers(mapOfMatterIdAndUserId);   
    }
   //This method provide the access to user for selected matter record
   public static void assignPermissionToUsers(Map<Id, Id> mapOfMatterIdAndUserId){
        
        List<Matter__Share > matterShareList = new List<Matter__Share >();
        for(Id matterId : mapOfMatterIdAndUserId.keyset()) {
            Matter__Share matteObject = new Matter__Share();
            matteObject.ParentId= matterId;
            matteObject.UserOrGroupId= mapOfMatterIdAndUserId.get(matterId);
            matteObject.AccessLevel = 'Edit';
            matterShareList.add(matteObject);
        }
        if(matterShareList.size()>0){
            Database.SaveResult[] sr = Database.insert(matterShareList,false);
        }
    }
    //This methos remove the access from the user
    public static void removePermissionToUsers(Map<Id, Id> removePermissionMap) {
        
        List<Matter__Share> sharesToUpdateOld = [SELECT Id ,UserOrGroupId FROM Matter__Share WHERE ParentId IN :removePermissionMap.keyset() And UserOrGroupId IN :removePermissionMap.values()  AND RowCause = 'Manual'];
        if(!sharesToUpdateOld.isEmpty() ){
            Database.Delete(sharesToUpdateOld, false);
        }
    }
}