public with sharing class FatchTheRecordForSobject {
	/*public FatchTheRecordForSobject() {
		Integer a=10,b=20;
		Integer c = a+b;
		System.debug(c);
	}*/
	List<String> rigList ;
	String queryR ;
	String objName ;
	List<sObject> recordList ;
	public FatchTheRecordForSobject() {
		
		rigList = new List<String>();
		//queryR = new String();
		//objName = new String();
		recordList = new List<sObject>();
	}
	public void findTheRecord(String obj) {
		//obj = objList;
		FatchTheRecordForSobject ob = new FatchTheRecordForSobject();
		rigList.add(obj);
		ob.queryForRecord();
		System.debug(obj);
		System.debug(rigList);
		//return obj;
	}

	public void findTheObject(String obj) {
		objName = obj;
		System.debug(objName);
	}

	public void queryForRecord() {
		System.debug(rigList);
		System.debug(objName);
		queryR = 'Select Id, ' + rigList + ' from ' + objName ; //+ ' where ' + rigList + ' like \'%' + textResearch + '\'%';
		 //recordList = Database.query(queryR);
		 System.debug(queryR);
		 System.debug(recordList);
	}
	
}