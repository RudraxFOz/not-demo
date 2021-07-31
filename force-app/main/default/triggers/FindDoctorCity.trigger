trigger FindDoctorCity on Doctor__c (before insert, after insert) {
    
    if(trigger.isAfter && trigger.isInsert) {
        Set<String> strSet = new Set<String>();
        List<DoctorClinic__c> docCliList = new List<DoctorClinic__c>();
        Map<Id,Doctor__c> docMap = new Map<Id,Doctor__c>(trigger.newMap);
        for(Doctor__c doc : trigger.new){
            strSet.add(doc.City__c);
        }
        
        //List<Clinic__c> cliList = ;
        //
        for(Clinic__c clinic : [SELECT Id, Name, City__c FROM Clinic__c WHERE City__c IN : strSet LIMIT 10]) {
            DoctorClinic__c docCliObj = new DoctorClinic__c();
            for(Doctor__c doc : trigger.new){
                docCliObj.Doctor__c = doc.Id;
                docCliObj.Clinic__c = clinic.Id;
                docCliList.add(docCliObj);
            }
        }
        if(docCliList.size() > 0){
            Insert docCliList;
        }
    }

}