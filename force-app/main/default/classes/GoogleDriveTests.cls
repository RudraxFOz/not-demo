@isTest
public class GoogleDriveTests {
    
     @isTest static void breadcramTest() {
        Boolean conditinCheack = false;
        Test.setMock(HttpCalloutMock.class, new GoogleDriveMockTest());
        PageReference pageRef = Page.GoogleDriveCommunity;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','0786565');
        GoogleDriveControllerForCommunity testClassObj = new GoogleDriveControllerForCommunity() ;
        testClassObj.tokenObj = new GoogleDriveWraaperClass.BothToken();
        testClassObj.tokenObj.access_token = '34dfgf3434dfsd4343';
        testClassObj.breadcrumb = new List<GoogleDriveWraaperClass.Wrapperforbreadcrumb>();
        GoogleDriveWraaperClass.Wrapperforbreadcrumb temp= new GoogleDriveWraaperClass.Wrapperforbreadcrumb();
        
        for(Integer i=0;i<2;i++){
            temp.id='000655444'+i;
            temp.name='deep';    
            testClassObj.breadcrumb.add(temp);
        }  
       
        testClassObj.forBack();
        temp.id='00044433';
        temp.name='deep';
        testClassObj.breadcrumb.add(temp);
        testClassObj.folderid ='000343434';
        testClassObj.forBack();
    } 
    
    @isTest static void getAccesstokenTest() {
        
        Test.setMock(HttpCalloutMock.class, new GoogleDriveMockTest());
        GoogleDriveControllerForCommunity testClassObjS = new GoogleDriveControllerForCommunity() ;
        testClassObjS.googleDriveAuthCode();
        PageReference pageRef = Page.GoogleDriveCommunity;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','0786565');       
        GoogleDriveControllerForCommunity testClassObj = new GoogleDriveControllerForCommunity() ;
        test.startTest();
        	testClassObj.googleDriveAuthCode(); 
        test.stopTest();
        
        
    }
    @isTest static void deleteFileTest() {
        Boolean conditinCheack = false;
        Test.setMock(HttpCalloutMock.class, new GoogleDriveMockTest());
        PageReference pageRef = Page.GoogleDriveCommunity;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','0786565');       
        GoogleDriveControllerForCommunity testClassObj = new GoogleDriveControllerForCommunity() ;
        testClassObj.tokenObj = new GoogleDriveWraaperClass.BothToken();
        testClassObj.tokenObj.access_token = '232';
        testClassObj.deleteShowFolder(); 
        
    } 
    @isTest static void createfolderTest() {
        Boolean conditinCheack = false;
        Test.setMock(HttpCalloutMock.class, new GoogleDriveMockTest());
        PageReference pageRef = Page.GoogleDriveCommunity;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','0786565');
        GoogleDriveControllerForCommunity testClassObj = new GoogleDriveControllerForCommunity() ;
        testClassObj.tokenObj = new GoogleDriveWraaperClass.BothToken();
        testClassObj.tokenObj.access_token = '34dfgf3434dfsd4343';
        testClassObj.createNewfolder();
        
    }
     @isTest static void uploadFileTest() {
        
        Test.setMock(HttpCalloutMock.class, new GoogleDriveMockTest());
        PageReference pageRef = Page.GoogleDriveCommunity;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','0786565');
        GoogleDriveControllerForCommunity testClassObj = new GoogleDriveControllerForCommunity() ;
        testClassObj.uploadNewFile();
          
        Blob bod = Blob.valueOf('==fortest==');
        testClassObj.attacementbody=bod;
        testClassObj.uploadNewFile();
          
        testClassObj.tokenObj = new GoogleDriveWraaperClass.BothToken();
        testClassObj.tokenObj.access_token = '34dfgf3434dfsd4343';
        Blob body = Blob.valueOf('==fortest==');
        testClassObj.attacementbody=body;
        testClassObj.uploadNewFile();
        
        Blob bo = Blob.valueOf('=fortest=');
        testClassObj.attacename='=vdcv=';
        testClassObj.attacementbody=bo;
        testClassObj.uploadNewFile();
        
        Blob bo1 = Blob.valueOf('fortest');
        testClassObj.attacename='vdcv';
        testClassObj.attacementbody=bo1;
        testClassObj.uploadNewFile();
    }
    @isTest static void getAccesstokenfromRefreshtokenTest() {
        
        Test.setMock(HttpCalloutMock.class, new GoogleDriveMockTest());
        PageReference pageRef = Page.GoogleDriveCommunity;
        test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('code','0786565');
        GoogleDriveControllerForCommunity testClassObj = new GoogleDriveControllerForCommunity() ;
        Integration__c  temp=new  Integration__c();
        temp.GoogleDriveRefreshToken__c='sddf';
        temp.userid__c=Userinfo.getUserId(); 
        insert temp;
        test.startTest();
        	testClassObj.googleDriveAuthCode();
        test.stopTest();
        
    } 
}