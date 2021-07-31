trigger TestProject on Matter_Team_Member__c (after insert,after update) {
    
    if(trigger.isInsert ) {
         // Create a new list of sharing objects for Job
        List<Matter__Share> jobShrs  = new List<Matter__Share>();
        Matter_Team_Member__Share matterObj;
        Matter__Share MatterShare ;
        for(Matter_Team_Member__c job : trigger.new){
            System.debug('trigger new---'+job);
            // Instantiate the sharing objects
            MatterShare = new Matter__Share();
            // Set the ID of record being shared
            MatterShare.ParentId = job.Matter__c;
            System.debug('--Matt--'+ MatterShare.ParentId);
            // Set the ID of user or group being granted access
            MatterShare.UserOrGroupId = job.User__c;
            // Set the access level
            MatterShare.AccessLevel = 'edit';
            //userObj.AccessLevel = 'read';    MatterApexReason__c
            MatterShare.RowCause = Schema.Matter__Share.RowCause.MatterApexReason__c; 
            System.debug('---MatterShare.RowCause--'+MatterShare.RowCause);
            // Add objects to list for insert
            jobShrs.add(MatterShare);
        }
        
        // Insert sharing records and capture save result 
        // The false parameter allows for partial processing if multiple records are passed 
        Database.SaveResult[] lsr = Database.insert(jobShrs,false);
        System.debug('---lsr@@--'+lsr); 
        Integer i=0;
        
        // Process the save results
        for(Database.SaveResult sr : lsr){
            System.debug('---sr--'+sr); 
            System.debug('---sr.....--'+sr.isSuccess());
            if(!sr.isSuccess()){
                // Get the first save result error
                Database.Error err = sr.getErrors()[0];
                System.debug('--err--'+err);
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                     &&  err.getMessage().contains('AccessLevel'))){
                         // Throw an error when the error is not related to trivial access level.
                         System.debug('---------------------->' + jobShrs[i]);
                         System.debug('---------------------->' + trigger.new);  
                         for( Matter_Team_Member__c matter : trigger.new ) {
                             if( matter.Matter__c == jobShrs[i].ParentId ) {
                                 matter.Matter__c.addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                             }
                         }
                     }
            }
            i++;
        }   
    } 
    if(trigger.isUpdate) {
            
        
        List<Matter_Team_Member__Share> oldShare = new List<Matter_Team_Member__Share>();
        List<Matter_Team_Member__c> oldShareList = new List<Matter_Team_Member__c>();
         List<Matter__Share> jobShrs  = new List<Matter__Share>();
        List<Matter__Share> jobShrsOld  = new List<Matter__Share>();
        Matter_Team_Member__Share matterObj;
        Matter__Share MatterShare ;
         Matter__Share MatterShareOld ;
        
        
        //List<Matter__Share> sharesToDelete = [SELECT Id 
                                               // FROM Matter__Share WHERE ParentId IN :trigger.old 
                                                //];
        
      //  System.debug('--sharesToDelete--'+sharesToDelete);
        //  if(!sharesToDelete.isEmpty()){
        //       Database.Delete(sharesToDelete, false);
            //} 
        
        
        //for(Matter_Team_Member__c job : trigger.old){
            //System.debug('trigger new---'+job);
            /* matterObj = new Matter_Team_Member__Share();
             matterObj.ParentId = job.Id;
             matterObj.UserOrGroupId = job.User__c;
             matterObj.AccessLevel = 'edit';
             matterObj.RowCause = Schema.Matter_Team_Member__Share.RowCause.Manual; */
             //oldShareList.add(job); 
            
        //}
        /*for(Matter__Share deleteOldShare : jobShrsOld) {
            if ( deleteOldShare.ParentId === sharesToDelete.Id) {
                    
                              
            }
            
        }
        System.debug('--oldShareList--'+oldShare);*/
        
        //Database.DeleteResult[] lsrDe = Database.delete(oldShareList,false);
        for(Matter_Team_Member__c job : trigger.new){
            System.debug('trigger new---'+job);
            // Instantiate the sharing objects
            MatterShare = new Matter__Share();
            // Set the ID of record being shared
            MatterShare.ParentId = job.Matter__c;
            System.debug('--Matt--'+ MatterShare.ParentId);
            // Set the ID of user or group being granted access
            MatterShare.UserOrGroupId = job.User__c;
            // Set the access level
            MatterShare.AccessLevel = 'edit';
            //userObj.AccessLevel = 'read';  
            MatterShare.RowCause = Schema.Matter__Share.RowCause.Manual; 
            System.debug('---MatterShare.RowCause--'+MatterShare.RowCause);
            // Add objects to list for insert
            jobShrs.add(MatterShare);
        }
        
        
        // Insert sharing records and capture save result 
        // The false parameter allows for partial processing if multiple records are passed 
        Database.SaveResult[] lsr = Database.insert(jobShrs,false);
        System.debug('---lsr@@--'+lsr); 
        Integer i=0;
        
        // Process the save results
        for(Database.SaveResult sr : lsr){
            System.debug('---sr--'+sr); 
            System.debug('---sr.....--'+sr.isSuccess());
            if(!sr.isSuccess()){
                // Get the first save result error
                Database.Error err = sr.getErrors()[0];
                System.debug('--err--'+err);
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                     &&  err.getMessage().contains('AccessLevel'))){
                         // Throw an error when the error is not related to trivial access level.
                         System.debug('---------------------->' + jobShrs[i]);
                         System.debug('---------------------->' + trigger.new);  
                         for( Matter_Team_Member__c matter : trigger.new ) {
                             if( matter.Matter__c == jobShrs[i].ParentId ) {
                                 matter.Matter__c.addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                             }
                         }
                     }
            }
            i++;
        }   
    }
}