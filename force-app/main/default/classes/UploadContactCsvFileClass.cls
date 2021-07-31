public with sharing class UploadContactCsvFileClass {

    @AuraEnabled
    public static string insertData(String strfromJson, String camaignName, String camaignMemberStatus) {
        Map<String, Contact> conMapFormOrg = new Map<String, Contact>();
        String returnresponse ='';
        Map<String,Contact> contactListtoInsertMap = new Map<String,Contact>();
        List<CampaignMember> campaignMemberListtoInsert = new List<CampaignMember>();
        System.debug('==strfromJson=='+strfromJson);
        List<FieldWrapper> datalist = (List<FieldWrapper>) JSON.deserialize(strfromJson, List<FieldWrapper>.class);
        System.debug('==datalist=='+datalist);
        for (Contact conRec : [SELECT Id,Name,NPI__c FROM Contact WHERE NPI__c != null LIMIT 50000]) {
            conMapFormOrg.put(conRec.NPI__c, conRec);
        }
        for(FieldWrapper wrapper: datalist) {
            if (conMapFormOrg.containsKey(wrapper.NPI)) {
               System.debug('This Record is alread exites');
            } else {
                Contact con = new Contact();
                con.NPI__c = wrapper.NPI;
                con.FirstName = wrapper.FirstName;
                con.LastName  = wrapper.LastName;
                con.City__c = wrapper.City;
                contactListtoInsertMap.put(con.NPI__c,con);
            }
        }

        if(!contactListtoInsertMap.values().isEmpty()) {
            try {
                System.debug('==contactListtoInsert='+contactListtoInsertMap.values());
                insert contactListtoInsertMap.values();
                returnresponse = 'SUCCESS';
            }
            catch(Exception ex) {
                returnresponse = 'ERROR';
            }
        }
        if (camaignName != '') {
            System.debug(camaignName);
            Campaign cam = new Campaign();
            cam.Name = camaignName ;
            insert cam;
            
            Campaign camValue = [SELECT Id,Name FROM Campaign WHERE Name =: camaignName LIMIT 1];
            for (Contact contact : [SELECT Id,Name,NPI__c FROM Contact WHERE NPI__c IN : contactListtoInsertMap.keyset()]) {
                CampaignMember camMember = new CampaignMember();
                camMember.ContactId = contact.Id;
                camMember.CampaignId = camValue.Id;
                System.debug(camMember.CampaignId);
                camMember.Status = camaignMemberStatus ;
                campaignMemberListtoInsert.add(camMember);
            }

            if(campaignMemberListtoInsert.size() > 0) {
                try {
                    System.debug('==campaignMemberListtoInsert='+campaignMemberListtoInsert);
                    insert campaignMemberListtoInsert;
                    returnresponse = 'SUCCESS';
                }
                catch(Exception ex) {
                    returnresponse = 'ERROR';
                }
            }
        }
        return returnresponse;

    }
  
    public class FieldWrapper {
        public String NPI;
        public String FirstName;
        public String LastName;
        public String City;  
    } 
}