/* Description  : This is coustom controller for UploadCsvFiles Vfpage
* 
* Created by   : Suresh kumar
* 
* Created date : 2-jan-2019
* 
* Version      : V1.0 Created 
*/
public with sharing class UploadCsvFileControlerClass {

    public PageReference insertYourContact() {
        return null;
    }


	public Blob csvFileBody{get;set;}  //Blob class is the collection of binary data
	public string csvAsString{get;set;}
	public List<String> csvFileLines{get;set;}
	public List<Contact> conlist{get;set;}

	public UploadCsvFileControlerClass() {
		csvFileLines = new List<String>();
		conlist = New List<Contact>(); 
    }
    /**
        @description :   This methd is used to Show the record that in csv file 
     *
	 *  @args        :   No arguments
	 *
	 *  @return      :   void
	 * 
	 *  @revision Logs:   V1.0 - Suresh Kumar - 02/01/2019 - Created
	 *
     **/
	public void importCSVFile() {
    try {
		csvAsString = csvFileBody.toString();
		System.debug(csvAsString);
		csvFileLines = csvAsString.split('\n');
		Contact conObj;
		System.debug(csvFileLines);

		/*for( String csvLine : csvFileLines) {
			conObj = new Contact() ;
			System.debug(csvLine);
			conObj.FirstName__c = csvLine.split(',')[0];
			conObj.LastName = csvLine.split(',')[1];  
			conObj.MobilePhone = csvLine.split(',')[2];
			conObj.Status__c = csvLine.split(',')[3];                                                                            
			conlist.add(conObj);
			System.debug(conlist);
		}    */

           for(Integer i=1;i<csvFileLines.size();i++){
                conObj = new Contact() ;
               string[] csvRecordData = csvFileLines[i].split(',');
               conObj.FirstName__c = csvRecordData[0] ;             
               conObj.LastName = csvRecordData[1];
               conObj.MobilePhone = csvRecordData[2];
               conObj.Status__c = csvRecordData[3];   
                                                                                          
               conlist.add(conObj);   
           }
     	insert conlist;
     	System.debug(conlist);
    }

    catch (Exception e) {
		System.debug(e.getMessage());
		System.debug(e.getLineNumber());
		System.debug(e.getStackTraceString());
		System.debug(e.getCause());
		System.debug(e.getTypeName());

		ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'Error :' + e.getMessage() + '\nCause : ' + e.getCause() );
		ApexPages.addMessage(errorMessage);
    }  
    }

	public void callBatch() {
 	   BatchApexForContact contactBatch = new BatchApexForContact();
 	   Database.executeBatch(contactBatch);
	}
}