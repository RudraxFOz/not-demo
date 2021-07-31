trigger PlatformEventPublish on Account (after insert, after update) {
    If(trigger.isAfter && trigger.isUpdate){
        List<Notification__e> publishEvents = new List<Notification__e>();
        for(Account a : Trigger.new){
            Notification__e eve = new Notification__e();
            eve.Name__c = a.Name ; 
            //eve.Phone__c = a.Phone ; 
            publishEvents.add(eve);            
        }
        if(publishEvents.size()>0){
            EventBus.publish(publishEvents);
        }
        
    }
    
}