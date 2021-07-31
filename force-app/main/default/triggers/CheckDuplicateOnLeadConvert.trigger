trigger CheckDuplicateOnLeadConvert on Lead (before insert, before update) {
    


    if(Trigger.isInsert && Trigger.isBefore){
        CheckDuplicateOnLeadConvertHelper.checkDuplicateRecord(Trigger.new);

    } else if(Trigger.isUpdate && Trigger.isBefore){
        System.debug('==Trigger.new=='+Trigger.new);
        CheckDuplicateOnLeadConvertHelper.checkDuplicateRecord(Trigger.new);

    }


        // //We created a Map to insert or Leads
        // Map<String, Lead> leadMap =new Map<String, Lead>();
        
        // for (Lead lead : System.Trigger.new) {
        
        // //We want to target those new leads with a Phone and compare them with the phones
        // //of leads that are already in our database. 
        // if ((lead.Phone !=null) && (System.Trigger.isInsert || (lead.Phone != System.Trigger.oldMap.get(lead.Id).Phone))) {
        // //Firing error if we find a lead that already has the same Phone 
        //     if (leadMap.containsKey(lead.Phone)) {
        //             lead.Phone.addError('Another new lead has the same Phone address.');
        // //If not found, we add the lead to our leadMap
        //     }else{
        //         leadMap.put(lead.Phone, lead);
        //     }
        // }
        
        // //Same operation but targeting the MobilePhone
        // if ((lead.MobilePhone !=null) && (System.Trigger.isInsert || (lead.MobilePhone != System.Trigger.oldMap.get(lead.Id).MobilePhone))) {
        //     if (leadMap.containsKey(lead.MobilePhone)) {
        //             lead.MobilePhone.addError('Another new lead has the same Phone address.');
        // //If not found, we add the lead to our leadMap
        //     }else{
        //         leadMap.put(lead.MobilePhone, lead);
        //     }
        // }
        // }
        
        // //We query our Leads and use the Phone as the reference. If found on our map, throw an error 
        // for (Lead lead: [SELECT Phone FROM Lead WHERE Phone IN :leadMap.KeySet()]) {
        //     Lead newLead = leadMap.get(lead.Phone);
        // //Error needs to be on the field that is causing it, in this case, the Phone field 
        //     newLead.Phone.addError('A lead with this Phone address already exists.');
        // }
        
        // //We query our Leads and use the Mobile Phone as the reference. If found on our map, throw an error 
        // for (Lead lead: [SELECT MobilePhone FROM Lead WHERE MobilePhone IN :leadMap.KeySet()]) {
        //     Lead newLead = leadMap.get(lead.MobilePhone);
        // //Error needs to be on the field that is causing it, in this case, the Mobile Phone field 
        //     newLead.MobilePhone.addError('A lead with this Mobile Phone address already exists.');
        // }

}