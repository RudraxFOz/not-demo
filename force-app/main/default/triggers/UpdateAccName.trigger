trigger UpdateAccName on Account (before insert, after insert, before update, after update) {
    
    //System.debug('==accMap=='+accMap);
    if(trigger.isBefore && trigger.isUpdate){ 
		 
    }
    if(trigger.isAfter && trigger.isUpdate){
        Set<Id> accIds = new Set<Id>();
        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        Map<Id,Account> accMap = new Map<Id,Account>(trigger.oldMap);
        
        for(Account acc : [SELECT Id, Name, NameUpdate__c FROM Account WHERE Id IN : trigger.new LIMIT 50000]) {
            If(acc.Name != accMap.get(acc.Id).Name) {
                System.debug('==acc.Name=='+acc.Name);
                //acc.Name = acc.Name;
                acc.NameUpdate__c = true;
                accIds.add(acc.Id);
                System.debug('==accIds=='+accIds); 
                System.debug('==acc.Name==11=='+acc.Name);
                accList.add(acc);
            }
        }    
        if(accList.size() > 0) {
            System.debug('==accList=='+accList);
            update accList;
        }
        if(accIds.size() > 0){
        	for(Account acc : [SELECT Id, Name, NameUpdate__c, (SELECT Id, FirstName, LastName, Name FROM Contacts), 
                          		(SELECT Id, Name FROM Opportunities) FROM Account WHERE NameUpdate__c = true AND
                           		Id IN : accIds LIMIT 50000]) {
                        System.debug('==acc=='+acc);
                  for(Contact con : acc.Contacts) {
                      	 con.LastName = acc.Name;  
                      	 conList.add(con);
                  }
                  for(Opportunity opp : acc.Opportunities) {
                        System.debug('==opp=='+opp);
                  		opp.Name = acc.Name;  
                      	//con.LastName = acc.Name;  
                      	oppList.add(opp);
                  }             
         	}
            
            if(conList.size() > 0) {
                System.debug('==conList=='+conList);
                update conList;
            }
            if(oppList.size() > 0) {
                System.debug('==oppList=='+oppList);
                update oppList;
            }
        }
     }

}