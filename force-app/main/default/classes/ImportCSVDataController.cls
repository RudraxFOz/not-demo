/**
* @ description : This is ImportCSVDataController class for use insert the contact by csv file and download the insert fail contact csv file.
* @ author      : 
* @ date        : 
**/
public with sharing class ImportCSVDataController {

    public String csvInString{get;set;}
    public Blob csvBodyData{get;set;}
    @TestVisible private String[] readCSVData;
    @TestVisible  private Map<String, Contact> contactMap;
    @TestVisible private Map<String, Contact> contactMap1;
    @TestVisible private Map<String, Contact> allCSVContactMap;
    @TestVisible private Map<String, Contact> conFormOrgMap ;
    @TestVisible private Set<String> matchNPISet ;
    @TestVisible private List<CampaignMember> campaignMemberListtoInsert ;
    public Campaign campaign { get; set; }
    public CampaignMember campaignMember { get; set; }
    public String generatedCSVFile {get; set;}
    public List<String> fieldColum {get; set;}

    public ImportCSVDataController () {

        matchNPISet = new Set<String>();  
        allCSVContactMap = new Map<String, Contact>();
        fieldColum = new List<String>();
        readCSVData = new String[]{};
        contactMap = New  Map<String, Contact>(); 
        contactMap1 = New  Map<String, Contact>(); 
        conFormOrgMap = new Map<String, Contact>();
        campaignMemberListtoInsert = new List<CampaignMember>();
        campaign = new Campaign();
        campaignMember = new CampaignMember();
        generatedCSVFile = '';
    }

    public void importCSVFile() {
        // try {

            csvInString = csvBodyData.toString();
            readCSVData = csvInString.split('\n'); 
            System.debug('readCSVData='+readCSVData); 

            Campaign campaignObj = new Campaign();
            List<Campaign> campaignLst = [SELECT Id FROM Campaign WHERE Name =: campaign.Name LIMIT 1];
            System.debug(campaignLst);
            if (campaignLst.size() > 0) {
                campaignObj = campaignLst.get(0);
            } else {
                insert campaign;
            }

            for (Integer i=1; i<readCSVData.size(); i++) {
                List<String> csvContactData = readCSVData[i].split(',');
                Contact allCSVCon = new Contact() ;
                allCSVCon.NPI__c = csvContactData[0] ;             
                allCSVCon.FirstName = csvContactData[1];
                allCSVCon.LastName = csvContactData[2];
                allCSVCon.City__c = csvContactData[3]; 
                allCSVContactMap.put(allCSVCon.NPI__c, allCSVCon);
            }

			// * get the all contact that NPI number match from org.
            for (Contact conRec : [SELECT Id,Name,NPI__c FROM Contact WHERE NPI__c IN : allCSVContactMap.keySet() LIMIT 50000]) {
                conFormOrgMap.put(conRec.NPI__c, conRec);
            }
            
            System.debug(conFormOrgMap);
            //* Read the Csv file data and check the NPI is exits or not
            for (Integer i=1;i<readCSVData.size();i++) {
                List<String> csvContactData = readCSVData[i].split(',');
                if (conFormOrgMap.containsKey(csvContactData[0])) {
                    System.debug('==Alread record exits==');
                    CampaignMember camMember = new CampaignMember();
                    allCSVContactMap.get(csvContactData[0]).StatusManage__c = 'Alread record exits';
                    allCSVContactMap.get(csvContactData[0]).Id = conFormOrgMap.get(csvContactData[0]).Id ;
                    System.debug( allCSVContactMap.get(csvContactData[0]).Id );
                    camMember.ContactId = allCSVContactMap.get(csvContactData[0]).Id;
                    if (campaignLst.size() > 0) {
                        camMember.CampaignId = campaignObj.Id;
                    } else {
                        camMember.CampaignId = campaign.Id;
                    }
                    camMember.Status = campaignMember.Status ;
                    campaignMemberListtoInsert.add(camMember);
                } else {
                    Contact conObj = new Contact() ;
                    conObj.NPI__c = csvContactData[0] ;             
                    conObj.FirstName = csvContactData[1];
                    conObj.LastName = csvContactData[2];
                    conObj.City__c = csvContactData[3];                                                                           
                    contactMap.put(conObj.NPI__c,conObj);  
                }
            }
            System.debug(campaignMemberListtoInsert);

            Database.SaveResult[] conLst = Database.insert(contactMap.values(), false);
            //* Put the value of new insert contact and exits contact in contactMap
        	Boolean flag = false ;
        	List<String> insertConNPIList = new  List<String>(); 
        	for (Integer i = 0; i < contactMap.values().size(); i++) {
                Set<String> insertConNPISet = contactMap.keySet();
                insertConNPIList.addAll(insertConNPISet);
                if (conLst[i].isSuccess()) {
                    allCSVContactMap.get(insertConNPIList[i]).StatusManage__c = 'Success';
                    CampaignMember camMember = new CampaignMember();
                    camMember.ContactId = conLst[i].Id;
                    if (campaignLst.size() > 0) {
                        camMember.CampaignId = campaignObj.Id;
                    } else {
                        camMember.CampaignId = campaign.Id;
                    }
                    camMember.Status = campaignMember.Status ;
                    campaignMemberListtoInsert.add(camMember);
                } else {
                    flag = true ;
                    CampaignMember camMember = new CampaignMember();
                    for (Database.Error err : conLst[i].getErrors()) {
                        allCSVContactMap.get(insertConNPIList[i]).StatusManage__c = err.getMessage();
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Error, err.getMessage()));
                    }  
                }
        	}
            
            if (flag == false) {    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Confirm, 'Success insert the contact'));
            }

            //* Insert the same  CampaignMember on all CSV file contact
            Database.SaveResult[] campaignMemberList = Database.insert(campaignMemberListtoInsert, false); 
            System.debug(campaignMemberList);

            String header = 'NPI, FirstName, LastName, City, ContactStatus,campaignMemberStatus\n';
            String finalstr = header ;
            for (Contact contact: allCSVContactMap.values()) {
            
                String recordString = ''+contact.NPI__c+','+contact.FirstName+','+contact.LastName+','+contact.City__c +','+contact.StatusManage__c+'\n';
                finalstr = finalstr +recordString;
            }
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(finalstr);
            String csvname= 'Contact.csv';
            csvAttc.setFileName(csvname);
            csvAttc.setBody(csvBlob);
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            String[] toAddresses = new list<String> {'suresh.kumar@briskminds.com'};
            String subject ='Contact CSV';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody('Contact CSV ');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            //Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});        
        // }
        // catch (Exception e) {
        //     ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importing data Please make sure input csv file is correct');
        //     ApexPages.addMessage(errorMessage);
        // }
    }
}