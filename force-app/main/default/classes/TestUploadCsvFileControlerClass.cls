@isTest
private class TestUploadCsvFileControlerClass {
	static String str = 'FirstName__c,LastName,MobilePhone,Status__c\nSuresh,Kumar,7656349823,Waiting';
	public static String[] csvFileLine;
	public static Blob csvFileBody;

	@isTest static void testImportCSVFile() {
		csvFileBody = Blob.valueOf(str);
		String csvAsString = csvFileBody.toString();
		csvFileLine = csvAsString.split('\n');
		UploadCsvFileControlerClass importData = new UploadCsvFileControlerClass();
		importData.csvFileBody = csvFileBody;
		Test.startTest();
			//PageReference pageRef = new PageReference();
			importData.importCSVFile();
			importData.insertYourContact();
			importData.callBatch();
		Test.stopTest();
	}
	
	@isTest static void testImportCSVFileNe() {
		csvFileBody = Blob.valueOf(str);
		String csvAsString = csvFileBody.toString();
		csvFileLine = csvAsString.split('\n');
		UploadCsvFileControlerClass importData = new UploadCsvFileControlerClass();
		Test.startTest();
			importData.importCSVFile();
			importData.insertYourContact();
			importData.callBatch();
		Test.stopTest();
	}
	
}