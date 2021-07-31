/**
* @ description : CustomeRecordSharingHandler class for CustomeRecordSharing trigger That is use for custome apex sharing 
                  for particuller user that assingn by us.
* @ author      : Suresh Kumar
* @ date        : 02/07/2019
* @ Modify date  : 
* @ Modify By  : 
*/

public with sharing class CustomeRecordSharingHandler {   

    public Static Map<Id,Matter_Team_Member__c> mapForDel = new Map<Id,Matter_Team_Member__c>();
    public Static List<Matter_Team_Member__c> listOfMatterMember = new List<Matter_Team_Member__c>();
    public Static List<User> userProfileName = [SELECT Id, Name, Profile.Name FROM User WHERE Profile.Name = 'System Administrator'];
    public Static void onBeforeInsert(List<Matter_Team_Member__c> newInsertList) { 
        insertRecordForCustomeSharing(newInsertList);
    }
    
    public Static void onAfterInsert(List<Matter_Team_Member__c> newInsertList) { 
        //insertRecordForCustomeSharing(newInsertList);
    }

    public Static void onBeforeUpdate(List<Matter_Team_Member__c> newListForInsert, Map<Id,Matter_Team_Member__c> oldMapForDelete) { 

        System.debug('==oldListForDelete=='+oldMapForDelete);
        System.debug('==newListForInsert=='+newListForInsert);
        Integer count = 0 ;
        System.debug('==newListForInsert=='+newListForInsert.Size());
        Integer sizeChangeInInteger = Integer.valueof(newListForInsert.Size());
        System.debug('==sizeChangeInInteger=='+sizeChangeInInteger);
        for(Matter_Team_Member__c newTest : newListForInsert ) {
            if( newTest.Matter__c != oldMapForDelete.get(newTest.Id).Matter__c && newTest.User__c != oldMapForDelete.get(newTest.Id).User__c ) {
                mapForDel.put(newTest.Id, oldMapForDelete.values());
                listOfMatterMember.add(newTest);
            } else if( newTest.Matter__c != oldMapForDelete.get(newTest.Id).Matter__c && newTest.User__c == oldMapForDelete.get(newTest.Id).User__c ) {
                mapForDel.put(newTest.Id, oldMapForDelete.values());
                listOfMatterMember.add(newTest);
            } else if( newTest.Matter__c == oldMapForDelete.get(newTest.Id).Matter__c && newTest.User__c != oldMapForDelete.get(newTest.Id).User__c ) {
                mapForDel.put(newTest.Id, oldMapForDelete.values());
                listOfMatterMember.add(newTest);
            } else {
                System.debug('Nothing change in field');
                count ++;
            }
        }
        System.debug('count++'+count);
        if(sizeChangeInInteger != count) {
            deleteRecordForCustomeSharing(mapForDel);
            insertRecordForCustomeSharing(listOfMatterMember);
        }    
        
    }
    public Static void onAfterUpdate( List<Matter_Team_Member__c> newListForInsert, Map<Id,Matter_Team_Member__c> oldMapForDelete) { 
       
    }
    public Static void onBeforeDelete(List<Matter_Team_Member__c> beforeDeleteList) { 
        
    }
    public Static void onAfterDelete(List<Matter_Team_Member__c> afterDeleteList) { 
        
    }
    public Static void onAfterUndelete(List<Matter_Team_Member__c> newUndeleteList) { 
        insertRecordForCustomeSharing(newUndeleteList);      
    }



    public Static void insertRecordForCustomeSharing(List<Matter_Team_Member__c> insertNewRecord) {
        
        System.debug('welcome insert');
        Map<Id,Id> mapOfOwner = new Map<Id,Id>();
        Map<Id,User> mapOfUser = new Map<Id,User>(userProfileName);
        System.debug('---mapOfUser---'+mapOfUser);
        System.debug('---userProfileName---'+userProfileName);
        List<Matter__Share> sharesToCreate = new List<Matter__Share>();
        Set<String> idOFCurrentUser = new Set<String>();
        List<String> idOFSystemAdmin = new List<String>();
        for (Matter_Team_Member__c job : insertNewRecord) {
           if(job.User__c != null) {
                mapOfOwner.put(job.matter__c, job.User__c);
            }
           
        }
        
        List<Matter_Team_Member__c> member = [SELECT Id, Name, Matter__c, User__c FROM Matter_Team_Member__c WHERE Matter__c IN:mapOfOwner.keyset() AND User__c IN:mapOfOwner.values()];
        Map<Id,Matter_Team_Member__c> mapForRemoveDublicate = new Map<Id,Matter_Team_Member__c>();
        Map<Id,Matter_Team_Member__c> mapForRemoveDu = new Map<Id,Matter_Team_Member__c>();
        for( Matter_Team_Member__c job : member ) {
            mapForRemoveDublicate.put(job.Matter__c, job);
            mapForRemoveDu.put(job.User__c, job);
        }
       
        System.debug('---member--'+member);
        for (Matter_Team_Member__c job : insertNewRecord) {
            idOFCurrentUser.add(job.User__c);
            //System.debug('---!!!!!!!+++=====---'+mapForRemoveDublicate.containsKey(job.Matter__c) );
            if(!mapForRemoveDublicate.containsKey(job.Matter__c) || !mapForRemoveDu.containsKey(job.User__c)) {
                System.debug('---come only alred not user');
                if(!mapOfUser.containsKey(job.User__c) ) {
                    Matter__Share MatterShare = new Matter__Share();
                    System.debug('not come inside');
                    MatterShare.ParentId = job.Matter__c;
                    if(job.User__c != null) {
                        System.debug('--Helloe user');
                        MatterShare.UserOrGroupId = job.User__c;
                    } else {
                        System.debug('--Helloe user Second');
                        MatterShare.UserOrGroupId = job.OwnerId;
                    }
                    MatterShare.AccessLevel = 'edit';
                    MatterShare.RowCause = Schema.Matter__Share.RowCause.MatterApexReason__c; 
                    sharesToCreate.add(MatterShare);
                } else {
                    System.debug('Deep Singh ka bhai');
                    idOFSystemAdmin.add(job.User__c);  
                }
            } else {
                System.debug('This record is alread assing'); 
                job.addError('This record is alread assing');
            }
        }
        System.debug('@@@@@@'+!idOFCurrentUser.retainAll(idOFSystemAdmin));
        if (!sharesToCreate.isEmpty() && !idOFCurrentUser.retainAll(idOFSystemAdmin)) {
            //insert sharesToCreate;
            System.debug('hello mere dost');
            Database.insert(sharesToCreate, false);
        }
    }

    public Static void deleteRecordForCustomeSharing(Map<Id,Matter_Team_Member__c> deleteMap) {
        System.debug('welcome delete');
        List<ID> shareIdsToDelete = new List<ID>();
        System.debug('==deleteMap.values()=='+deleteMap.values());
        for (Matter_Team_Member__c job : deleteMap.values()) {
            System.debug('---oldJob'+job);
            shareIdsToDelete.add(deleteMap.get(job.Id).Matter__c);       
        }
        List<Matter__Share> shareListToDelete = [SELECT Id FROM Matter__Share WHERE ParentId  IN : shareIdsToDelete AND RowCause = 'MatterApexReason__c' ];  
        system.debug('shares records : ' + shareListToDelete);
        if(!shareListToDelete.isEmpty()) {
            Database.delete(shareListToDelete, false);
        }
    }  
}