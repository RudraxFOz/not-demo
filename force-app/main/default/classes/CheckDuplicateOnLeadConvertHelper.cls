public with sharing class CheckDuplicateOnLeadConvertHelper {

    public Static void checkDuplicateRecord(List<Lead> newLeadList){

        Set<String> newFirstNameSet = new Set<String>();

        Set<String> newLastNameSet = new Set<String>();

        Set<String> newEmailSet = new Set<String>();

        Set<String> newPhoneSet = new Set<String>();


        List<Lead> leadRecordList1 = new List<Lead>();

        Set<String> oldFirstNameSet = new Set<String>();

        Set<String> oldLastNameSet = new Set<String>();

        Set<String> oldEmailSet = new Set<String>();

        Set<String> oldPhoneSet = new Set<String>();


        


    for(Lead newLead : newLeadList){
  

            newFirstNameSet.add(newLead.FirstName);

        
            newLastNameSet.add(newLead.LastName);
            newEmailSet.add(newLead.Email);

            newPhoneSet.add(newLead.Phone);

        }

        for(Lead oldLead : [SELECT id,FirstName, LastName, email, Phone FROM lead WHERE FirstName IN: newFirstNameSet OR LastName IN: newLastNameSet OR Email IN: newEmailSet  OR Phone IN: newPhoneSet LIMIT 50000]){


            oldFirstNameSet.add(oldLead.FirstName);

            oldLastNameSet.add(oldLead.LastName);

            oldEmailSet.add(oldLead.Email);
            oldPhoneSet.add(oldLead.Phone);
            

        }

        for(Lead newLead : newLeadList){
            if (newLead.IsConverted) {
                
            } else {
                if(oldFirstNameSet.contains(newLead.FirstName) || oldLastNameSet.Contains(newLead.LastName) || oldEmailSet.contains(newLead.Email) || oldPhoneSet.Contains(newLead.Phone)) {

                    newLead.addError('You are inserting Duplicate lead');
                } else {
                    
                    leadRecordList1.add(newLead);
                }
            }      
       }
        //insert leadRecordList1;
        

    }

}