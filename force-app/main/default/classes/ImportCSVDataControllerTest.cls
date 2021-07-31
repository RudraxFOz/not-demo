@isTest 
public with sharing class ImportCSVDataControllerTest {

    static String str = 'NPI__c,FirstName,LastName,City\n fdgfdddfdddf45dd45,Prosfpect,Tesft,Bfankingf1,\n fdgdf4dffddsdasass545,Profspect,Tfest,Bankinffg1';       

    public static String[] csvFileLines;
    public static Blob csvFileBody;
    public static 
    Map<String,Contact> conMap1 = new Map<String,Contact>();
    

    static testmethod void testfileupload(){
        List<CampaignMember> campaignMemberListtoInsert = new List<CampaignMember>();
        Test.startTest();       
        ImportCSVDataController obj = new ImportCSVDataController();
        //campaign = 'hfghgfh';
        Campaign  cam = obj.campaign;
        cam.Name = 'gfghfgh';
        insert cam;
        csvFileBody = Blob.valueOf(str);
        String csvAsString = csvFileBody.toString();
        csvFileLines = csvAsString.split('\n'); 
         for (Integer i=0 ;i <20; i++) {
            Contact con = new Contact();
            con.NPI__c = 'fdgfhhdhf'+i ;
            con.LastName = 'TeshghtLastName' + i ;
            con.City__c = 'Cihhty'+i ;
            conMap1.put(con.NPI__c,con);      
        }

        if (!conMap1.Values().isEmpty()) {
            insert conMap1.values() ;
        }

        for (Contact con : [SELECT Id,Name,NPI__c FROM Contact  LIMIT 50000]) {
            System.debug(con.Name +' : '+con.Id);

            CampaignMember camMember = new CampaignMember();
            camMember.ContactId = con.Id;
            camMember.CampaignId = cam.Id;
            camMember.Status = 'Sent' ;
            campaignMemberListtoInsert.add(camMember);

        }
        System.debug(campaignMemberListtoInsert);
        if (campaignMemberListtoInsert.size() > 0) {
            insert campaignMemberListtoInsert ;
        }

       
        obj.csvBodyData = csvFileBody;
        obj.importCSVFile();
        Test.stopTest();
    } 
}