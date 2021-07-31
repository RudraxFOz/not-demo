@isTest
private class TestBatchApexForContact {
	
	@isTest static void batchMethod() {
		List<Contact> conList = new List<Contact>();
		for(Integer i=1; i<=200; i++) {
			Contact con = new Contact();
			con.FirstName__c = 'fistname'+i;
			con.LastName = 'lastname'+i;
			con.MobilePhone = '345567'+i;
			con.Status__c = 'Waiting';
			conList.add(con);
		}
		insert conList;
		Test.startTest();
			BatchApexForContact obj = new BatchApexForContact();
			DataBase.executeBatch(obj);
		Test.stopTest();

	}
	
	@isTest static void test_method_two() {
		// Implement test code
	}
	
}