@isTest
private class DropBoxControllerTest {
/*@isTest static void callAuthCodeTest() {
		// Implement test code

		Test.setMock(HttpCallOutMock.class, new DropBoxControllerMockTest());
		DropboxController dropBoxCon = new DropboxController();
		PageReference pagfe = page.DropboxPage;
		Test.setCurrentPageReference(pagfe);
		Test.startTest();
			dropBoxCon.callAuthCode();
			pagfe.getParameters().put('code','543543534');
			dropBoxCon.callAuthCode();
			DropboxWrapperClass.FileDetails entries = new DropboxWrapperClass.FileDetails();
			entries.name='suresh';
			entries.id='434sd';
			entries.tag='folder';
			entries.path_lower='/suresh'; 
		Test.stopTest();
	}*/

	@isTest static void accessTokenType() {
		// Implement test code
		Test.setMock(HttpCallOutMock.class, new DropBoxControllerMockTest());
        DropboxController dropBocCon = new DropboxController();
        dropBocCon.callAuthCode();
		PageReference pagfe = page.DropboxPage;
		Test.setCurrentPageReference(pagfe);
		pagfe.getParameters().put('code','543543534');
		
		test.startTest();
			Blob headerValue = Blob.valueOf('hgfh435' + ':' +' hfgh655');
			String auu = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
			DropboxWrapperClass.AccessTokenWrapper accessTokenObj = new DropboxWrapperClass.AccessTokenWrapper ();
		    accessTokenObj.access_token ='fgfdgfg';
		    dropBocCon.callAuthCode();
		test.stopTest();

	}


	@isTest static void showFolderAndFile() {
		
		Test.setMock(HttpCallOutMock.class, new DropBoxControllerMockTest());
		PageReference pagfe = page.DropboxPage;
		Test.setCurrentPageReference(pagfe);
		pagfe.getParameters().put('code','543543534');
		DropboxController dropBocCon = new DropboxController();
		test.startTest();
			dropBocCon.showFolderandFiles();
		test.stopTest();

	}


	@isTest static void deleteFolderAndFile() {
		// Implement test code
		Test.setMock(HttpCallOutMock.class, new DropBoxControllerMockTest());
		PageReference pagfe = page.DropboxPage;
		Test.setCurrentPageReference(pagfe);
		pagfe.getParameters().put('code','543543534');
		DropboxController dropBocCon = new DropboxController();
		test.startTest();
			dropBocCon.deleteFolderAndFileFuction();
		test.stopTest();

	}

	@isTest static void createFolderAndFile() {
		// Implement test code
		Test.setMock(HttpCallOutMock.class, new DropBoxControllerMockTest());
		PageReference pagfe = page.DropboxPage;
		Test.setCurrentPageReference(pagfe);
		pagfe.getParameters().put('code','543543534');
		DropboxController dropBocCon = new DropboxController();
		test.startTest();
			dropBocCon.createFloderFuction();
		test.stopTest();

	}


	@isTest static void uploadFiles() {
		// Implement test code
		Test.setMock(HttpCallOutMock.class, new DropBoxControllerMockTest());
		PageReference pagfe = page.DropboxPage;
		Test.setCurrentPageReference(pagfe);
		pagfe.getParameters().put('code','543543534');
		DropboxController dropBocCon = new DropboxController();
		test.startTest();
			Blob body = Blob.valueOf('fdgdfg');
			dropBocCon.file=body;
			DropboxWrapperClass.UploadDeleteAndCreate entries = new DropboxWrapperClass.UploadDeleteAndCreate();
			entries.name='llllll.txt';
			entries.id ='II3zn9kP53AAAAAAAAAAyg';
			dropBocCon.uploadFileFuction();
		test.stopTest();

	}

	@isTest static void breadKarmRemove() {
		// Implement test code
		Test.setMock(HttpCallOutMock.class, new DropBoxControllerMockTest());
		PageReference pagfe = page.DropboxPage;
		Test.setCurrentPageReference(pagfe);
		pagfe.getParameters().put('code','543543534');
		DropboxController dropBocCon = new DropboxController();
		test.startTest();	
			DropboxWrapperClass.WrapperForBreadKarm entries = new DropboxWrapperClass.WrapperForBreadKarm();
			entries.name='llllll';
			entries.id='4543dfgd';
			entries.path_lower='/llllll';
			dropBocCon.breadKarmRemoveFuction();
		test.stopTest();
	}
}