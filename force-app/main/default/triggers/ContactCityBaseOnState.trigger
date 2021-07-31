trigger ContactCityBaseOnState on Contact (before insert, after insert) {
    if(trigger.isBefore && trigger.isInsert) {
        List<Contact> conList = new List<Contact>();
        Set<String> cityValue = new Set<String>();
        Contact conObj = new Contact();
        //ZipCodevalue__c
            for(Contact con : trigger.new){
                cityValue.add(con.City__c);  
            }
        
            for(ZipCodevalue__c stateValue : [SELECT Id, Name, State__c, City__c FROM ZipCodevalue__c WHERE City__c IN : cityValue 
                                              LIMIT 50000]) {
               for(Contact con : trigger.new){
                   if(stateValue.City__c == con.City__c){
                     con.State__c = stateValue.State__c;  
                   }
                     
               }
               //conObj.Id =                                    
               //conList.add(conObj);                                                                       
            }
        
            if(conList.size() >0){
                //update conList;
            }
    }
       

}